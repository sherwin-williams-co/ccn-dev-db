DECLARE
/*****************************************************************************
	This is a one time script that will be run on 01-SEP-2015
	that will be sent details for FSS(Financial Shared Services)

Note: it has to pick the July mid monthly missed drafts along with August monthly drafts

created : 08/19/2015 jxc517 CCN Project....
changed : 
*****************************************************************************/
    IN_DATE DATE := TO_DATE('01-AUG-2015', 'DD_MON_RRRR');

    CURSOR cur IS
        SELECT *
          FROM (SELECT COST_CENTER_CODE,
                       NET_AMOUNT,
                       ISSUE_DATE,
                       DRAFT_NUMBER,
                       SD_FILE_BUILD_PKG.GET_CUSTOMER_VENDOR_NO(CUSTOMER_ACCOUNT_NUMBER) VENDOR_NO
                  FROM STORE_DRAFTS
                 WHERE FNCL_SRVCS_SENT_DATE IN (TO_DATE('15-JUL-2015', 'DD_MON_RRRR') , IN_DATE)
                   AND CHECK_SERIAL_NUMBER <> '0311034813'
                )
          WHERE VENDOR_NO IS NOT NULL
          ORDER BY SUBSTR(COST_CENTER_CODE, 3), VENDOR_NO, DRAFT_NUMBER;

    PATH        	  VARCHAR2(50) := 'STORDRAFT_DATAFILES'; -- DIRECTORY CREATED IN ORACLE DATABASE
    FILENAME  			VARCHAR2(50) := 'ST'       --ORIGIN = Stores
                                    ||'INS'    --SOURCE_SYS_ID = Installers
                                    ||'INV01'; --DSNAME
    STAMP       		VARCHAR2(50) := TO_CHAR(SYSDATE,'RRRRMMDDHH24MISS'); -- USED TO CREATE TIMESTAMP FOR DATA FILE
    OUTPUT_FILE 		UTL_FILE.FILE_TYPE;

	  V_OUT_CLOB            CLOB;
    V_SEQ_COUNT           NUMBER := 0;
    V_BATCH_NUMBER        BATCH_JOB.BATCH_JOB_NUMBER%TYPE;
    V_TRANS_STATUS        BATCH_JOB.TRANS_STATUS%TYPE := 'SUCCESSFUL';
    V_OLD_STORE_NUMBER    STORE_DRAFTS.COST_CENTER_CODE%TYPE;
    V_TOTAL_RECORD_COUNT  NUMBER := 0;
    V_TOTAL_HEADER_AMOUNT NUMBER := 0;
    V_TOTAL_LINE_AMOUNT   NUMBER := 0;
BEGIN
    CCN_BATCH_PKG.LOCK_DATABASE_SP(); -- PRAGMA AUTONOMOUS_TRANSACTION;

    BEGIN
        CCN_BATCH_PKG.INSERT_BATCH_JOB('1099_FILE_FOR_FSS', V_BATCH_NUMBER);
        
        OUTPUT_FILE := UTL_FILE.FOPEN (PATH
                                       ,FILENAME || STAMP || '.TXT'
                                       ,'W' --BINARY
                                       ,32767); 

        SELECT COUNT(*) * 2,
               SUM(NVL(NET_AMOUNT, 0)) * 100,
               SUM(NVL(NET_AMOUNT, 0)) * 100
          INTO V_TOTAL_RECORD_COUNT,
               V_TOTAL_HEADER_AMOUNT,
               V_TOTAL_LINE_AMOUNT
          FROM STORE_DRAFTS
         WHERE TO_CHAR(FNCL_SRVCS_SENT_DATE,'MMRR') = TO_CHAR(IN_DATE,'MMRR');
--           AND (COST_CENTER_CODE LIKE '%1015%' OR COST_CENTER_CODE LIKE '%1021%' OR COST_CENTER_CODE LIKE '%1030%');

        V_OUT_CLOB := V_OUT_CLOB
                      --RECORD-TYPE (1) -> 0 = Control Record
                      || '0'
                      || '|'
                      --HDR-TOTAL (17) -> INVOICE_AMOUNT [Sum from all header records]
                      || SUBSTR(SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(V_TOTAL_HEADER_AMOUNT, '0', 16), 1, 14)
                      || '.'
                      || SUBSTR(SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(V_TOTAL_HEADER_AMOUNT, '0', 16), 15, 2)
                      || '|'
                      --DTL-TOTAL (17) -> AMOUNT [Sum from all line records]
                      || SUBSTR(SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(V_TOTAL_LINE_AMOUNT, '0', 16), 1, 14)
                      || '.'
                      || SUBSTR(SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(V_TOTAL_LINE_AMOUNT, '0', 16), 15, 2)
                      || '|'
                      --RECORD-TOTAL (17) -> [Number of records in the file]
                      || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(V_TOTAL_RECORD_COUNT,'0',14)
                      || '.00'
                      || '|'
                      --INTERFACE-NAME (12) -> STINSINV01, 2 spaces
                      || 'STINSINV01'
                      || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',2)
                      || '|'
                      --FILE-NAME (28) -> STINSINV01rrrrmmddhrmiss.TXT
                      || FILENAME || STAMP || '.TXT'
                      || '|'
                      || CHR(13) --CR
                      || CHR(10) --LF
                      ;
        FOR rec IN cur LOOP
            IF V_OLD_STORE_NUMBER <> rec.COST_CENTER_CODE THEN
                V_SEQ_COUNT := 1;
            ELSE
                V_SEQ_COUNT := V_SEQ_COUNT + 1;
            END IF;
            V_OUT_CLOB := V_OUT_CLOB 
                           --RECORD-TYPE (1) -> 1 = Invoice Header Record
                           || '1'
                           || '|'
                           --INVOICE-ID (50) -> 16 spaces, 4 store#, 4 store#, mmyy, 00, mm, seq from 0001, rrrrmmddhrmiss
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',16)
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(SUBSTR(rec.COST_CENTER_CODE, 3),'0',4)
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(SUBSTR(rec.COST_CENTER_CODE, 3),'0',4)
                           || TO_CHAR(IN_DATE,'MMRR')
                           || '00'
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(TO_CHAR(IN_DATE,'MM'),'0',2)
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(V_SEQ_COUNT,'0',4)
                           || STAMP
                           || '|'
                           --INVOICE-NBR (50) -> 4 store#, mmyy, 00, mm, seq from 0001, 34 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(SUBSTR(rec.COST_CENTER_CODE,3,4),'0',4)
                           || TO_CHAR(IN_DATE,'MMRR')
                           || '00'
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(TO_CHAR(IN_DATE,'MM'),'0',2)
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(V_SEQ_COUNT,'0',4)
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',34)
                           || '|'
                           --INVOICE-TYPE (25) STANDARD, 17 spaces => INVOICE_AMOUNT > 0
                           --INVOICE-TYPE (25) CREDIT, 19 spaces => INVOICE_AMOUNT < 0
                           --CREDIT =>  SWC_TERMS_IDENTIFIER must be populated, PAY_ALONE = 'N'
                           || 'STANDARD'
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',17)
                           || '|'
                           --INVOICE-DATE (8) -> mmddrrrr - issue_date/transaction_date
                           || TO_CHAR(rec.ISSUE_DATE,'MMDDRRRR')
                           || '|'
                           --ORACLE-PO-NBR (20) -> 20 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',20)
                           || '|'
                           --VENDOR-ID (15) -> 15 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',15)
                           || '|'
                           --VENDOR-NBR (30) -> 30 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',30)
                           || '|'
                           --VENDOR-NAME (80) -> 80 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',80)
                           || '|'
                           --ORACLE-VENDOR-SITE-ID (10) -> 10 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',10)
                           || '|'
                           --STORE-VENDOR-NBR (15) -> [swc_stor.SWC_AP_SUPPLIER_INFO_V@ERP_LINK] SITE_ATTRIBUTE3
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(rec.VENDOR_NO,'0',10)
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',5)
                           || '|'
                           --VENDOR-SITE-CODE (15) -> 15 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',15)
                           || '|'
                           --INVOICE-AMOUNT (17) -> net amount
                           || SUBSTR(SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(rec.NET_AMOUNT*100, '0', 16), 1, 14)
                           || '.'
                           || SUBSTR(SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(rec.NET_AMOUNT*100, '0', 16), 15, 2)
                           || '|'
                           --INVOICE-CURR-CODE (15) -> USD, 12 spaces [swc_stor.SWC_AP_SUPPLIER_INFO_V@ERP_LINK]
                           || 'USD'
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',12)
                           || '|'
                           --INVOICE-EXCHG-RTE (17) -> 17 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',17)
                           || '|'
                           --INVOICE-EXCHG-TYPE (30) -> 30 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',30)
                           || '|'
                           --INVOICE-EXCHG-DATE (8) -> 8 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',8)
                           || '|'
                           --INVOICE-TERMS-ID (17) -> 17 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',17)
                           || '|'
                           --INVOICE-TERMS-NAME (50) -> 50 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',50)
                           || '|'
                           --INVOICE-SWC-ID (3) -> 92, 1 space [swc_stor.SWC_AP_SUPPLIER_INFO_V@ERP_LINK]
                           || '92'
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',1)
                           || '|' 
                           --INVOICE-REMIT-DESC (240) -> STORE DRAFT - , 4 store#, 4 draft#, 217 spaces
                           || 'STORE DRAFT - '
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(SUBSTR(rec.COST_CENTER_CODE,3,4),'0',4)
                           || '-'
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(rec.DRAFT_NUMBER,'0',4)
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',217)
                           || '|'
                           --INVOICE-ATTR-CATEG (15) -> SWC_INVOICE, 139 spaces
                           || 'SWC_INVOICE'
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',139)
                           || '|'
                           --INVOICE-ATTRIBUT1 (150) -> 150 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',150)
                           || '|'
                           --INVOICE-ATTRIBUT2 (150) -> 150 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',150)
                           || '|'
                           --INVOICE-ATTRIBUT3 (150) -> 150 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',150)
                           || '|'
                           --INVOICE-ATTRIBUT4 (150) -> 150 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',150)
                           || '|'
                           --INVOICE-ATTRIBUT5 (150) -> 150 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',150)
                           || '|'
                           --INVOICE-ATTRIBUT6 (150) -> 150 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',150)
                           || '|'
                           --INVOICE-ATTRIBUT7 (150) -> 150 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',150)
                           || '|'
                           --INVOICE-ATTRIBUT8 (150) -> 150 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',150)
                           || '|'
                           --INVOICE-ATTRIBUT9 (150) -> 150 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',150)
                           || '|'
                           --INVOICE-ATTRIBUT10 (150) -> 150 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',150)
                           || '|'
                           --INVOICE-ATTRIBUT11 (150) -> 150 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',150)
                           || '|'
                           --INVOICE-ATTRIBUT12 (150) -> 150 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',150)
                           || '|'
                           --INVOICE-ATTRIBUT13 (150) -> 150 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',150)
                           || '|'
                           --INVOICE-ATTRIBUT14 (150) -> 150 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',150)
                           || '|'
                           --INVOICE-ATTRIBUT15 (150) -> 150 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',150)
                           || '|'
                           --SOURCE (80) -> INS, 77 spaces
                           || 'INS'
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',77)
                           || '|'
                           --INVOICE-BATCH-NAME (50) -> STINS, rrrrddmm, 01, 35 spaces
                           || 'STINS'
                           || TO_CHAR(SYSDATE,'RRRRMMDD')
                           || '01'
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',35)
                           || '|'
                           --WORKFLOW-FLAG (1) --> 1 space
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',1)
                           || '|'
                           --DOC-CATEGORY-CODE (30) -> 30 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',30)
                           || '|'
                           --PAYMENT-METHOD (25) -> 25 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',25)
                           || '|'
                           --PAY-GROUP (25) -> INSTALLER, 16 spaces [swc_stor.SWC_AP_SUPPLIER_INFO_V@ERP_LINK]
                           || 'INSTALLER'
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',16)
                           || '|'
                           --GOODS-RECEIVE-DATE (8) -> 8 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',8)
                           || '|'
                           --INV-RECEIVE-DATE (8) -> 8 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',8)
                           || '|'
                           --GL-DATE (8) -> mmddrrrr, last date of the month
                           || TO_CHAR(LAST_DAY(IN_DATE),'MMDDRRRR')
                           || '|'
                           --NEW-COA-STRUCTURE (1) -> Y
                           || 'Y'
                           || '|'
                           --LIABILITY-AFF-DIV (4) -> A100 - division level value for 80N066 from facts_division, showing differently in  [swc_stor.SWC_AP_SUPPLIER_INFO_V@ERP_LINK]
                           || 'A100'
                           || '|'
                           --LIABILITY-AFF-ACCT (7) -> 1200005  [swc_stor.SWC_AP_SUPPLIER_INFO_V@ERP_LINK]
                           || '1200005'
                           || '|'
                           --LIABILITY-AFF-CCTR (6) -> 80N066 showing differently in  [swc_stor.SWC_AP_SUPPLIER_INFO_V@ERP_LINK]
                           || '80N066'
                           || '|'
                           --LIABILITY-AFF-LOC (4) -> 0000 [swc_stor.SWC_AP_SUPPLIER_INFO_V@ERP_LINK]
                           || '0000'
                           || '|'
                           --LIABILITY-AFF-PROJ (4) -> 0000 [swc_stor.SWC_AP_SUPPLIER_INFO_V@ERP_LINK]
                           || '0000'
                           || '|'
                           --LIABILITY-AFF-CMPY (4) -> 0000 [swc_stor.SWC_AP_SUPPLIER_INFO_V@ERP_LINK]
                           || '0000'
                           || '|'
                           --PAY-ALONE-IND (1) -> N
                           || 'N'
                           || '|'
                           --APP-DISCOUNT-AMT (17) -> 17 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',17)
                           || '|'
                           --TERMS-DATE (8) -> 8 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',8)
                           || '|'
                           --ORGANIZATION-NAME (10) -> USA01, 5 spaces [swc_stor.SWC_AP_SUPPLIER_INFO_V@ERP_LINK] HR_ORG_SW_ORG_CODE
                           || 'USA01'
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',5)
                           || '|'
                           --FILE-NAME (28) -> STINSINV01rrrrmmddhrmiss.TXT
                           || FILENAME || STAMP || '.TXT'
                           || '|'
                           --CARR-RETURN
                           || CHR(13) --CR
                           || CHR(10) --LF
                           ;
            V_OUT_CLOB := V_OUT_CLOB
                           --RECORD-TYPE (1) -> 2
                           || '2'
                           || '|'
                           --INV-DTL-ID (50) -> 16 spaces, 4 store#, 4 store#, mmyy, 00, mm, seq from 0001, rrrrmmddhrmiss
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',16)
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(SUBSTR(rec.COST_CENTER_CODE, 3),'0',4)
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(SUBSTR(rec.COST_CENTER_CODE, 3),'0',4)
                           || TO_CHAR(IN_DATE,'MMRR')
                           || '00'
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(TO_CHAR(IN_DATE,'MM'),'0',2)
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(V_SEQ_COUNT,'0',4)
                           || STAMP
                           || '|'
                           --INV-DTL-LINE-NBR (17) -> 00000000000000001
                           || '00000000000000001'
                           || '|'
                           --INV-DTL-LNE-TYP-CD (25) -> ITEM, 21 spaces
                           || 'ITEM'
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',21)
                           || '|'
                           --INV-DTL-LINE-GRP (17) -> 17 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',17)
                           || '|'
                           --INV-DTL-AMOUNT (17) -> net amount
                           || SUBSTR(SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(rec.NET_AMOUNT*100, '0', 16), 1, 14)
                           || '.'
                           || SUBSTR(SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(rec.NET_AMOUNT*100, '0', 16), 15, 2)
                           || '|'
                           --INV-DTL-DATE (8) -> mmddrrrr - last day of the month
                           || TO_CHAR(LAST_DAY(IN_DATE),'MMDDRRRR')
                           || '|'
                           --INV-DTL-DESC (240) -> INSTALLER DRAFT CHECK FOR , 4 store#, 4 draft#, 205 spaces
                           || 'INSTALLER DRAFT CHECK FOR '
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(SUBSTR(rec.COST_CENTER_CODE,3,4),'0',4)
                           || '-'
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(rec.DRAFT_NUMBER,'0',4)
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',205)
                           || '|'
                           --INV-DTL-COA-STCTR (1) -> Y
                           || 'Y'
                           || '|'
                           --INV-DTL-AFF-DIV (4) -> D100 - division level value for TRTR00 from facts_division
                           --showing differently in  [swc_stor.SWC_AP_SUPPLIER_INFO_V@ERP_LINK]"
                           || 'D100'
                           || '|'
                           --INV-DTL-AFF-ACCT (7) -> 0110499  [swc_stor.SWC_AP_SUPPLIER_INFO_V@ERP_LINK]
                           || '0110499'
                           || '|'
                           --INV-DTL-AFF-CCTR (6) -> TRTR00 showing differently in  [swc_stor.SWC_AP_SUPPLIER_INFO_V@ERP_LINK]
                           || 'TRTR00'
                           || '|'
                           --INV-DTL-AFF-LOC (4) -> 0000 [swc_stor.SWC_AP_SUPPLIER_INFO_V@ERP_LINK]
                           || '0000'
                           || '|'
                           --INV-DTL-AFF-PROJ (4) -> 0000 [swc_stor.SWC_AP_SUPPLIER_INFO_V@ERP_LINK]
                           || '0000'
                           || '|'
                           --INV-DTL-AFF-CMPY (4) -> 0000 [swc_stor.SWC_AP_SUPPLIER_INFO_V@ERP_LINK]
                           || '0000'
                           || '|'
                           --INV-DTL-DIST-CODE (17) -> 17 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',17)
                           || '|'
                           --INV-DTL-INCL-TAX (1) -> N
                           || 'N'
                           || '|'
                           --INV-DTL-PRRTE-IND (1) -> 1 space
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',1)
                           || '|'
                           --INV-DTL-TAX-CD-ID (17) -> 17 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',17)
                           || '|'
                           --INV-DTL-ORCL-TAX (15) -> 15 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',15)
                           || '|'
                           --INV-DTL-FNL-MTCH (1) -> 1 space
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',1)
                           || '|'
                           --INV-DTL-PO-HDR-ID (17) -> 17 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',17)
                           || '|'
                           --INV-DTL-PO-NBR (20) -> 20 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',20)
                           || '|'
                           --INV-DTL-PO-LNE-ID (17) -> 17 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',17)
                           || '|'
                           --INV-DTL-PO-LNE-NBR (17) -> 17 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',17)
                           || '|'
                           --INV-DTL-PO-LNE-LOC (17) -> 17 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',17)
                           || '|'
                           --INV-DTL-PO-SHP-NBR (17) -> 17 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',17)
                           || '|'
                           --INV-DTL-PO-DST-ID (17) -> 17 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',17)
                           || '|'
                           --INV-DTL-PO-DST-NBR (17) -> 17 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',17)
                           || '|'
                           --INV-DTL-PO-U-O-M (25) -> 25 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',25)
                           || '|'
                           --INV-DTL-INV-ITM-ID (17) -> 17 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',17)
                           || '|'
                           --INV-DTL-ITEM-DESC (240) -> 240 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',240)
                           || '|'
                           --INV-DTL-QTY-INVCD (17) -> 17 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',17)
                           || '|'
                           --INV-DTL-SHP-LOC-CD (25) -> 25 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',25)
                           || '|'
                           --INV-DTL-UNIT-PRICE (17) -> 17 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',17)
                           || '|'
                           --INV-DTL-PR-COR-IND (1) -> 1 space
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',1)
                           || '|'
                           --INV-DTL-RECPT-NBR (30) -> 30 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',30)
                           || '|'
                           --INV-DTL-RECPT-LINE (25) -> 25 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',25)
                           || '|'
                           --INV-DTL-MATCH-OPTN (25) -> 25 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',25)
                           || '|'
                           --INV-DTL-DSET-ID (17) -> 17 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',17)
                           || '|'
                           --INV-DTL-DSET-NAME (50) -> 50 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',50)
                           || '|'
                           --INV-DTL-ATTR-CATEG (150) -> SWC_INVOICE_DIST, 134 spaces
                           || 'SWC_INVOICE_DIST'
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',134)
                           || '|'
                           --INV-DTL-ATTRIBUT1 (150) -> 150 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',150)
                           || '|'
                           --INV-DTL-ATTRIBUT2 (150) -> 150 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',150)
                           || '|'
                           --INV-DTL-ATTRIBUT3 (150) -> 150 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',150)
                           || '|'
                           --INV-DTL-ATTRIBUT4 (150) -> 150 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',150)
                           || '|'
                           --INV-DTL-ATTRIBUT5 (150) -> 150 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',150)
                           || '|'
                           --INV-DTL-ATTRIBUT6 (150) -> 150 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',150)
                           || '|'
                           --INV-DTL-ATTRIBUT7 (150) -> 150 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',150)
                           || '|'
                           --INV-DTL-ATTRIBUT8 (150) -> 150 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',150)
                           || '|'
                           --INV-DTL-ATTRIBUT9 (150) -> 150 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',150)
                           || '|'
                           --INV-DTL-ATTRIBUT10 (150) -> 150 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',150)
                           || '|'
                           --INV-DTL-ATTRIBUT11 (150) -> 150 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',150)
                           || '|'
                           --INV-DTL-ATTRIBUT12 (150) -> 150 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',150)
                           || '|'
                           --INV-DTL-ATTRIBUT13 (150) -> 150 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',150)
                           || '|'
                           --INV-DTL-ATTRIBUT14 (150) -> 150 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',150)
                           || '|'
                           --INV-DTL-ATTRIBUT15 (150) -> 150 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',150)
                           || '|'
                           --INV-DTL-PO-REL-ID (17) -> 17 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',17)
                           || '|'
                           --INV-DTL-PO-REL-NBR (17) -> 17 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',17)
                           || '|'
                           --INV-DTL-PROJECT-ID (17) -> 17 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',17)
                           || '|'
                           --INV-DTL-TASK-ID (17) -> 17 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',17)
                           || '|'
                           --INV-DTL-EXPND-TYP (30) -> 30 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',30)
                           || '|'
                           --INV-DTL-EXPND-DATE (8) -> 8 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',8)
                           || '|'
                           --INV-DTL-EXPND-ORG (17) -> 17 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',17)
                           || '|'
                           --INV-DTL-PA-CONTEXT (30) -> 30 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',30)
                           || '|'
                           --INV-DTL-PA-ADD-FL (1) -> 1 space
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',1)
                           || '|'
                           --INV-DTL-PA-QUANTY (17) -> 17 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',17)
                           || '|'
                           --INV-DTL-1099-CODE (10) -> 10 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',10)
                           || '|'
                           --INV-DTL-TAX-REGN (10) -> 10 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',10)
                           || '|'
                           --INV-DTL-AST-TRK-FL (1) -> 1 space
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',1)
                           || '|'
                           --INV-DTL-PA-INV-ID (17) -> 17 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',17)
                           || '|'
                           --INV-DTL-PA-INV-LNE (17) -> 17 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',17)
                           || '|'
                           --INV-DTL-REFERENCE1 (30) -> 30 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',30)
                           || '|'
                           --INV-DTL-REFERENCE2 (30) -> 30 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',30)
                           || '|'
                           --INV-DTL-PA-PROC-CD (1) -> 1 space
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',1)
                           || '|'
                           --INV-DTL-TAX-REC-RT (17) -> 17 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',17)
                           || '|'
                           --INV-DTL-TAX-REC-OV (1) -> 1 space
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',1)
                           || '|'
                           --INV-DTL-TAX-REC-FL (1) -> 1 space
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',1)
                           || '|'
                           --INV-DTL-TAX-OVR-FL (1) -> 1 space
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',1)
                           || '|'
                           --INV-DTL-CC-TRX-ID (17) -> 17 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',17)
                           || '|'
                           --INV-DTL-VNDR-ITM (25) -> 25 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',25)
                           || '|'
                           --INV-DTL-TAXABLE-FL (1) -> 1 space
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',1)
                           || '|'
                           --INV-DTL-PR-COR-NBR (50) -> 50 spaces
                           || SD_FILE_BUILD_PKG.FORMAT_INPUT_FOR_FILE(' ',' ',50)
                           || '|'
                           --DTL-FILE-NAME (28) -> STINSINV01rrrrmmddhrmiss.TXT
                           || FILENAME || STAMP || '.TXT'
                           || '|'
                           --CARR-RETURN
                           || CHR(13);
            UTL_FILE.PUT_LINE(OUTPUT_FILE, V_OUT_CLOB, TRUE);
            V_OUT_CLOB := NULL;
            COMMIT;
            V_OLD_STORE_NUMBER := rec.COST_CENTER_CODE;
        END LOOP;

        UTL_FILE.FCLOSE(OUTPUT_FILE);

    EXCEPTION
        WHEN OTHERS THEN
            V_TRANS_STATUS := 'ERROR';
            RAISE;
    END;

    CCN_BATCH_PKG.UPDATE_BATCH_JOB('1099_FILE_FOR_FSS', V_BATCH_NUMBER, V_TRANS_STATUS);

    CCN_BATCH_PKG.UNLOCK_DATABASE_SP(); -- PRAGMA AUTONOMOUS_TRANSACTION;
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;
/
