SET SERVEROUTPUT ON;
create or replace PACKAGE SRA IS
PROCEDURE PROCESS(IN_DATE DATE,V_RUN_CYCLE NUMBER);
END;
/
create or replace PACKAGE BODY SRA IS

L_DATE DATE;

FUNCTION FORMAT_INPUT_FOR_FILE(
/*****************************************************************************
	This function will return the formatted data as requested  

Created : 06/19/2015 jxc517 CCN Project....
Changed : 07/24/2017 nxk927 CCN Project....
          fixed a issue with the decimal place when it was in the first position
        : 08/03/2017 nxk927 CCN Project....
          using the same function from utility so it can be easily maintained.
*****************************************************************************/
IN_VALUE         IN VARCHAR2,
IN_PADDING_VALUE IN VARCHAR2,
IN_LENGTH        IN NUMBER,
IN_PRECISION     IN NUMBER DEFAULT 0
) RETURN VARCHAR2
IS
    V_RETURN_VALUE      VARCHAR2(32000);
BEGIN
    V_RETURN_VALUE:= CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(IN_VALUE,
                                                            IN_PADDING_VALUE,
                                                            IN_LENGTH,
                                                            IN_PRECISION);
    RETURN V_RETURN_VALUE;
EXCEPTION
    WHEN OTHERS THEN
        RETURN NULL;
END FORMAT_INPUT_FOR_FILE;

PROCEDURE GENERATE_HEADER(
/******************************************************************************
  This procedure generates Header for UAR POS files
  as part of SRA10500 process

Created : 01/28/2015 nxk927/dxv848 CCN Project....
Changed :
*******************************************************************************/
IN_BANK_ACCOUNT_NBR IN    VARCHAR2,
OUT_HEADER            OUT CLOB)
IS
BEGIN
    OUT_HEADER := '0' ||                                                       --SER-FLAG (1)
                  FORMAT_INPUT_FOR_FILE(' ', ' ', 51) ||                       --FIELD-1, 2, 3 (17 + 17 + 17 spaces)
                  FORMAT_INPUT_FOR_FILE(IN_BANK_ACCOUNT_NBR, '0', 17) ||       --BANK-ACCOUNT-NBR (17)
                  'P' ||                                                       --SOURCE (1)
                  TO_CHAR(SYSDATE,'RRMMDDHH24MISS') ||                         --DATE (6) +  TIME (6)
                  FORMAT_INPUT_FOR_FILE(' ', ' ', 153) ||                      --PARALLEL (3)+ FILLER (150)
                  CHR(13);
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END GENERATE_HEADER;

PROCEDURE GENERATE_TRAILER(
/******************************************************************************
  This procedure generates trailer for UAR POS files
  as part of SRA10500 process

Created : 01/28/2015 nxk927/dxv848 CCN Project....
Changed :
*******************************************************************************/
IN_UAR_POS_FLAG IN     VARCHAR2,
IN_AMOUNT       IN     NUMBER,
OUT_TRAILER        OUT CLOB)
IS
    V_CFS_SIGN VARCHAR2(1) := '-';
BEGIN
    IF IN_AMOUNT >= 0 THEN
        V_CFS_SIGN := '+';
    END IF;
    IF IN_UAR_POS_FLAG = 'Y'  THEN
        OUT_TRAILER := '9' ||                                             --SER-FLAG (1)
                       FORMAT_INPUT_FOR_FILE('0', '0', 14) ||             --BEG-BALANCE (14)
                       '+' ||                                             --BEG-BALANCE-SIGN (1)
                       FORMAT_INPUT_FOR_FILE('0', '0', 14) ||             --END-BALANCE (14)
                       '+' ||                                             --END-BALANCE-SIGN (1)
                       FORMAT_INPUT_FOR_FILE(' ', ' ', 204)||             --FILLER (204 spaces)
                       CHR(13);
    ELSE
        OUT_TRAILER := '9' ||                                             --SER-FLAG (1)
                       FORMAT_INPUT_FOR_FILE('0', '0', 14) ||             --BEG-BALANCE (14)
                       '+' ||                                             --BEG-BALANCE-SIGN (1)
                       FORMAT_INPUT_FOR_FILE(ABS(IN_AMOUNT), '0', 14) ||  --END-BALANCE (14)
                       V_CFS_SIGN ||                                      --END-BALANCE-SIGN (1)
                       FORMAT_INPUT_FOR_FILE(' ', ' ', 204) ||            --FILLER (204 spaces)
                       CHR(13);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END GENERATE_TRAILER;

PROCEDURE GNRT_UAR_POS_BNK_DPST_ACH_FILE(
IN_BANK_ACCOUNT_NBR     IN     VARCHAR2,
IN_DATE                 IN     DATE,
IO_UAR_POSITION_OTPT_FL IN OUT UTL_FILE.FILE_TYPE)
IS
    CURSOR pos_cur IS
          SELECT *
            FROM (SELECT NVL(SUBSTR(A.COST_CENTER_CODE,-4), ' ') COST_CENTER_CODE,
                         A.TRANSACTION_DATE,
                         NVL(A.BANK_DEP_AMT, '0') BANK_DEP_AMT,
                         '0020' TCODE,
                         BANK_ACCOUNT_NBR
                    FROM SUMMARY_EXTRCT_CNTRL_FL A
                   WHERE A.BANK_ACCOUNT_NBR = IN_BANK_ACCOUNT_NBR
                     AND A.LOAD_DATE >= L_DATE)
           ORDER BY COST_CENTER_CODE;

	  V_DIVISION            VARCHAR2(10);
    V_AREA                VARCHAR2(10);
    V_DISTRICT            VARCHAR2(10);
    V_OUT_CLOB            CLOB;
    V_COUNT               NUMBER := 0;
    OUT_TRAILER           CLOB;
    OUT_HEADER            CLOB;
    V_FLAG                VARCHAR2(1) := 'Y';
BEGIN
    FOR rec IN pos_cur LOOP
        --Header
        --writing the header for the first time per bank account.
        --then the body for all the cost center under the same bank account number
        IF V_FLAG = 'Y' THEN
            GENERATE_HEADER(rec.BANK_ACCOUNT_NBR,OUT_HEADER);
            V_OUT_CLOB := V_OUT_CLOB || OUT_HEADER;

            IF V_OUT_CLOB <> EMPTY_CLOB() THEN
                UTL_FILE.PUT_LINE(IO_UAR_POSITION_OTPT_FL, V_OUT_CLOB, TRUE);
                V_OUT_CLOB := NULL;
                OUT_HEADER := NULL;
            END IF;
            V_FLAG := 'N';
        END IF;

        BANKING_COMMON_TOOLS.GET_DAD_FOR_COST_CENTER(rec.COST_CENTER_CODE, V_DIVISION, V_AREA, V_DISTRICT);
        V_COUNT := V_COUNT +1;
        V_OUT_CLOB := V_OUT_CLOB ||
                          '1' ||                                                                    --SER-FLAG (1)
                          FORMAT_INPUT_FOR_FILE(' ', ' ', 17) ||                                    --FIELD-4 (17)
                          '0' ||                                                                    --STORE-NBR-PFX (1)
                          RPAD(rec.COST_CENTER_CODE, 16, ' ') ||                                    --STORE-NBR(4 + 12 spaces)
                          FORMAT_INPUT_FOR_FILE(rec.BANK_DEP_AMT, '0', 12,2) ||                       --AMOUNT (12)
                          FORMAT_INPUT_FOR_FILE(TO_CHAR(rec.TRANSACTION_DATE,'YYMMDD'), '0', 6) ||  --TRAN-DATE YYMMDD (2 + 2 + 2)
                          RPAD(rec.TCODE, 4, ' ') ||                                                --TRAN-CODE (4)
                          FORMAT_INPUT_FOR_FILE(' ', ' ', 4) ||                                     --FILLER (4 spaces)
                          RPAD(NVL(V_DIVISION,' '), 17, ' ') ||                                     --DIVISION-NBR (2 + 15 spaces)
                          RPAD(NVL(V_AREA,' '), 17, ' ') ||                                         --AREA-NBR (2 + 15 spaces)
                          RPAD(NVL(V_DISTRICT,' '), 40, ' ') ||                                     --DISTRICT-NBR (2 + 38 spaces)
                          FORMAT_INPUT_FOR_FILE(' ', ' ', 100) ||                                   --FILLER (40 + 60 spaces)
                          CHR(13);
        IF V_OUT_CLOB <> EMPTY_CLOB() THEN
            UTL_FILE.PUT_LINE(IO_UAR_POSITION_OTPT_FL, V_OUT_CLOB, TRUE);
            V_OUT_CLOB := NULL;
        END IF;
    END LOOP;
    --Trailer
    --writing trailer for the bank account.
    IF V_COUNT <> 0 THEN
        GENERATE_TRAILER('Y', NULL,OUT_TRAILER);
        V_OUT_CLOB := V_OUT_CLOB || OUT_TRAILER;

        IF V_OUT_CLOB <> EMPTY_CLOB() THEN
            UTL_FILE.PUT_LINE(IO_UAR_POSITION_OTPT_FL, V_OUT_CLOB, TRUE);
            V_OUT_CLOB := NULL;
            OUT_TRAILER:= NULL;
        END IF;
    END IF;
END GNRT_UAR_POS_BNK_DPST_ACH_FILE;

PROCEDURE GENERATE_UAR_POS_FILE(IN_DATE            IN         DATE)
IS
    CURSOR ach_cur IS
        SELECT DISTINCT BANK_ACCOUNT_NBR
          FROM SUMMARY_EXTRCT_CNTRL_FL
         WHERE LOAD_DATE >= L_DATE;

    PATH                  VARCHAR2(50) := 'BANKING_LOAD_FILES';
    UAR_POSITION_FL_NM    VARCHAR2(50) := 'SMIS1.SRA12060_' ||
                                         TO_CHAR(IN_DATE,'DDMONRRRR') || '_' ||
                                         TO_CHAR(SYSDATE,'HH24MISS');
    UAR_POSITION_OTPT_FL  UTL_FILE.FILE_TYPE;
BEGIN
    UAR_POSITION_OTPT_FL := UTL_FILE.FOPEN (PATH
                                           ,UAR_POSITION_FL_NM
                                           ,'W' --BINARY
                                           ,32767);
    --Push the data into SMIS1.SRA12060(+1) file
    FOR ach_rec IN ach_cur LOOP
        ---writing the UAR_POS_BNK_DPST_ACH part  first(Header, body ,trailer)
        GNRT_UAR_POS_BNK_DPST_ACH_FILE(ach_rec.BANK_ACCOUNT_NBR, IN_DATE, UAR_POSITION_OTPT_FL);
    END LOOP;
    UTL_FILE.FCLOSE(UAR_POSITION_OTPT_FL);
END GENERATE_UAR_POS_FILE;

PROCEDURE PROCESS(IN_DATE DATE,V_RUN_CYCLE NUMBER) IS

CURSOR SUM_CUR IS
    SELECT STORE_NO STORENBR,
           SUM(BANK_DEP_BATCH) BANK_DEP_AMT,
           STR_BNK_DPST_DLY_RCNCL_PROCESS.GET_BNK_ACCNT_NBR_FOR_CC(STORE_NO,POS_TRAN_DT) AS BANK_ACCOUNT_NBR,
           POS_TRAN_DT TRANSACTION_DATE,
           RLS_RUN_CYCLE,
           SYSDATE AS LOAD_DATE
      FROM PNP.CCN_BATCH_SUMMARY SM
     WHERE RLS_RUN_CYCLE = V_RUN_CYCLE
       AND BANK_DEP_BATCH <> '0'
     GROUP BY STORE_NO,POS_TRAN_DT,RLS_RUN_CYCLE;

     V_COUNT NUMBER := 0;
     V_COUNT1 NUMBER := 0;
     V_LEAD_BANK_CC_REC LEAD_BANK_CC%ROWTYPE;

    PATH                  VARCHAR2(50) := 'BANKING_LOAD_FILES';
    UAR_POSITION_FL_NM    VARCHAR2(50) := 'SMIS1.SRA12060_' ||
                                         TO_CHAR(IN_DATE,'DDMONRRRR') || '_' ||
                                         TO_CHAR(SYSDATE,'HH24MISS');
    UAR_POSITION_OTPT_FL  UTL_FILE.FILE_TYPE;

BEGIN
    L_DATE := SYSDATE;
    DBMS_OUTPUT.PUT_LINE(L_DATE);
    FOR REC IN SUM_CUR LOOP
        V_COUNT1 := 0;
        SELECT COUNT(*)
          INTO V_COUNT1
          FROM BANK_ACCOUNT
         WHERE BANK_ACCOUNT_NBR    = REC.BANK_ACCOUNT_NBR
           AND BANK_AUTO_RECON_IND = 'Y';

        IF V_COUNT1 <> 0 THEN
           REC.BANK_ACCOUNT_NBR := FORMAT_INPUT_FOR_FILE(REPLACE(REC.BANK_ACCOUNT_NBR,'-'), '0', 17);

           INSERT INTO SUMMARY_EXTRCT_CNTRL_FL VALUES (STR_BNK_DPST_DLY_RCNCL_PROCESS.COST_CENTER_LOOK_UP_FNC(LTRIM(RTRIM(REC.STORENBR))),
                                                       '1',
                                                       REC.BANK_DEP_AMT,
                                                       REC.BANK_ACCOUNT_NBR,
                                                       REC.TRANSACTION_DATE,
                                                       REC.LOAD_DATE,
                                                       REC.BANK_ACCOUNT_NBR);
        END IF;

        V_COUNT := V_COUNT +1;
        IF V_COUNT = 1000 then
            COMMIT;
            V_COUNT := 0;
        END IF;
    END LOOP;
    COMMIT;
    GENERATE_UAR_POS_FILE(IN_DATE);
END PROCESS;
END;
/

SET SERVEROUTPUT ON;
EXEC SRA.PROCESS('26-SEP-2017',1324);
--production
--EXEC SRA.PROCESS('03-OCT-2017',1333);
SELECT * FROM SUMMARY_EXTRCT_CNTRL_FL WHERE LOAD_DATE > TO_DATE('03-OCT-2017 13:00:00','DD-MON-YYYY HH24:MI:SS');

DROP PACKAGE SRA;