create or replace PACKAGE BODY POSXML_SD_DAILY_LOAD_TMP 
/**************************************************************** 
This package will load the Temp CCN Store Drafts tables
created : 03/22/2016 axk326 CCN Project....
changed :
*****************************************************************/
AS

PROCEDURE TRUNCATE_TABLE(
/*****************************************************************************
	TRUNCATE_TABLE

	This procedure will truncate all loaded data for the table name that is 
  passed in.

created : 04/01/2016 axk326 CCN Project....
changed :
*****************************************************************************/
IN_TABLE_NAME IN VARCHAR2)
IS
    CURSOR C_CONSTRAINTS IS
        SELECT CONSTRAINT_NAME, TABLE_NAME
          FROM USER_CONSTRAINTS
         WHERE R_CONSTRAINT_NAME IN (SELECT CONSTRAINT_NAME
                                       FROM USER_CONSTRAINTS
                                      WHERE TABLE_NAME = IN_TABLE_NAME);
BEGIN
    FOR rec IN C_CONSTRAINTS LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE ' || rec.TABLE_NAME ||
                          ' DISABLE CONSTRAINT ' || rec.CONSTRAINT_NAME;
    END LOOP;

    EXECUTE IMMEDIATE 'TRUNCATE TABLE ' || IN_TABLE_NAME;

    FOR rec IN C_CONSTRAINTS LOOP
        EXECUTE IMMEDIATE 'ALTER TABLE ' || rec.TABLE_NAME ||
                          ' ENABLE CONSTRAINT ' || rec.CONSTRAINT_NAME;
    END LOOP;        
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END TRUNCATE_TABLE;

PROCEDURE TRUNCATE_POSXML_SD_TABLES
/**************************************************************************************
	TRUNCATE_POSXML_SD_TABLES

	This procedure will truncate all previous day data before loading current day data 
  into POSXML store drafts temp tables.

created : 04/01/2016 axk326 CCN Project....
changed : 
**************************************************************************************/
IS
BEGIN

  --Truncate temporary POSXML store drafts temp tables
    TRUNCATE_TABLE('POSXML_BNK_PAID_DATA_TMP');
    TRUNCATE_TABLE('POSXML_CSTMR_BNK_CRD_TMP');
    TRUNCATE_TABLE('POSXML_CSTMR_FRM_OF_PAY_TMP');
    TRUNCATE_TABLE('POSXML_CSTMR_SLS_TAX_TMP');
    TRUNCATE_TABLE('POSXML_CUST_LINE_ITEM_DATA_TMP');
    TRUNCATE_TABLE('POSXML_CSTMR_DTLS_TMP');
    TRUNCATE_TABLE('POSXML_CSTMR_TMP');
    TRUNCATE_TABLE('POSXML_DISBRSMT_LINE_ITEM_TMP');
    TRUNCATE_TABLE('POSXML_INSTLR_LN_ITEM_DATA_TMP');
    TRUNCATE_TABLE('POSXML_ISSUE_CHG_DATA_TMP');

EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END TRUNCATE_POSXML_SD_TABLES;

PROCEDURE LOAD_POSXML_ISSUE_CHG_DATA_TMP(
/*******************************************************************************
This procedure is used to load the POSXML store drafts temp table 
"POSXML_ISSUE_CHANGE_DATA_TMP" with data extracted from POS_XML_IFACE base table
created : 04/01/2016 axk326 CCN Project....
changed :
*******************************************************************************/
IN_DATE DATE)
AS

CURSOR POSXML_SD_CUR IS
   SELECT 'O' TRANSACTION_SOURCE,         -- Unused Column                                                                   
          'O' TRANSACTION_TYPE,           -- Unused Column
          X1.storeNbr COST_CENTER_CODE,
          '0'||X2.draftNbr CHECK_SERIAL_NUMBER,
          SUBSTR(X2.draftNbr, 5, 4) DRAFT_NBR,
		      '1'||TO_CHAR(TO_DATE(SUBSTR(TRUNC(PF.CREATED_TS), 1, 9), 'dd-mm-yy'), 'yymmdd') PROCESS_DATE,
		      NULL FILLER,
		      'O' TRANSACTION_SEGMENT_TYPE,  -- Unused column
		      NULL NET_AMOUNT_SIGN,            
		      FORMAT_INPUT_FOR_FILE(REPLACE(X2.draftAmt, '-', ''), '0', '9', '2') NET_AMOUNT,
		      NULL GROSS_AMOUNT_SIGN,          
          FORMAT_INPUT_FOR_FILE(REPLACE(X3.tranGrs, '-', ''), '0', '9', '2') GROSS_AMOUNT,         
		      NULL RETAINAGE_AMOUNT_SIGN,      
		      'REQ' RETAINAGE_AMOUNT,            -- Required field, Need to change later after the xpath is available 
		      '1'||TO_CHAR(TO_DATE(X1.ctlDate, 'yy-mm-dd'), 'yymmdd') ISSUE_DATE,
		      '1'||TO_CHAR(TO_DATE(X1.tranDate, 'yy-mm-dd'), 'yymmdd') TRANSACTION_DATE,
		      X1.termNbr TERMINAL_NUMBER,
		      X1.tranNbr TRANSACTION_NUMBER,
		      X2.draftAcctNbr CUSTOMER_ACCOUNT_NUMBER,
		      X1.jobNbr CUSTOMER_JOB_NUMBER,
		      X1.tranCode POS_TRANSACTION_CODE,
		      X1.billNm PAYEE_NAME,
		      X1.billAddr1 ADDRESS_LINE_1,
		      NULL ADDRESS_LINE_2,
		      X1.billCity CITY,
		      X1.billSt STATE_CODE,
		      X1.billZip ZIP_CODE,
		      X1.billPhone PHONE_NUMBER,
		      REPLACE(SUBSTR(X1.tranTimestamp, 12, 5), ':', '') TRANSACTION_TIME,
		      X1.empNbr EMPLOYEE_NUMBER,
		      SUBSTR(X1.bookPeriod, 3, 4) BOOK_DATE,
		      SUBSTR(X1.runCycle, 1, 2) CYCLE_RUN_NUMBER,
		      X1.rsnCd REASON_CODE               -- Change might come up later for this column xpath
     FROM POS_XML_IFACE PF,
          XMLTABLE('/CCN/header'
    	                 PASSING PF.XML_DOCUMENT
                                       COLUMNS  
                                       storeNbr VARCHAR2(50) PATH 'storeNbr',
                                       ctlDate VARCHAR2(50) PATH 'ctlDate',
									                     tranDate VARCHAR2(50) PATH 'tranDate',
									                     termNbr VARCHAR2(50) PATH 'termNbr',
									                     tranNbr VARCHAR2(50) PATH 'tranNbr',
									                     jobNbr VARCHAR2(50) PATH 'jobNbr',
									                     tranCode VARCHAR2(50) PATH 'tranCode',
									                     billNm VARCHAR2(50) PATH 'billNm',
									                     billAddr1 VARCHAR2(50) PATH 'billAddr1',
									                     billCity VARCHAR2(50) PATH 'billCity',
									                     billSt VARCHAR2(50) PATH 'billSt',
									                     billZip VARCHAR2(50) PATH 'billZip',
									                     billPhone VARCHAR2(50) PATH 'billPhone',
									                     tranTimestamp VARCHAR2(50) PATH 'tranTimestamp',
									                     empNbr VARCHAR2(50) PATH 'empNbr',
									                     bookPeriod VARCHAR2(50) PATH 'bookPeriod',
									                     runCycle VARCHAR2(50) PATH 'runCycle',
									                     rsnCd VARCHAR2(50) PATH 'rsnCd')X1,
           XMLTABLE('/CCN/draftLogs/draftLog'
                       PASSING PF.XML_DOCUMENT
                                       COLUMNS
                                       draftNbr VARCHAR2(50) PATH 'draftNbr',
                                       draftAmt VARCHAR2(50) PATH 'draftAmt',
                                       draftAcctNbr VARCHAR2(50) PATH 'draftAcctNbr')X2, 
           XMLTABLE('/CCN/taxTotals/taxTotal'
                       PASSING PF.XML_DOCUMENT
                                       COLUMNS
                                       tranGrs VARCHAR2(50) PATH 'tranGrs')X3                                        
   WHERE TRUNC(PF.CREATED_TS) = IN_DATE;    
                        
   V_COUNT  NUMBER := 0;
   V_TCOUNT NUMBER := 0;
   
BEGIN
     FOR REC IN POSXML_SD_CUR
     LOOP
        BEGIN
           INSERT INTO POSXML_ISSUE_CHG_DATA_TMP VALUES REC;
           V_COUNT   := V_COUNT + 1;
           IF V_COUNT > 100 THEN
               COMMIT;
               V_COUNT := 0;
           END IF;
           V_TCOUNT := V_TCOUNT + 1;
        EXCEPTION
            WHEN OTHERS THEN
                ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                           'LOAD_POSXML_ISSUE_CHG_DATA_TMP',
                                           SQLERRM,
                                           rec.COST_CENTER_CODE,
                                           NVL(rec.CHECK_SERIAL_NUMBER,'')||':'||
                                           NVL(rec.TRANSACTION_DATE,'')||':'||
                                           NVL(rec.TERMINAL_NUMBER,'')||':'||
                                           NVL(rec.TRANSACTION_NUMBER,''));
        END;
     END LOOP;
COMMIT;
DBMS_OUTPUT.PUT_LINE('Total rows inserted ' || V_TCOUNT); 

EXCEPTION
    WHEN OTHERS THEN
          ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                    'LOAD_POSXML_ISSUE_CHG_DATA_TMP',
                                    SQLERRM,
                                    '000000',
                                    '0000000000');
END LOAD_POSXML_ISSUE_CHG_DATA_TMP;

PROCEDURE LOAD_POSXML_SD_LINE_ITEMS(
/*******************************************************************************
This procedure is used to load the POSXML store drafts temp tables as mentioned 
below with data extracted from POS_XML_IFACE base table
   1.POSXML_INSTLR_LN_ITEM_DATA_TMP
   2.POSXML_DISBRSMT_LINE_ITEM_TMP
   3.POSXML_CUST_LINE_ITEM_DATA_TMP
created : 04/01/2016 axk326 CCN Project....
changed :
*******************************************************************************/
IN_DATE DATE)
AS 
-- Cursor for loading the table POSXML_INSTLR_LN_ITEM_DATA_TMP
   CURSOR POSXML_INSTLR_LID IS      
          SELECT 'O' TRANSACTION_SOURCE,        -- Unused column
                 'O' TRANSACTION_TYPE,          -- Unused column
                 X1.storeNbr COST_CENTER_CODE,
                 '0'||X2.draftNbr CHECK_SERIAL_NUMBER,
		             '1'||TO_CHAR(TO_DATE(SUBSTR(TRUNC(PF.CREATED_TS), 1, 9), 'dd-mm-yy'), 'yymmdd') PROCESS_DATE,
		             NULL FILLER,
		             'O' TRANSACTION_SEGMENT_TYPE,  -- Unused column
		             NULL EXT_AMOUNT_SIGN,
		             'REQ' EXT_AMOUNT,              -- Xpath yet to be added
		             X1.termNbr ORGNL_TERMINAL_NUMBER,
		             X1.tranNbr ORGNL_TRANSACTION_NUMBER,
			           NULL ITEM_QTY_SIGN,
			           'REQ' ITEM_QTY,                 -- 0 as default for now, Xpath yet to be added
			           NULL ITEM_PRICE_SIGN,
		             'REQ' ITEM_PRICE,               -- 0 as default, Xpath yet to be added
                 'REQ' GL_PRIME_ACCOUNT_NUMBER,  -- Xpath yet to be added
                 'REQ' GL_SUB_ACCOUNT_NUMBER 	   -- Xpath yet to be added		  
            FROM POS_XML_IFACE PF,
                 XMLTABLE('/CCN/header'
    	                     PASSING PF.XML_DOCUMENT
                                           COLUMNS  
                                           storeNbr VARCHAR2(50) PATH 'storeNbr',
									                         termNbr VARCHAR2(50) PATH 'termNbr',
                                           tranNbr VARCHAR2(50) PATH 'tranNbr',
                                           tranCode VARCHAR2(50) PATH 'tranCode')X1,
                 XMLTABLE('/CCN/draftLogs/draftLog'
    	                     PASSING PF.XML_DOCUMENT
                                          COLUMNS
                                          draftNbr VARCHAR2(50) PATH 'draftNbr')X2
           WHERE TRUNC(PF.CREATED_TS) = IN_DATE
             AND X1.tranCode IN ('13');
	 
-- POSXML_CUST_LINE_ITEM_DATA_TMP
 CURSOR POSXML_CUST_LID IS 
        SELECT 'O' TRANSACTION_SOURCE,        -- Unused column
               'O' TRANSACTION_TYPE,          -- Unused column
               X1.storeNbr COST_CENTER_CODE,
               '0'||X2.draftNbr CHECK_SERIAL_NUMBER,
		           '1'||TO_CHAR(TO_DATE(SUBSTR(TRUNC(PF.CREATED_TS), 1, 9), 'dd-mm-yy'), 'yymmdd') PROCESS_DATE,
		           NULL FILLER,
		           'O' TRANSACTION_SEGMENT_TYPE,  -- Unused column
		           NULL EXT_AMOUNT_SIGN,
		           FORMAT_INPUT_FOR_FILE(X2.draftAmt, '0', '9', '2') EXT_AMOUONT, 
               X2.draftAcctNbr ORGNL_CUSTOMER_ACCOUNT_NUMBER,
               X1.jobNbr ORGNL_JOB_NUMBER 			  
          FROM POS_XML_IFACE PF,
               XMLTABLE('/CCN/header'
    	                   PASSING PF.XML_DOCUMENT
                                         COLUMNS  
                                         storeNbr VARCHAR2(50) PATH 'storeNbr',
									                       termNbr VARCHAR2(50) PATH 'termNbr',
                                         tranCode VARCHAR2(50) PATH 'tranCode',
                                         acctNbr VARCHAR2(50) PATH 'acctNbr',
                                         jobNbr VARCHAR2(50) PATH 'jobNbr')X1,
               XMLTABLE('/CCN/draftLogs/draftLog'
    	                   PASSING PF.XML_DOCUMENT
                                        COLUMNS
                                        draftNbr VARCHAR2(50) PATH 'draftNbr',
                                        draftAmt VARCHAR2(50) PATH 'draftAmt',
                                        draftAcctNbr VARCHAR2(50) PATH 'draftAcctNbr')X2
        WHERE TRUNC(PF.CREATED_TS) = IN_DATE
          AND X1.tranCode IN ('19', '91');
             
	 
-- POSXML_DISBRSMT_LINE_ITEM_TMP
 CURSOR POSXML_DISBRSMT_LID IS
	      SELECT 'O' TRANSACTION_SOURCE,              -- Unused column
               'O' TRANSACTION_TYPE,                -- Unused column
               X1.storeNbr COST_CENTER_CODE,
               '0'||X2.draftNbr CHECK_SERIAL_NUMBER,
		           '1'||TO_CHAR(TO_DATE(SUBSTR(TRUNC(PF.CREATED_TS), 1, 9), 'dd-mm-yy'), 'yymmdd') PROCESS_DATE,
		           NULL FILLER,
		           'O' TRANSACTION_SEGMENT_TYPE,       -- Unused column
		           NULL EXT_AMOUNT_SIGN,
		           FORMAT_INPUT_FOR_FILE(X2.draftAmt, '0', '9', '2'),
               SUBSTR(X3.primeSub, 1, 4) GL_PRIME_ACCOUNT_NUMBER,
               SUBSTR(X3.primeSub, 5, 3) GL_SUB_ACCOUNT_NUMBER 			  
          FROM POS_XML_IFACE PF,
               XMLTABLE('/CCN/header'
    	                   PASSING PF.XML_DOCUMENT
                                         COLUMNS  
                                         storeNbr VARCHAR2(50) PATH 'storeNbr',
                                         docNbr VARCHAR2(50) PATH 'docNbr',
									                       termNbr VARCHAR2(50) PATH 'termNbr',
                                         tranCode VARCHAR2(50) PATH 'tranCode')X1,
               XMLTABLE('/CCN/draftLogs/draftLog'
    	                   PASSING PF.XML_DOCUMENT
                                        COLUMNS
                                        draftNbr VARCHAR2(50) PATH 'draftNbr',
                                        draftAmt VARCHAR2(50) PATH 'draftAmt')X2,
               XMLTABLE('/CCN/miscLines/miscLine/miscLn'
    	                   PASSING PF.XML_DOCUMENT
                                        COLUMNS
                                        miscAmt VARCHAR2(50) PATH 'miscAmt',
                                        primeSub VARCHAR2(50) PATH 'primeSub')X3
         WHERE TRUNC(PF.CREATED_TS) = IN_DATE
           AND X1.tranCode IN ('82');
           
    V_COUNT  NUMBER := 0;
    V_TCOUNT NUMBER := 0;             
BEGIN

  -- 1.POSXML_INSTLR_LN_ITEM_DATA_TMP
  -- 2.POSXML_DISBRSMT_LINE_ITEM_TMP
  -- 3.POSXML_CUST_LINE_ITEM_DATA_TMP
   FOR REC IN POSXML_INSTLR_LID
     LOOP
        BEGIN
           INSERT INTO POSXML_INSTLR_LN_ITEM_DATA_TMP VALUES REC;
           V_COUNT   := V_COUNT + 1;
           IF V_COUNT > 100 THEN
               COMMIT;
               V_COUNT := 0;
           END IF;
           V_TCOUNT := V_TCOUNT + 1;
        EXCEPTION
            WHEN OTHERS THEN
                ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                           'LOAD_POSXML_INSTLR_LID_TMP',
                                           SQLERRM,
                                           rec.COST_CENTER_CODE,
                                           rec.CHECK_SERIAL_NUMBER);
        END;
     END LOOP;
COMMIT;
DBMS_OUTPUT.PUT_LINE('Total rows inserted ' || V_TCOUNT);

FOR REC IN POSXML_CUST_LID
     LOOP
        BEGIN
           INSERT INTO POSXML_CUST_LINE_ITEM_DATA_TMP VALUES REC;
           V_COUNT   := V_COUNT + 1;
           IF V_COUNT > 100 THEN
               COMMIT;
               V_COUNT := 0;
           END IF;
           V_TCOUNT := V_TCOUNT + 1;
        EXCEPTION
            WHEN OTHERS THEN
                ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                           'LOAD_POSXML_CUST_LID_TMP',
                                           SQLERRM,
                                           rec.COST_CENTER_CODE,
                                           rec.CHECK_SERIAL_NUMBER);
        END;
     END LOOP;
COMMIT;
DBMS_OUTPUT.PUT_LINE('Total rows inserted ' || V_TCOUNT);

FOR REC IN POSXML_DISBRSMT_LID
     LOOP
        BEGIN
           INSERT INTO POSXML_DISBRSMT_LINE_ITEM_TMP VALUES REC;
           V_COUNT   := V_COUNT + 1;
           IF V_COUNT > 100 THEN
               COMMIT;
               V_COUNT := 0;
           END IF;
           V_TCOUNT := V_TCOUNT + 1;
        EXCEPTION
            WHEN OTHERS THEN
               ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                           'LOAD_DISBRSMT_LID_TEMP',
                                           SQLERRM,
                                           rec.COST_CENTER_CODE,
                                           rec.CHECK_SERIAL_NUMBER);
        END;
     END LOOP;
COMMIT;
DBMS_OUTPUT.PUT_LINE('Total rows inserted ' || V_TCOUNT);

EXCEPTION
    WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                    'LOAD_POSXML_SD_LINE_ITEMS',
                                    SQLERRM,
                                    '000000',
                                    '0000000000');

  
END LOAD_POSXML_SD_LINE_ITEMS;

PROCEDURE LOAD_POSXML_CSTMR_TMP(
/****************************************************************************
This procedure is used to load the POSXML store drafts temp table 
"POSXML_CUSTOMER_TMP" with data extracted from POS_XML_IFACE base table
created : 04/01/2016 axk326 CCN Project....
changed :
*****************************************************************************/
IN_DATE DATE)
AS
CURSOR POSXML_SD_CUR
IS
  SELECT DISTINCT X1.storeNbr COST_CENTER_CODE,
        X1.termNbr TERMINAL_NUMBER,
			  X1.tranNbr TRANSACTION_NUMBER,
			  'O' SORT_FORCE,                   -- Unused Column
        'O' SEGMENT_CODE,                 -- Unused Column
			  'O' SUB_SEGMENT_CODE,             -- Unused Column
			  NULL FILLER,
			  '1'||TO_CHAR(TO_DATE(X1.tranDate, 'yy-mm-dd'), 'yymmdd') TRANSACTION_DATE,
			  X1.acctNbr CUSTOMER_ACCOUNT_NUMBER,
			  X1.jobNbr CUSTOMER_JOB_NUMBER,
			  'REQ' POS_TRANSACTION_NUMBER_BATCH,  -- Need to change later once the xpath is confirmed
			  REPLACE(SUBSTR(X1.tranTimestamp, 12, 5), ':', '') POS_TRANSACTION_TIME,
			  SUBSTR(X1.runCycle, 1, 2) CYCLE_RUN_NUMBER,
			  X1.empNbr EMPLOYEE_NUMBER,
			  'O' POS_MODE_INDICATOR,           -- Unused Column
			  X2.custTypNbr BUSINESS_TYPE_CODE,
			  X2.terrNbr SLS_TERRITORY_NUMBER,
			  X2.terrpct SLS_TERRITORY_NUMBER_NO_CORR,
        NULL TERRITORY_SPLIT_INDICATOR,
        X1.tranCode POS_TRANSACTION_CODE,
        'REQ' POS_TRANSACTION_DATE,        -- Need to change later once the xpath is confirmed 
        'REQ' POS_TERMINAL_NUMBER,         -- Need to change later once the xpath is confirmed
        'REQ' POS_TRANSACTION_NUMBER,		   -- Need to change later once the xpath is confirmed	  
			  'O' DATA_INDICATOR,               -- Unused Column
        TRIM(SUBSTR(X1.poNbr, 1, 20)) PURCHASE_ORDER_NUMBER	
   FROM POS_XML_IFACE PF,
              XMLTABLE('/CCN/header'
    	                  PASSING PF.XML_DOCUMENT
                                        COLUMNS  
                                        storeNbr VARCHAR2(50) PATH 'storeNbr',
                                        docNbr VARCHAR2(50) PATH 'docNbr',
                                        draftNbr VARCHAR2(50) PATH 'draftNbr',
                                        tranTotal VARCHAR2(50) PATH 'tranTotal',
                                        ctlDate VARCHAR2(50) PATH 'ctlDate',
									                      tranDate VARCHAR2(50) PATH 'tranDate',
									                      termNbr VARCHAR2(50) PATH 'termNbr',
									                      tranNbr VARCHAR2(50) PATH 'tranNbr',
									                      acctNbr VARCHAR2(50) PATH 'acctNbr',
									                      jobNbr VARCHAR2(50) PATH 'jobNbr',
									                      tranCode VARCHAR2(50) PATH 'tranCode',
									                      billNm VARCHAR2(50) PATH 'billNm',
									                      tranTimestamp VARCHAR2(50) PATH 'tranTimestamp',
									                      empNbr VARCHAR2(50) PATH 'empNbr',
									                      bookPeriod VARCHAR2(50) PATH 'bookPeriod',
									                      runCycle VARCHAR2(50) PATH 'runCycle',
									                      rsnCd VARCHAR2(50) PATH 'rsnCd',
                                        r2_terrNbr VARCHAR2(50) PATH 'r2_terrNbr',
                                        r2_xCptPrcNbr VARCHAR2(50) PATH 'r2_xCptPrcNbr',
                                        seqNbr VARCHAR2(50) PATH 'seqNbr',
                                        poNbr VARCHAR2(50) PATH 'poNbr')X1,
                  XMLTABLE('/CCN/territoriesInfo/territoryInfo'
    	                  PASSING PF.XML_DOCUMENT
                                        COLUMNS
                                        custTypNbr VARCHAR2(50) PATH 'custTypNbr',
                                        terrNbr VARCHAR2(50) PATH 'terrNbr',
                                        terrpct VARCHAR2(50) PATH 'terrpct')X2,
                  POSXML_ISSUE_CHG_DATA_TMP POSX
  WHERE TRUNC(PF.CREATED_TS) = IN_DATE
    AND X1.storeNbr = POSX.COST_CENTER_CODE
    AND X1.termNbr = POSX.TERMINAL_NUMBER
    AND X1.tranNbr = POSX.TRANSACTION_NUMBER
    AND X1.tranCode IN ('11', '31', '85', '12', '22', '19', '10', '41');
      
      V_COUNT  NUMBER := 0;
      V_TCOUNT NUMBER := 0;

BEGIN
  FOR REC IN POSXML_SD_CUR
     LOOP
        BEGIN
           INSERT INTO POSXML_CSTMR_TMP VALUES REC;
           V_COUNT   := V_COUNT + 1;
           IF V_COUNT > 50 THEN
               COMMIT;
               V_COUNT := 0;
           END IF;
           V_TCOUNT := V_TCOUNT + 1;
        EXCEPTION
            WHEN OTHERS THEN
                ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                           'LOAD_POSXML_CSTMR_TMP',
                                           SQLERRM,
                                           rec.COST_CENTER_CODE,
                                           NVL(rec.TERMINAL_NUMBER,'')||':'||
                                           NVL(rec.TRANSACTION_NUMBER,''));
        END;
     END LOOP;
COMMIT;
DBMS_OUTPUT.PUT_LINE('Total rows inserted ' || V_TCOUNT); 

EXCEPTION
    WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                    'LOAD_POSXML_CSTMR_TMP',
                                    SQLERRM,
                                    '000000',
                                    '0000000000');
        
END LOAD_POSXML_CSTMR_TMP;

PROCEDURE LOAD_POSXML_CSTMR_DTLS_TMP(
/****************************************************************************
This procedure is used to load the POSXML store drafts temp table 
"POSXML_CUSTOMER_DETAILS_TMP" with data extracted from POS_XML_IFACE base table
created : 04/01/2016 axk326 CCN Project....
changed :
*****************************************************************************/
IN_DATE DATE)
AS

CURSOR POSXML_SD_CUR
IS
 SELECT X1.storeNbr COST_CENTER_CODE,
        X1.termNbr TERMINAL_NUMBER,
			  X1.tranNbr TRANSACTION_NUMBER,
			  'O' SORT_FORCE,
			  'O' SEGMENT_CODE,
			  'O' SUB_SEGMENT_CODE,
			  NULL FILLER,
			  X2.salesNbr SALES_NUMBER,
			  DECODE(SUBSTR(X1.qty, 1), '-', '-', NULL) ITEM_QUANTITY_SIGN,                  -- NULL ITEM_QUANTITY_SIGN,
			  X2.qty ITEM_QUANTITY,
			  DECODE(SUBSTR(X1.price, 1), '-', '-', NULL) ITEM_PRICE_SIGN,                   -- NULL ITEM_PRICE_SIGN,
			  FORMAT_INPUT_FOR_FILE(REPLACE(X2.price, '-', ''), 0, '7', '2') ITEM_PRICE,
			  DECODE(SUBSTR(X1.extendedPrice, 1), '-', '-', NULL) ITEM_EXTERNAL_AMOUNT_SIGN, -- NULL ITEM_EXTERNAL_AMOUNT_SIGN,
			  FORMAT_INPUT_FOR_FILE(REPLACE(X2.extendedPrice, '-', ''), 0, '7', '2') ITEM_EXTERNAL_AMOUNT,        
			  DECODE(SUBSTR(X1.floor, 1), '-', '-', NULL) ITEM_DISC_AMOUNT_SIGN,             -- NULL ITEM_DISC_AMOUNT_SIGN,
			  X2.floorPrice ITEM_DISC_AMOUNT,                                                -- Need to change once xpath is confirmed
			  'O' ITEM_SALES_TAX_INDICATOR,                                                  -- Need to change the boolean to 1, 0 to match daily file
        '*' ITEM_DISC_CODE,                                                            -- Need to change once the xapth is confirmed 
        '*' ITEM_DISC_TYPE,                                                            -- Need to change once the xapth is confirmed
        NULL SALES_PROMO_CODE,
 			  X2.prime GL_PRIME_ACCOUNT,
        X2.sub GL_SUB_ACCOUNT,
        NULL SCHEDULE_TYPE,
        NULL SCHEDULE_VERSION,
        NULL PRICE_LVL_CODE,
        '000' PERCENT_OFF_LVL,
        NULL PROD_DESC_SOURCE,
        '00000' ORGNL_POS_TERMINAL_NUMBER,
        '00000' ORGNL_POS_TRANSACTION_NUMBER
   FROM POS_XML_IFACE PF,
        XMLTABLE('/CCN/header'
 	                 PASSING PF.XML_DOCUMENT
                                   COLUMNS  
                                   storeNbr VARCHAR2(50) PATH 'storeNbr',
                                   docNbr VARCHAR2(50) PATH 'docNbr',
                                   draftNbr VARCHAR2(50) PATH 'draftNbr',
                                   tranTotal VARCHAR2(50) PATH 'tranTotal',
                                   ctlDate VARCHAR2(50) PATH 'ctlDate',
                								   tranDate VARCHAR2(50) PATH 'tranDate',
							              		   termNbr VARCHAR2(50) PATH 'termNbr',
									                 tranNbr VARCHAR2(50) PATH 'tranNbr',
									                 acctNbr VARCHAR2(50) PATH 'acctNbr',
									                 jobNbr VARCHAR2(50) PATH 'jobNbr',
									                 tranCode VARCHAR2(50) PATH 'tranCode',
									                 billNm VARCHAR2(50) PATH 'billNm',
									                 tranTimestamp VARCHAR2(50) PATH 'tranTimestamp',
									                 empNbr VARCHAR2(50) PATH 'empNbr',
									                 bookPeriod VARCHAR2(50) PATH 'bookPeriod',
									                 runCycle VARCHAR2(50) PATH 'runCycle',
									                 rsnCd VARCHAR2(50) PATH 'rsnCd',
                                   floor VARCHAR2(50) PATH 'floor',
                                   extendedPrice VARCHAR2(50) PATH 'extendedPrice',
                                   price VARCHAR2(50) PATH 'price',
                                   qty VARCHAR2(50) PATH 'qty',
                                   salesNbr VARCHAR2(50) PATH 'salesNbr')X1,
         XMLTABLE('/CCN/salesLines/salesLine'
 	                 PASSING PF.XML_DOCUMENT
                                   COLUMNS  
                                   salesNbr VARCHAR2(50) PATH 'salesNbr',
                                   qty VARCHAR2(50) PATH 'qty',
                                   extendedPrice VARCHAR2(50) PATH 'extendedPrice',
                                   floorPrice VARCHAR2(50) PATH 'floorPrice',
                                   price VARCHAR2(50) PATH 'price',
                                   taxable VARCHAR2(50) PATH 'taxable',
                                   prime VARCHAR2(50) PATH 'prime',
                                   sub VARCHAR2(50) PATH 'sub')X2,
        POSXML_ISSUE_CHG_DATA_TMP POSX
  WHERE TRUNC(PF.CREATED_TS) = IN_DATE
    AND X1.storeNbr = POSX.COST_CENTER_CODE
    AND X1.termNbr = POSX.TERMINAL_NUMBER
    AND X1.tranNbr = POSX.TRANSACTION_NUMBER
    AND X1.tranCode IN ('11', '31', '85', '12', '22', '19', '10', '41');
    
      V_COUNT  NUMBER := 0;
      V_TCOUNT NUMBER := 0;
    
BEGIN
  FOR REC IN POSXML_SD_CUR
     LOOP
        BEGIN
           INSERT INTO POSXML_CSTMR_DTLS_TMP VALUES REC;
           V_COUNT   := V_COUNT + 1;
           IF V_COUNT > 100 THEN
               COMMIT;
               V_COUNT := 0;
           END IF;
           V_TCOUNT := V_TCOUNT + 1;
        EXCEPTION
            WHEN OTHERS THEN
                ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                           'LOAD_POSXML_CSTMR_DTLS_TMP',
                                           SQLERRM,
                                           rec.COST_CENTER_CODE,
                                           NVL(rec.TERMINAL_NUMBER,'')||':'||
                                           NVL(rec.TRANSACTION_NUMBER,''));
        END;
     END LOOP;
COMMIT;
DBMS_OUTPUT.PUT_LINE('Total rows inserted ' || V_TCOUNT);

EXCEPTION
    WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                    'LOAD_POSXML_CSTMR_DTLS_TMP',
                                    SQLERRM,
                                    '000000',
                                    '0000000000');
END LOAD_POSXML_CSTMR_DTLS_TMP;

PROCEDURE LOAD_POSXML_CSTMR_SLS_TAX_TMP(
/****************************************************************************
This procedure is used to load the POSXML store drafts temp table 
"POSXML_CSTMR_SALES_TAX_TMP" with data extracted from POS_XML_IFACE base table
created : 04/01/2016 axk326 CCN Project....
changed :
*****************************************************************************/
IN_DATE DATE)
AS

CURSOR POSXML_SD_CUR 
IS
 SELECT X1.storeNbr COST_CENTER_CODE,
        X1.termNbr TERMINAL_NUMBER,
			  X1.tranNbr TRANSACTION_NUMBER,
			  'O' SORT_FORCE,                      -- Unused Column
        'O' SEGMENT_CODE,                    -- Unused Column
			  'O' SUB_SEGMENT_CODE,                -- Unused Column
			  NULL FILLER,
        'O' SALES_TAX_CORR_INDICATOR,        -- Unused Column
        DECODE(SUBSTR(X3.taxAmt , 1), '-', '-', NULL) SALES_TAX_COLL_AMOUNT_SIGN,
        FORMAT_INPUT_FOR_FILE(REPLACE(X3.taxAmt, '-', ''), 0, '7', '2') SALES_TAX_COLL_AMOUNT,
        X2.taxStatus SALES_TAX_INDICATOR,              -- Need to convert the boolean value 
        NULL SALES_TAX_RATE_SIGN,
        'REQ' SALES_TAX_RATE,                          -- Need to change when the xpath is available 
        'REQ' SALES_TAX_CODE                           -- Need to change when the xpath is available
   FROM POS_XML_IFACE PF,
              XMLTABLE('/CCN/header'
    	                  PASSING PF.XML_DOCUMENT
                                        COLUMNS  
                                        storeNbr VARCHAR2(50) PATH 'storeNbr',
									                      termNbr VARCHAR2(50) PATH 'termNbr',
									                      tranNbr VARCHAR2(50) PATH 'tranNbr',
                                        tranCode VARCHAR2(50) PATH 'tranCode')X1,
              XMLTABLE('/CCN/salesLines/salesLine'
    	                  PASSING PF.XML_DOCUMENT
                                        COLUMNS
                                        wacIndicator VARCHAR2(50) PATH 'wacIndicator',
                                        taxStatus VARCHAR2(50) PATH 'taxStatus')X2,
              XMLTABLE('/CCN/salesLines/salesLine/discounts/discount'
    	                  PASSING PF.XML_DOCUMENT
                                        COLUMNS
                                        taxAmt VARCHAR2(50) PATH 'taxAmt')X3,
        POSXML_CSTMR_TMP PC
  WHERE TRUNC(PF.CREATED_TS) = IN_DATE
    AND PF.KEY1 = PC.COST_CENTER_CODE
    AND PF.KEY2 = PC.TERMINAL_NUMBER
    AND X1.tranCode IN ('11', '10');
      
      V_COUNT  NUMBER := 0;
      V_TCOUNT NUMBER := 0;

BEGIN

FOR REC IN POSXML_SD_CUR
     LOOP
        BEGIN
           INSERT INTO POSXML_CSTMR_SLS_TAX_TMP VALUES REC;
           V_COUNT   := V_COUNT + 1;
           IF V_COUNT > 100 THEN
               COMMIT;
               V_COUNT := 0;
           END IF;
           V_TCOUNT := V_TCOUNT + 1;
        EXCEPTION
            WHEN OTHERS THEN
                ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                           'LOAD_POSXML_CSTMR_SLS_TAX_TMP',
                                           SQLERRM,
                                           rec.COST_CENTER_CODE,
                                           NVL(rec.TERMINAL_NUMBER,'')||':'||
                                           NVL(rec.TRANSACTION_NUMBER,''));
        END;
     END LOOP;
COMMIT;
DBMS_OUTPUT.PUT_LINE('Total rows inserted ' || V_TCOUNT);

EXCEPTION
    WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                    'LOAD_POSXML_CSTMR_SLS_TAX_TMP',
                                    SQLERRM,
                                    '000000',
                                    '0000000000');

END LOAD_POSXML_CSTMR_SLS_TAX_TMP;

PROCEDURE LOAD_POSXML_CSTMR_BNK_CRD_TMP(
/****************************************************************************
This procedure is used to load the POSXML store drafts temp table 
"POSXML_CSTMR_BANK_CARD_TMP" with data extracted from POS_XML_IFACE base table
created : 04/01/2016 axk326 CCN Project....
changed :
*****************************************************************************/
IN_DATE DATE)
AS

CURSOR POSXML_SD_CUR
IS
  SELECT DISTINCT X1.storeNbr COST_CENTER_CODE,
	       X1.termNbr TERMINAL_NUMBER,
	       X1.tranNbr TRANSACTION_NUMBER,
			   'O' SORT_FORCE,             -- Unused Column
			   'O' SEGMENT_CODE,           -- Unused Column
			   'O' SUB_SEGMENT_CODE,       -- Unused Column
			   NULL FILLER,
			   REPLACE(X2.bin, '-', '') BANK_CARD_ACCOUNT_NUMBER,  
			   X2.authNbr BANK_AUTH,
			   NULL BANK_AMOUNT_SIGN,
			   REPLACE(X2.amount, '-', '') BANK_AMOUNT,         
			   X2.cardType BANK_TYPE           -- Need to change when the xpath value is available
    FROM POS_XML_IFACE PF,
                XMLTABLE('/CCN/header'
    	                     PASSING PF.XML_DOCUMENT
                           COLUMNS  
                           storeNbr VARCHAR2(50) PATH 'storeNbr',
						       			   termNbr VARCHAR2(50) PATH 'termNbr',
									         tranNbr VARCHAR2(50) PATH 'tranNbr',
                           tranCode VARCHAR2(50) PATH 'tranCode')X1,
                XMLTABLE('/CCN/bankCards/bankCard'
                          PASSING PF.XML_DOCUMENT
                          COLUMNS
                          bin VARCHAR2(50) PATH 'bin',
                          authNbr VARCHAR2(50) PATH 'authNbr',
                          amount VARCHAR2(50) PATH 'amount',
                          cardType VARCHAR2(50) PATH 'cardType')X2,
        POSXML_CSTMR_TMP PC
  WHERE TRUNC(PF.CREATED_TS) = IN_DATE
    AND PF.KEY1 = PC.COST_CENTER_CODE
    AND PF.KEY2 = PC.TERMINAL_NUMBER
    AND X1.tranCode IN ('11', '10');

      V_COUNT  NUMBER := 0;
      V_TCOUNT NUMBER := 0;
    
BEGIN
  FOR REC IN POSXML_SD_CUR
     LOOP
        BEGIN
           INSERT INTO POSXML_CSTMR_BNK_CRD_TMP VALUES REC;
           V_COUNT   := V_COUNT + 1;
           IF V_COUNT > 100 THEN
               COMMIT;
               V_COUNT := 0;
           END IF;
           V_TCOUNT := V_TCOUNT + 1;
        EXCEPTION
            WHEN OTHERS THEN
                ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                           'LOAD_POSXML_CSTMR_BNK_CRD_TMP',
                                           SQLERRM,
                                           rec.COST_CENTER_CODE,
                                           NVL(rec.TERMINAL_NUMBER,'')||':'||
                                           NVL(rec.TRANSACTION_NUMBER,''));
        END;
     END LOOP;
COMMIT;
DBMS_OUTPUT.PUT_LINE('Total rows inserted ' || V_TCOUNT);

EXCEPTION
    WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                    'LOAD_POSXML_CSTMR_BNK_CRD_TMP',
                                    SQLERRM,
                                    '000000',
                                    '0000000000');
        
END LOAD_POSXML_CSTMR_BNK_CRD_TMP;

PROCEDURE LOAD_POSXML_CSTMR_FOP_TMP(
/****************************************************************************
This procedure is used to load the POSXML store drafts temp table 
"POSXML_CSTMR_FRM_OF_PAY_TMP" with data extracted from POS_XML_IFACE base table
created : 04/01/2016 axk326 CCN Project....
changed :
*****************************************************************************/
IN_DATE DATE)
AS

CURSOR POSXML_SD_CUR 
IS
 SELECT X1.storeNbr COST_CENTER_CODE,
        X1.termNbr TERMINAL_NUMBER,
			  X1.tranNbr TRANSACTION_NUMBER,
			  'O' SORT_FORCE,                        -- Unused Column
        'O' SEGMENT_CODE,                      -- Unused Column
			  'O' SUB_SEGMENT_CODE,                  -- Unused Column
			  NULL FILLER,
        X2.payCd PAY_DISC_CODE,
        NULL TRANSACTION_TOTAL_AMOUNT_SIGN,
        FORMAT_INPUT_FOR_FILE(X1.tranTotal, 0, '7', 2)TRANSACTION_TOTAL_AMOUNT,
        X2.lineNbr POS_LINE_CNT,                -- Need to change it with the count for the total number of salesLine under salesLines tag
        NULL PAY_AMOUNT_SIGN,
        FORMAT_INPUT_FOR_FILE(X1.tranTotal, 0, '7', 2) PAY_AMOUNT,          -- Need to change the xpath 
        NULL POS_DISC_SIGN,
        '0000000' POS_DISC,
        NULL SALES_DISC_AMOUNT_SIGN,
        'O' SALES_DISC_AMOUNT                  -- Unused Column
   FROM POS_XML_IFACE PF,
              XMLTABLE('/CCN/header'
    	                  PASSING PF.XML_DOCUMENT
                                        COLUMNS  
                                        storeNbr VARCHAR2(50) PATH 'storeNbr',
									                      termNbr VARCHAR2(50) PATH 'termNbr',
									                      tranNbr VARCHAR2(50) PATH 'tranNbr',
                                        tranTotal VARCHAR2(50) PATH 'tranTotal',
                                        tranCode VARCHAR2(50) PATH 'tranCode')X1,
              XMLTABLE('/CCN/salesLines/salesLine'
    	                  PASSING PF.XML_DOCUMENT
                                        COLUMNS
                                        payCd VARCHAR2(50) PATH 'payCd',
                                        lineNbr VARCHAR2(50) PATH 'lineNbr')X2,
              XMLTABLE('/CCN/formsOfPayment/formOfPayment'
    	                  PASSING PF.XML_DOCUMENT
                                        COLUMNS
                                        amt VARCHAR2(50) PATH 'amt',
                                        seqNbr VARCHAR2(50) PATH 'seqNbr')X3,
        POSXML_CSTMR_TMP PC
  WHERE TRUNC(PF.CREATED_TS) = IN_DATE
    AND PF.KEY1 = PC.COST_CENTER_CODE
    AND PF.KEY2 = PC.TERMINAL_NUMBER
    AND X1.tranCode IN ('11', '10')
    AND X3.seqNbr = '1';   
      
      V_COUNT  NUMBER := 0;
      V_TCOUNT NUMBER := 0;

BEGIN

FOR REC IN POSXML_SD_CUR
     LOOP
        BEGIN
           INSERT INTO POSXML_CSTMR_FRM_OF_PAY_TMP VALUES REC;
           V_COUNT   := V_COUNT + 1;
           IF V_COUNT > 100 THEN
               COMMIT;
               V_COUNT := 0;
           END IF;
           V_TCOUNT := V_TCOUNT + 1;
        EXCEPTION
            WHEN OTHERS THEN
               ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                           'LOAD_POSXML_CSTMR_FOP_TMP',
                                           SQLERRM,
                                           rec.COST_CENTER_CODE,
                                           NVL(rec.TERMINAL_NUMBER,'')||':'||
                                           NVL(rec.TRANSACTION_NUMBER,''));
        END;
     END LOOP;
COMMIT;
DBMS_OUTPUT.PUT_LINE('Total rows inserted ' || V_TCOUNT); 

EXCEPTION
    WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                    'LOAD_POSXML_CSTMR_FOP_TMP',
                                    SQLERRM,
                                    '000000',
                                    '0000000000');

END LOAD_POSXML_CSTMR_FOP_TMP;

PROCEDURE POSXML_DAILY_LOAD_SP(
/************************************************************************
POSXML_DAILY_LOAD_SP

This Procedure is a wrapper for the daily Load of the store drafts tables
 * Loads all the store drafts tables

created : 04/01/2016 axk326 CCN Project....
changed :
************************************************************************/
IN_DATE DATE)
AS
    V_CONTEXT    VARCHAR2(200);
    V_START_TIME NUMBER;
BEGIN

      V_START_TIME := DBMS_UTILITY.GET_TIME;
      V_CONTEXT := 'Load POSXML_ISSUE_CHG_DATA_TMP Table ';
      LOAD_POSXML_ISSUE_CHG_DATA_TMP(IN_DATE);
      DBMS_OUTPUT.PUT_LINE('POSXML_ISSUE_CHG_DATA_TMP loaded in : '|| (DBMS_UTILITY.GET_TIME - V_START_TIME)/100 || ' Seconds');
      
      V_START_TIME := DBMS_UTILITY.GET_TIME;
      V_CONTEXT := 'Load POSXML Store Drafts Line item Details Tables ';
      LOAD_POSXML_SD_LINE_ITEMS(IN_DATE);
      DBMS_OUTPUT.PUT_LINE('LOAD_POSXML_SD_LINE_ITEMS loaded in : '|| (DBMS_UTILITY.GET_TIME - V_START_TIME)/100 || ' Seconds');
      
      V_START_TIME := DBMS_UTILITY.GET_TIME;
      V_CONTEXT := 'Load POSXML_CSTMR_TMP Table ';
      LOAD_POSXML_CSTMR_TMP(IN_DATE);
      DBMS_OUTPUT.PUT_LINE('POSXML_CSTMR_TMP loaded in : '|| (DBMS_UTILITY.GET_TIME - V_START_TIME)/100 || ' Seconds');
      
      V_START_TIME := DBMS_UTILITY.GET_TIME;
      V_CONTEXT := 'Load POSXML_CSTMR_DTLS_TMP Table ';
      LOAD_POSXML_CSTMR_DTLS_TMP(IN_DATE);
      DBMS_OUTPUT.PUT_LINE('POSXML_CSTMR_DTLS_TMP loaded in : '|| (DBMS_UTILITY.GET_TIME - V_START_TIME)/100 || ' Seconds');
      
      V_START_TIME := DBMS_UTILITY.GET_TIME;
      V_CONTEXT := 'Load POSXML_CSTMR_SLS_TAX_TMP Table ';
      LOAD_POSXML_CSTMR_SLS_TAX_TMP(IN_DATE);
      DBMS_OUTPUT.PUT_LINE('POSXML_CSTMR_SLS_TAX_TMP loaded in : '|| (DBMS_UTILITY.GET_TIME - V_START_TIME)/100 || ' Seconds');
      
      V_START_TIME := DBMS_UTILITY.GET_TIME;
      V_CONTEXT := 'Load POSXML_CSTMR_BNK_CRD_TMP Table ';
      LOAD_POSXML_CSTMR_BNK_CRD_TMP(IN_DATE);
      DBMS_OUTPUT.PUT_LINE('POSXML_CSTMR_BNK_CRD_TMP loaded in : '|| (DBMS_UTILITY.GET_TIME - V_START_TIME)/100 || ' Seconds');  
      
      V_START_TIME := DBMS_UTILITY.GET_TIME;
      V_CONTEXT := 'Load POSXML_CSTMR_FOP_TMP Table ';
      LOAD_POSXML_CSTMR_FOP_TMP(IN_DATE);
      DBMS_OUTPUT.PUT_LINE('POSXML_CSTMR_FOP_TMP loaded in : '|| (DBMS_UTILITY.GET_TIME - V_START_TIME)/100 || ' Seconds');
      
EXCEPTION
    WHEN OTHERS THEN
         ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                    'POSXML_DAILY_LOAD_SP',
                                    SQLERRM,
                                    '000000',
                                    '0000000000'); 
END POSXML_DAILY_LOAD_SP;

PROCEDURE POSXML_SD_DAILY_LOAD_SP(
/*******************************************************************************
POSXML_SD_DAILY_LOAD_SP

This Procedure is a wrapper for the Daily Load of the POSXML store drafts TEMP 
tables

created : 04/01/2016 axk326 CCN Project....
changed :
*******************************************************************************/
IN_DATE DATE)
AS
    V_CONTEXT    VARCHAR2(200);
    V_START_TIME NUMBER; 
    V_START_TIME_SD DATE := SYSDATE;
    V_CLOB       CLOB;

    V_BATCH_NUMBER      BATCH_JOB.BATCH_JOB_NUMBER%TYPE;
    V_TRANS_STATUS      BATCH_JOB.TRANS_STATUS%TYPE := 'SUCCESSFUL';
BEGIN
    CCN_BATCH_PKG.INSERT_BATCH_JOB('POSXML_SD_DLY_LOAD', V_BATCH_NUMBER);
    CCN_BATCH_PKG.LOCK_DATABASE_SP(); -- PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
-- STEP 1
-- Call to Truncate all the POSXML Store Drafts temp tables before starting a fresh load   
      V_START_TIME := DBMS_UTILITY.GET_TIME;
      V_CONTEXT := 'Truncate store drafts POSXML Temp Tables ';
      TRUNCATE_POSXML_SD_TABLES();
      DBMS_OUTPUT.PUT_LINE('Truncating completed in : '|| (DBMS_UTILITY.GET_TIME - V_START_TIME)/100 || ' Seconds');
     
-- STEP 2 
-- Call to perform DailyLoad for POSXML SD temp tables from XML_DOCUMENT column of POS_XML_IFACE table
      POSXML_DAILY_LOAD_SP(IN_DATE);
    END;
    CCN_BATCH_PKG.UPDATE_BATCH_JOB('POSXML_SD_DLY_LOAD', V_BATCH_NUMBER, V_TRANS_STATUS);
    CCN_BATCH_PKG.UNLOCK_DATABASE_SP(); -- PRAGMA AUTONOMOUS_TRANSACTION; 
EXCEPTION
    WHEN OTHERS THEN
         ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                    'POSXML_SD_DAILY_LOAD_SP',
                                     SQLERRM,
                                    '000000',
                                    '0000000000'); 
END POSXML_SD_DAILY_LOAD_SP;

END POSXML_SD_DAILY_LOAD_TMP;