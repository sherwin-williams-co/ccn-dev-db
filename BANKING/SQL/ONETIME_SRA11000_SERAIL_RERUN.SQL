/*
Created := nxk927 CCN project
           one time scrript to create the temp table and load the data.
		   generate the file using the temp table
*/

DECLARE
TEMP_TABLE VARCHAR2(500);
BEGIN
TEMP_TABLE := 'CREATE TABLE STR_BNK_DPST_DLY_RCNCL_TBL_RR AS
                        SELECT * 
                          FROM STR_BNK_DPST_DLY_RCNCL_TBL
                         WHERE 1=2';
    EXECUTE IMMEDIATE TEMP_TABLE;
END;
/
DECLARE
IN_DATE DATE := TRUNC(SYSDATE);
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
           
    CURSOR main_cur1 IS
        SELECT *
          FROM STR_BNK_DPST_DLY_RCNCL_TBL_RR
         WHERE RECONCILIATION_IND = 'Y'
           AND BANK_ACCOUNT_NBR   <> 'NOT_AVAILABLE'
         ORDER BY COST_CENTER_CODE;

    PATH                 VARCHAR2(50) := 'BANKING_LOAD_FILES';
    UAR_SERIAL_FL_NM     VARCHAR2(50) := 'SMIS1.SRA10060_' ||
                                         TO_CHAR(IN_DATE,'DDMONRRRR') || '_' ||
                                         TO_CHAR(SYSDATE,'HH24MISS');
    UAR_SERIAL_OTPT_FL   UTL_FILE.FILE_TYPE;

    V_ADDRESS_REC      ADDRESS_VW%ROWTYPE;
    V_PHONE_REC        CCN_PHONE_INFO_VW%ROWTYPE;
    V_OUT_CLOB         CLOB;

    V_LEAD_BANK_CC_REC LEAD_BANK_CC%ROWTYPE;
    V_BANK_ACCOUNT_REC BANK_ACCOUNT%ROWTYPE;
    V_COUNT            NUMBER := 0;
    V_DATE             DATE;
    V_RUNDATE          DATE;
    TEMP_TABLE         VARCHAR2(500);

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

    PROCEDURE GET_LEAD_BANK_RECORD(
    /******************************************************************************
      This procedure gets the lead bank record for the cost center passed in

    Created : 06/22/2015 jxc517 CCN Project....
    Changed : Parameter IN_COST_CENTER_CODE should be passed as 4 characters. If 6 characters
              use substr(cc,3)
    Changed : 06/20/2017 jxc517/nxk927 CCN Project....
              Added IN_DATE parameter
              Added condition to get the lead bank account number as of the Bank Deposit Day
    Changed : 07/27/2017 nxk927 CCN Project....
              Removed the delay date condition as we are Passing the transaction date
              to get the bank account number rather than the in_date
            : 07/28/2017 nxk927 CCN Project....
              added equal to or greated than condition for the expiration filer
            : 08/16/2017 nxk927 CCN Project....
              Changed the query to get the latest lead record based on passed cost center and
              the in_date
    *******************************************************************************/
    IN_COST_CENTER_CODE       IN     VARCHAR2,
    IN_DATE                   IN     DATE,
    OUT_LEAD_BANK_RECORD         OUT LEAD_BANK_CC%ROWTYPE)
    IS
    BEGIN
        --(assuming its a member)Get the lead for the passed cost center
        BEGIN
            SELECT LEAD_STORE_NBR
              INTO OUT_LEAD_BANK_RECORD.LEAD_STORE_NBR
              FROM (SELECT A.*,
                           RANK() OVER (ORDER BY EFFECTIVE_DATE DESC) RN
                      FROM (SELECT * FROM MEMBER_BANK_CC
                             UNION
                            SELECT * FROM MEMBER_BANK_CC_HIST) A
                     WHERE SUBSTR(MEMBER_STORE_NBR,3) = IN_COST_CENTER_CODE
                       AND TRUNC(EFFECTIVE_DATE) <= IN_DATE
                       AND NVL(TRUNC(EXPIRATION_DATE), TRUNC(SYSDATE)) >= IN_DATE)
             WHERE RN = 1;
        EXCEPTION
            WHEN OTHERS THEN
                NULL;
        END;
        --get the lead details(if its not member NVL makes the passed cost center the lead)
        BEGIN
            SELECT LEAD_BANK_ACCOUNT_NBR,
                   LEAD_STORE_NBR,
                   EFFECTIVE_DATE,
                   EXPIRATION_DATE,
                   BANK_BRANCH_NBR,
                   BANK_TYPE_CODE,
                   UPDATE_DATE,
                   LAST_UPD_USER_ID
              INTO OUT_LEAD_BANK_RECORD
              FROM (SELECT A.*,
                           RANK() OVER (ORDER BY EFFECTIVE_DATE DESC) RN
                      FROM (SELECT * FROM LEAD_BANK_CC
                             UNION
                            SELECT * FROM LEAD_BANK_CC_HIST) A
                     WHERE SUBSTR(LEAD_STORE_NBR,3) = NVL(SUBSTR(OUT_LEAD_BANK_RECORD.LEAD_STORE_NBR,3), IN_COST_CENTER_CODE)
                       AND TRUNC(EFFECTIVE_DATE) <= IN_DATE
                       AND NVL(TRUNC(EXPIRATION_DATE), TRUNC(SYSDATE)) >= IN_DATE)
             WHERE RN = 1;
        EXCEPTION
            WHEN OTHERS THEN
                NULL;
        END;
    END GET_LEAD_BANK_RECORD;

    PROCEDURE GET_LEAD_BANK_ACCOUNT_REC(
    /******************************************************************************
      This procedure gets the lead bank account for the lead bank account number passed in

    Created : 06/22/2015 jxc517 CCN Project....
    Changed : 06/20/2017 jxc517/nxk927 CCN Project....
              Added IN_DATE parameter
              Added condition to get the lead bank account number as of the Bank Deposit Day
    Changed : 07/27/2017 nxk927 CCN Project....
              Removed the delay date condition as we are Passing the transaction date
              to get the bank account number rather than the in_date
            : 07/28/2017 nxk927 CCN Project....
              added equal to or greated than condition for the expiration filer
            : 08/16/2017 nxk927 CCN Project....
              Changed the query to get the latest bank record based on passed cost center and
              the in_date
    *******************************************************************************/
    IN_BANK_ACCOUNT_NBR       IN     VARCHAR2,
    IN_DATE                   IN     DATE,
    OUT_LEAD_BANK_RECORD         OUT BANK_ACCOUNT%ROWTYPE)
    IS
    BEGIN
        SELECT BANK_ACCOUNT_NBR,
               EFFECTIVE_DATE,
               EXPIRATION_DATE,
               BANK_NAME,
               BOOK_KEEPER_NBR,
               BANK_AUTO_RECON_IND,
               RECON_START_DATE,
               RECON_BANK_ACCOUNT_NBR,
               JV_BOOK_KEEPER_REF,
               JV_BANK_SHORT_NAME,
               IDI_BOOKKEEPER_REF,
               IDI_BANK_SHORT_NAME,
               ROUTING_NBR,
               UPDATE_DATE,
               LAST_UPD_USER_ID
          INTO OUT_LEAD_BANK_RECORD
          FROM (SELECT A.*,
                       RANK() OVER (ORDER BY EFFECTIVE_DATE DESC) RN
                  FROM (SELECT * FROM BANK_ACCOUNT
                         UNION
                        SELECT * FROM BANK_ACCOUNT_HIST) A
                 WHERE BANK_ACCOUNT_NBR = IN_BANK_ACCOUNT_NBR
                   AND TRUNC(EFFECTIVE_DATE) <= IN_DATE
                   AND NVL(TRUNC(EXPIRATION_DATE), TRUNC(SYSDATE)) >= IN_DATE)
         WHERE RN = 1;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Should never come here, never ever!!!!');
    END GET_LEAD_BANK_ACCOUNT_REC;

    FUNCTION GET_CC_TRANDATE(
    /******************************************************************************
      This function will get the date for the days load we want to get the bank account
      information.

    Created : 08/25/2017 nxk927 CCN Project....
    Changed :
    *******************************************************************************/
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

    FUNCTION GET_RUNDATE(
    /******************************************************************************
      This function will get the run date for the day we want to get the bank account
      information.

    Created : 08/25/2017 nxk927 CCN Project....
    Changed :
    *******************************************************************************/
    IN_DATE         IN         DATE)
    RETURN DATE
    IS
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
    
    BEGIN
    V_RUNDATE := GET_RUNDATE(IN_DATE);
    
    --Loop through all the store/other category cost centers that are open currently (or) closed in last 6 months
    FOR rec IN main_cur LOOP
        V_LEAD_BANK_CC_REC := NULL;
        V_BANK_ACCOUNT_REC := NULL;
        V_COUNT            := V_COUNT + 1;
        V_DATE             := NVL(GET_CC_TRANDATE(IN_DATE,SUBSTR(rec.COST_CENTER_CODE,3)),V_RUNDATE);
        --Get the lead bank record for the store
        GET_LEAD_BANK_RECORD(SUBSTR(rec.COST_CENTER_CODE,3),
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
        INSERT INTO STR_BNK_DPST_DLY_RCNCL_TBL_RR VALUES (rec.COST_CENTER_CODE,
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
    BEGIN
    UAR_SERIAL_OTPT_FL := UTL_FILE.FOPEN (PATH
                                          ,UAR_SERIAL_FL_NM
                                          ,'W' --BINARY
                                          ,32767);
    FOR rec IN main_cur1 LOOP
        V_ADDRESS_REC := NULL;
        V_PHONE_REC   := NULL;
        --Push the data into SMIS1.SRA10060(+1) file
        BANKING_COMMON_TOOLS.GET_ADDRESS_RECORD(rec.COST_CENTER_CODE,
                                                V_ADDRESS_REC);
        BANKING_COMMON_TOOLS.GET_PHONE_RECORD(rec.COST_CENTER_CODE,
                                              V_PHONE_REC);
        V_OUT_CLOB := '5' ||                                                                                --SER-FLAG (1)
                      '0' ||                                                                                --STORE-NBR-PFX (1)
                      RPAD(NVL(SUBSTR(rec.COST_CENTER_CODE, 3), ' '), 16, ' ') ||                           --STORE-NBR (4 + 12 spaces)
                      RPAD(NVL(rec.COST_CENTER_NAME, ' '), 35, ' ') ||                                      --STORE-NAME (35)
                      FORMAT_INPUT_FOR_FILE(' ', ' ', 56) ||                                                --FILLER (5 + 17 + 17 + 17 spaces)
                      FORMAT_INPUT_FOR_FILE(NVL(REPLACE(rec.BANK_ACCOUNT_NBR,'-'), ' '), 0, 17) ||          --BANK-ACCOUNT-NBR (17)
                      RPAD(NVL(rec.DIVISION, ' '), 17, ' ') ||                                              --DIVISION-NBR (2 + 15 spaces)
                      RPAD(NVL(rec.AREA, ' '), 17, ' ') ||                                                  --AREA-NBR (2 + 15 spaces)
                      RPAD(NVL(rec.DISTRICT, ' '), 40, ' ') ||                                              --DISTRICT-NBR (2 + 38 spaces)
                      RPAD(NVL(SUBSTR(rec.LEAD_BANK_CC, 3), ' '), 4, ' ') ||                                --STORE-NBR (4)
                      FORMAT_INPUT_FOR_FILE(' ', ' ', 1) ||                                                 --FILLER (1 space)
                      FORMAT_INPUT_FOR_FILE(NVL(rec.BANK_TYPE_CODE, ' '), ' ', 1) ||                        --BANKING-TYPE (1)
                      FORMAT_INPUT_FOR_FILE(' ', ' ', 1) ||                                                 --FILLER (1 space)
                      RPAD(NVL(rec.BANK_NAME, ' '), 26, ' ') ||                                             --BANK-NAME (26)
                      FORMAT_INPUT_FOR_FILE(' ', ' ', 7) ||                                                 --FILLER (7 spaces)
--??? lead store name or actual store name - for now assuming it as actual store name
                      RPAD(NVL(rec.COST_CENTER_NAME, ' '), 35, ' ') ||                                      --STORE-NAME-2 (35)
                      FORMAT_INPUT_FOR_FILE(' ', ' ', 4) ||                                                 --FILLER (4 spaces)
                      RPAD('SHERWIN-WILLIAMS STORE #', 24, ' ') ||                                          --SHERWIN-WILLIAMS (24)
                      RPAD(NVL(SUBSTR(V_ADDRESS_REC.COST_CENTER_CODE, 3), ' '), 4, ' ') ||                  --ADDR-STORE-NBR (4)
                      FORMAT_INPUT_FOR_FILE(' ', ' ', 11) ||                                                --FILLER (11 spaces)
                      RPAD(NVL(V_ADDRESS_REC.ADDRESS_LINE_1, ' '), 30, ' ') ||                              --ADDR-LINE-1 (30)
                      FORMAT_INPUT_FOR_FILE(' ', ' ', 48) ||                                                --FILLER (9 + 39 spaces)
                      RPAD(NVL(V_ADDRESS_REC.CITY, ' '), 20, ' ') ||                                        --ADDR-LINE-1 (20)
                      FORMAT_INPUT_FOR_FILE(' ', ' ', 9) ||                                                 --FILLER (9 spaces)
                      RPAD(NVL(NVL(V_ADDRESS_REC.STATE_CODE,V_ADDRESS_REC.PROVINCE_CODE), ' '), 2, ' ') ||  --STATE (2)
                      RPAD(NVL(NVL(V_ADDRESS_REC.ZIP_CODE,V_ADDRESS_REC.POSTAL_CODE), ' '), 5, ' ') ||      --ADDR-ZIP-1-5 (5)
                      RPAD(NVL(V_ADDRESS_REC.ZIP_CODE_4, ' '), 4, ' ') ||                                   --ADDR-ZIP-6-9 (4)
                      FORMAT_INPUT_FOR_FILE(NVL(V_PHONE_REC.PRIMARY_PHONE_NUMBER,
                                            NVL(V_PHONE_REC.SECONDARY_PHONE_NUMBER, '9')),
                                            '9', 10) ||                                                     --AREA-CODE || PHONE-NBR (9)
                      FORMAT_INPUT_FOR_FILE(' ', ' ', 4) ||                                                 --FILLER (4 spaces)
                      FORMAT_INPUT_FOR_FILE(1, 0, 12) ||                                                    --S1-DEPO-AMT = 0.01 (12)
                      FORMAT_INPUT_FOR_FILE(1, 0, 12) ||                                                    --S2-DEPO-AMT = 0.01 (12)
                      FORMAT_INPUT_FOR_FILE(1, 0, 12) ||                                                    --S2-END-DEPO-AMT = 0.01 (12)
                      FORMAT_INPUT_FOR_FILE(1, 0, 12) ||                                                    --S1-END-DEPO-AMT = 0.01 (12)
                      CHR(10)|| CHR(13);
       UTL_FILE.PUT_LINE(UAR_SERIAL_OTPT_FL, V_OUT_CLOB, TRUE);
       V_OUT_CLOB := NULL;
    END LOOP;
    UTL_FILE.FCLOSE(UAR_SERIAL_OTPT_FL);
END;
    EXECUTE IMMEDIATE 'DROP TABLE STR_BNK_DPST_DLY_RCNCL_TBL_RR';
END;
