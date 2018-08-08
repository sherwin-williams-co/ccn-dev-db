/**********************************************************
  SRA11000_PROCESS got failed as data type of TRAN_SEQNUM field was changed to varchar2.
  The below steps are executed to fix this issue.
  Create backup tables for MISCTRAN and OVERSHRT.
  Insert the data into backup tables.
  Drop actual tables and recreate them with the new data type.
  Insert the backup table data into actual tables.
  Delete if there is any data loaded into MISCTRAN table in todays run.
  Change the procedure to remove the to_number function on TRAN_SEQNUM field.
  Run the procedure as an anonomous block which will load the data into actual tables.
  Run scripts to generate and archive the files to ftp.

Created : 08/08/2018 jxc517 CCN Project....
Changed :
**********************************************************/
--check the error message in error_log table
SELECT * FROM ERROR_LOG WHERE TRUNC(ERROR_DATE) = TRUNC(SYSDATE) AND MODULE NOT IN ('DPST_BAGS_UPDATE_BATCH_PKG.PROCESS','DPST_TCKTS_UPDATE_BATCH_PKG.PROCESS','INTRM_DPST_TKT_PROC') ORDER BY ERROR_DATE DESC;
--check how many records are loaded into these tables in each run by running below statements.
SELECT LOAD_DATE, COUNT(*) FROM SUMMARY_EXTRCT_CNTRL_FL GROUP BY LOAD_DATE ORDER BY LOAD_DATE DESC;
SELECT LOAD_DATE, COUNT(*) FROM ACH_DRFTS_EXT_CTRL GROUP BY LOAD_DATE ORDER BY LOAD_DATE DESC;
SELECT LOAD_DATE, COUNT(*) FROM UAR_MISCTRAN GROUP BY LOAD_DATE ORDER BY LOAD_DATE DESC;
SELECT LOAD_DATE, COUNT(*) FROM MISCTRAN GROUP BY LOAD_DATE ORDER BY LOAD_DATE DESC;
SELECT LOAD_DATE, COUNT(*) FROM UAR_OVERSHRT GROUP BY LOAD_DATE ORDER BY LOAD_DATE DESC;
SELECT LOAD_DATE, COUNT(*) FROM OVERSHRT GROUP BY LOAD_DATE ORDER BY LOAD_DATE DESC;
--Creating backup tables for taking backup of MISCTRAN and OVERSHRT tables.
CREATE TABLE MISCTRAN_BKUP_8AUG2018 AS SELECT * FROM MISCTRAN;
CREATE TABLE OVERSHRT_BKUP_8AUG2018 AS SELECT * FROM OVERSHRT;
--run below select statements and make sure both actual table and backup table has same number of records.
SELECT COUNT(*) FROM MISCTRAN;
SELECT COUNT(*) FROM MISCTRAN_BKUP_8AUG2018;
SELECT COUNT(*) FROM OVERSHRT;
SELECT COUNT(*) FROM OVERSHRT_BKUP_8AUG2018;
  --drop MISCTRAN table and recreate it with the new data type.
  DROP TABLE MISCTRAN;
  CREATE TABLE MISCTRAN
   (BANK_ACCOUNT_NBR          VARCHAR2(20), 
    COST_CENTER_CODE          VARCHAR2(6), 
    AMOUNT                    NUMBER(10,2), 
    TRANSACTION_DATE          DATE, 
    TCODE                     VARCHAR2(4), 
    TRAN_SEQNUM               VARCHAR2(9), 
    DB_CR_CODE                VARCHAR2(2), 
    SNZ_SAM_CODE              VARCHAR2(3), 
    LOAD_DATE                 DATE, 
    ORIGINATED_BANK_ACCNT_NBR VARCHAR2(17)
   );
--Insert the data back in to the actual table from backup table.
INSERT INTO MISCTRAN SELECT * FROM MISCTRAN_BKUP_8AUG2018;
--delete the data loaded into uar_misctran table in todays run.
DELETE FROM UAR_MISCTRAN WHERE LOAD_DATE = '08-AUG-2018';
--delete the data loaded into misctran in todays run.
DELETE FROM MISCTRAN WHERE LOAD_DATE = '08-AUG-2018';
COMMIT;
  -- drop the overshrt table and recreate it with the new datatype
  DROP TABLE OVERSHRT;
  CREATE TABLE OVERSHRT
   (BANK_ACCOUNT_NBR          VARCHAR2(20), 
    COST_CENTER_CODE          VARCHAR2(6), 
    AMOUNT                    NUMBER(10,2), 
    TRANSACTION_DATE          DATE, 
    TCODE                     VARCHAR2(4), 
    TRAN_SEQNUM               VARCHAR2(9), 
    TRAN_CODE                 VARCHAR2(5), 
    LOAD_DATE                 DATE, 
    ORIGINATED_BANK_ACCNT_NBR VARCHAR2(17)
   );
-- load the backup table data into actual table.
INSERT INTO OVERSHRT SELECT * FROM OVERSHRT_BKUP_8AUG2018;

--Execute the below program by passing the todays date as input parameter
--removed the to_number as data type of TRAN_SEQNUM field was changed to VARCHAR2.
DECLARE
    IN_DATE            DATE = '08-AUG-2018';

    CURSOR JV_MISCTRAN IS
        SELECT COST_CENTER_CODE,
               AMOUNT,
               TO_DATE(TRANSACTION_DATE,'YYMMDD') TRANSACTION_DATE,
               TCODE,
               DISTRICT,
               AREA,
               DIVISION,
               TRAN_SEQNUM,
               DB_CR_CODE,    
               SNZ_SAM_CODE,
               IN_DATE AS LOAD_DATE,
               STR_BNK_DPST_DLY_RCNCL_PROCESS.GET_BNK_ACCNT_NBR_FOR_CC(COST_CENTER_CODE,TO_DATE(TRANSACTION_DATE,'YYMMDD')) AS ORIG_BANK_ACCOUNT_NBR,
               TO_NUMBER(LINE_NUMBER) LINE_NUMBER
          FROM TEMP_UAR_MISCTRAN MT
          ---This is done to avoid loading duplicates. We don't want to insert same record again if they sent it next day.
          ---Usually they are sending the same data with the new data for a certain time
          ---this should not be sent
         WHERE NOT EXISTS (SELECT 1
                             FROM UAR_MISCTRAN
                            WHERE COST_CENTER_CODE     = MT.COST_CENTER_CODE
                              AND TRAN_SEQNUM          = MT.TRAN_SEQNUM
                              AND NVL(TCODE, 'AAA')    = NVL(MT.TCODE,'AAA')
                              AND AMOUNT               = MT.AMOUNT
                              AND TRANSACTION_DATE     = TO_DATE(MT.TRANSACTION_DATE,'YYMMDD')
                              AND NVL(DB_CR_CODE,'X')  = NVL(MT.DB_CR_CODE,'X')
                              AND NVL(SNZ_SAM_CODE,'A')= NVL(MT.SNZ_SAM_CODE,'A'));
    V_COUNT NUMBER := 0;
    V_BANK_ACCOUNT_NBR LEAD_BANK_CC.LEAD_BANK_ACCOUNT_NBR%TYPE;
    V_SRC_BANK_ACCOUNT_NBR VARCHAR2(17);


FUNCTION GET_MISC_SRC_ACCNT_NBR(IN_LINE_NUMBER     IN      NUMBER) RETURN VARCHAR2 IS
  V_RET_VAL          VARCHAR2(17);
BEGIN
    SELECT BANK_ACCOUNT_NBR_FILE
      INTO V_RET_VAL
      FROM TEMP_UAR_MISCTRAN_HDR B
     WHERE TO_NUMBER(B.LINE_NUMBER) = (SELECT MAX(TO_NUMBER(C.LINE_NUMBER))
                                         FROM TEMP_UAR_MISCTRAN_HDR C
                                        WHERE TO_NUMBER(C.LINE_NUMBER) < IN_LINE_NUMBER);
    RETURN V_RET_VAL;
EXCEPTION
    WHEN OTHERS THEN
       RETURN V_RET_VAL;
END GET_MISC_SRC_ACCNT_NBR;

FUNCTION FORMAT_INPUT_FOR_FILE(
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

BEGIN
    FOR REC IN JV_MISCTRAN LOOP
        V_SRC_BANK_ACCOUNT_NBR := GET_MISC_SRC_ACCNT_NBR(REC.LINE_NUMBER);
        INSERT INTO UAR_MISCTRAN VALUES (REC.COST_CENTER_CODE,
                                         REC.AMOUNT,
                                         REC.TRANSACTION_DATE,
                                         REC.TCODE,
                                         REC.DISTRICT,
                                         REC.AREA,
                                         REC.DIVISION,
                                         REC.TRAN_SEQNUM,
                                         REC.DB_CR_CODE,    
                                         REC.SNZ_SAM_CODE,
                                         REC.LOAD_DATE,
                                         V_SRC_BANK_ACCOUNT_NBR);

        IF (V_SRC_BANK_ACCOUNT_NBR = '00000004600146239' AND REC.TCODE = '2551')
            OR (V_SRC_BANK_ACCOUNT_NBR = '00000004600146212' AND REC.TCODE = '2550') THEN
            V_BANK_ACCOUNT_NBR := V_SRC_BANK_ACCOUNT_NBR;
        ELSE
           V_BANK_ACCOUNT_NBR := FORMAT_INPUT_FOR_FILE(REPLACE(REC.ORIG_BANK_ACCOUNT_NBR,'-'), '0', 17);
        END IF;
        INSERT INTO MISCTRAN VALUES (V_BANK_ACCOUNT_NBR,
                                     STR_BNK_DPST_DLY_RCNCL_PROCESS.COST_CENTER_LOOK_UP_FNC(LTRIM(RTRIM(REC.COST_CENTER_CODE))),
                                     REC.AMOUNT/100,
                                     REC.TRANSACTION_DATE,
                                     REC.TCODE,
                                     TO_NUMBER(REC.TRAN_SEQNUM),
                                     REC.DB_CR_CODE,
                                     REC.SNZ_SAM_CODE,
                                     REC.LOAD_DATE,
                                     V_SRC_BANK_ACCOUNT_NBR);
        V_COUNT := V_COUNT +1;
        IF V_COUNT = 1000 THEN
            COMMIT;
            V_COUNT := 0;
        END IF;
    END LOOP;
    COMMIT;
    STR_BNK_DPST_DLY_RCNCL_PROCESS.GNRTE_BNK_ACT_MISMTH_RPT('MISCTRAN',IN_DATE,'MISCTRAN_BNK_ACT_MISMTH_RPT');
END;


DECLARE
    IN_DATE            DATE := '08-AUG-2018';
    
    CURSOR main_cur IS
        SELECT CC.COST_CENTER_CODE,
               CC.COST_CENTER_NAME,
               HDV.DIVISION,
               HDV.AREA,
               HDV.DISTRICT
          FROM COST_CENTER CC,
               HIERARCHY_DETAIL_VIEW HDV
         WHERE CC.COST_CENTER_CODE = HDV.COST_CENTER_CODE
           AND HDV.HRCHY_HDR_NAME = 'GLOBAL_HIERARCHY'
           AND CC.CATEGORY IN ('S','O')
           AND NVL(CC.CLOSE_DATE + 183, TRUNC(IN_DATE)) >= TRUNC(IN_DATE);

    V_LEAD_BANK_CC_REC LEAD_BANK_CC%ROWTYPE;
    V_BANK_ACCOUNT_REC BANK_ACCOUNT%ROWTYPE;
    V_COUNT            NUMBER := 0;
    V_DATE             DATE;
    V_RUNDATE          DATE;

FUNCTION GET_RUNDATE(IN_DATE         IN         DATE) RETURN DATE IS
    V_RETURN_VALUE      DATE := IN_DATE;
BEGIN
    SELECT MAX(LOAD_DATE)-1
      INTO V_RETURN_VALUE
      FROM SUMMARY_EXTRCT_CNTRL_FL
     WHERE LOAD_DATE < IN_DATE;

    RETURN V_RETURN_VALUE;
EXCEPTION
    WHEN OTHERS THEN
        RETURN V_RETURN_VALUE;
END GET_RUNDATE;

PROCEDURE GET_LEAD_BANK_ACCOUNT_REC(
IN_BANK_ACCOUNT_NBR       IN     VARCHAR2,
IN_DATE                   IN     DATE,
OUT_LEAD_BANK_RECORD         OUT BANK_ACCOUNT%ROWTYPE)
IS
    CURSOR bank_account IS
      SELECT A.*
        FROM (SELECT * FROM BANK_ACCOUNT
               UNION
              SELECT * FROM BANK_ACCOUNT_HIST) A
       WHERE BANK_ACCOUNT_NBR = IN_BANK_ACCOUNT_NBR
         AND TRUNC(EFFECTIVE_DATE) <= IN_DATE
         AND NVL(TRUNC(EXPIRATION_DATE), TRUNC(SYSDATE)) >= IN_DATE
       ORDER BY EFFECTIVE_DATE DESC, UPDATE_DATE DESC;
       --ordering by update date as well as we want the latest record first
       --will exit after taking the first record
BEGIN
    --Below loop uses the cursor that orders the results by effective date (recent) and update date (recent)
    --we might have multiple records from above cursor
    --we can have account detail updated and that will be pushed to history and need to take the latest record
    FOR rec IN bank_account LOOP
        --Take the first record and exit out
        OUT_LEAD_BANK_RECORD := rec;
        EXIT;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Should never come here, never ever!!!!');
END GET_LEAD_BANK_ACCOUNT_REC;

FUNCTION GET_CC_TRANDATE(
IN_DATE         IN         DATE,
IN_COST_CENTER  IN         VARCHAR2)
RETURN DATE
IS
    V_RETURN_VALUE      DATE;
BEGIN
    SELECT MAX(TRANSACTION_DATE)
      INTO V_RETURN_VALUE
      FROM (SELECT TRANSACTION_DATE
              FROM SUMMARY_EXTRCT_CNTRL_FL
             WHERE LOAD_DATE = IN_DATE
               AND SUBSTR(COST_CENTER_CODE,-4) = IN_COST_CENTER
             UNION
            SELECT TRANSACTION_DATE
              FROM ACH_DRFTS_EXT_CTRL
             WHERE LOAD_DATE = IN_DATE
               AND SUBSTR(COST_CENTER_CODE,-4) = IN_COST_CENTER
             UNION
            SELECT TRANSACTION_DATE
              FROM MISCTRAN
             WHERE LOAD_DATE = IN_DATE
               AND SUBSTR(COST_CENTER_CODE,-4) = IN_COST_CENTER);

    RETURN V_RETURN_VALUE;
EXCEPTION
    WHEN OTHERS THEN
        RETURN NULL;
END GET_CC_TRANDATE;

BEGIN
    V_RUNDATE := GET_RUNDATE(IN_DATE);
    EXECUTE IMMEDIATE 'TRUNCATE TABLE STR_BNK_DPST_DLY_RCNCL_TBL';
    --Loop through all the store/other category cost centers that are open currently (or) closed in last 6 months
    FOR rec IN main_cur LOOP
        V_LEAD_BANK_CC_REC := NULL;
        V_BANK_ACCOUNT_REC := NULL;
        V_COUNT            := V_COUNT + 1;
        V_DATE             := NVL(GET_CC_TRANDATE(IN_DATE,SUBSTR(rec.COST_CENTER_CODE,3)),V_RUNDATE);
        --Get the lead bank record for the store
        STR_BNK_DPST_DLY_RCNCL_PROCESS.GET_LEAD_BANK_RECORD(SUBSTR(rec.COST_CENTER_CODE,3),
                             V_DATE,
                             V_LEAD_BANK_CC_REC);
        --Passed cost center not a lead/independent nor a member => should go into error report
        IF V_LEAD_BANK_CC_REC.LEAD_BANK_ACCOUNT_NBR IS NULL THEN
           DBMS_OUTPUT.PUT_LINE('SRA10040 Error Report : ' || rec.COST_CENTER_CODE || ' : concentration not found');
        ELSE
            --Lead is different from looping store => looping store is a member store
           IF V_LEAD_BANK_CC_REC.LEAD_STORE_NBR <> rec.COST_CENTER_CODE THEN
              V_LEAD_BANK_CC_REC.BANK_TYPE_CODE := 'M';
           END IF;
           --Get the bank account details for the lead store
           GET_LEAD_BANK_ACCOUNT_REC(V_LEAD_BANK_CC_REC.LEAD_BANK_ACCOUNT_NBR,
                                     V_DATE,
                                     V_BANK_ACCOUNT_REC);
           --Further processing continues only if the bank account is under auto reconciliation
           IF NVL(V_BANK_ACCOUNT_REC.BANK_AUTO_RECON_IND,'N') = 'Y' THEN
              --Auto reconciliation date should be maximum of effective date, reconciliatrion start date
              IF V_BANK_ACCOUNT_REC.EFFECTIVE_DATE >= V_BANK_ACCOUNT_REC.RECON_START_DATE THEN
                 V_BANK_ACCOUNT_REC.RECON_START_DATE := V_BANK_ACCOUNT_REC.EFFECTIVE_DATE;
              END IF;
           ELSE
              DBMS_OUTPUT.PUT_LINE(rec.COST_CENTER_CODE || ' : not part of AUTO RECONCILIATION');
           END IF;
        END IF;
        --Lead Store Number should be passed back only if it is a member stores
        IF V_LEAD_BANK_CC_REC.BANK_TYPE_CODE IN ('L', 'I') THEN
            V_LEAD_BANK_CC_REC.LEAD_STORE_NBR := NULL;
        END IF;
        --Push the data into STR_BNK_DPST_DLY_RCNCL_TBL table [SMIS1.TMP.SRA10061 for MARK-IV table (SRA10001)]
        INSERT INTO STR_BNK_DPST_DLY_RCNCL_TBL VALUES (rec.COST_CENTER_CODE,
                                                       NVL(V_BANK_ACCOUNT_REC.BANK_ACCOUNT_NBR, 'NOT_AVAILABLE'),
                                                       rec.COST_CENTER_NAME,
                                                       V_BANK_ACCOUNT_REC.BANK_NAME,
                                                       V_BANK_ACCOUNT_REC.RECON_START_DATE,
                                                       V_BANK_ACCOUNT_REC.BANK_AUTO_RECON_IND,
                                                       V_LEAD_BANK_CC_REC.LEAD_STORE_NBR,
                                                       V_LEAD_BANK_CC_REC.BANK_TYPE_CODE,
                                                       rec.DIVISION,
                                                       rec.AREA,
                                                       rec.DISTRICT);
        IF V_COUNT > 1000 THEN
            COMMIT;
        END IF;
    END LOOP;
    COMMIT;
END;
--run below shell scripts to generate UAR serial file and POS file.
cd /app/banking
./SRA11000_generate_files.sh

banking@stap3ccnphq:~$ cd /app/banking
banking@stap3ccnphq:/app/banking$ ./SRA11000_generate_files.sh
Processing Started for SRA11000_generate_files at 07:38:10 on 08/08/2018
Processing started for STR_BNK_DPST_DLY_RCNCL_PROCESS.GENERATE_FILES at 07:38:10 on 08/08/2018
Processing Started for STR_BNK_DPST_DLY_RCNCL_PROCESS.GENERATE_FILES('08-AUG-2018'); at 07:38:10 on 08/08/2018
GENERATE_UAR_SERIAL_FILE : 185.73 Seconds
GENERATE_UAR_POS_FILE : 11.08 Seconds
GNRTE_NO_CONCERNTRATION_RPT : 11.11 Seconds

PL/SQL procedure successfully completed.

Processing finished for STR_BNK_DPST_DLY_RCNCL_PROCESS.GENERATE_FILES('08-AUG-2018'); at 07:41:27 on 08/08/2018
Processing finished for SRA11000_generate_files at 07:41:27 on 08/08/2018

./SRA11000_Archconcat_file.sh
./SRA11000_dailyRun_ftp.sh
./SRA11000_Arch_Output_file.sh
--run below select statement and validate the data
SELECT * FROM MISCTRAN_DETAILS WHERE LOAD_DATE = '08-AUG-2018';
SELECT * FROM MISCTRAN_PRIMESUB WHERE LOAD_DATE = '08-AUG-2018';
