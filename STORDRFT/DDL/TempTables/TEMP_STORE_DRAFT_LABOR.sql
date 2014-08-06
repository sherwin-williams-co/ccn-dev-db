BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE TEMP_STORE_DRAFT_LABOR';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

  CREATE TABLE TEMP_STORE_DRAFT_LABOR 
   (	COST_CENTER_CODE VARCHAR2(6 BYTE), 
	TRANSACTION_DATE VARCHAR2(8 BYTE), 
	TERM_NUMBER VARCHAR2(5 BYTE), 
	TRANSACTION_NUMBER VARCHAR2(5 BYTE), 
	CUSTOMER_ACCOUNT_NUMBER VARCHAR2(9 BYTE), 
	CUSTOMER_JOB_NUMBER VARCHAR2(2 BYTE), 
	POS_TRANSACTION_CODE VARCHAR2(2 BYTE), 
	POS_TRANSACTION_BATCH_NUMBER VARCHAR2(6 BYTE), 
	POS_TRANSACTION_TIME VARCHAR2(4 BYTE), 
	CYCLE_RUN_NUMBER VARCHAR2(2 BYTE), 
	EMPLOYEE_NUMBER VARCHAR2(2 BYTE), 
	POS_MOD_IND VARCHAR2(1 BYTE), 
	BUSINESS_TYPE_CODE VARCHAR2(2 BYTE), 
	SALES_TERRITORY_NUMBER VARCHAR2(4 BYTE), 
	SALES_TERRITORY_NUMBER_COR VARCHAR2(4 BYTE), 
	TERR_SPLIT_IND VARCHAR2(1 BYTE), 
	ORGNL_POS_TRANSACTION_DATE VARCHAR2(8 BYTE), 
	ORGNL_POS_TERM_NUMBER VARCHAR2(5 BYTE), 
	ORGNL_POS_TRANSACTION_NBR VARCHAR2(5 BYTE), 
	ORIGINAL_DATA_IND VARCHAR2(1 BYTE), 
	PURCHASE_ORDER_NUMBER VARCHAR2(20 BYTE), 
	BOOK_DATE_SEQUENCE VARCHAR2(5 BYTE)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY STORDRFT_LOAD_FILES
      ACCESS PARAMETERS
      ( RECORDS FIXED 109 
        badfile STORDRFT_LOAD_FILES:'TEMP_STORE_DRAFT_LABOR.bad'
        logfile STORDRFT_LOAD_FILES:'TEMP_STORE_DRAFT_LABOR.log'
        discardfile STORDRFT_LOAD_FILES:'TEMP_STORE_DRAFT_LABOR.dsc'
        FIELDS(
           COST_CENTER_CODE CHAR(6),
           TRANSACTION_DATE CHAR(8),
           TERM_NUMBER CHAR(5),
           TRANSACTION_NUMBER CHAR(5),
           CUSTOMER_ACCOUNT_NUMBER CHAR(9),
           CUSTOMER_JOB_NUMBER CHAR(2),
           POS_TRANSACTION_CODE CHAR(2),
           POS_TRANSACTION_BATCH_NUMBER CHAR(6),
           POS_TRANSACTION_TIME CHAR(4),
           CYCLE_RUN_NUMBER CHAR(2),
           EMPLOYEE_NUMBER CHAR(2),
           POS_MOD_IND CHAR(1),
           BUSINESS_TYPE_CODE CHAR(2),    
           SALES_TERRITORY_NUMBER CHAR(4),
           SALES_TERRITORY_NUMBER_COR CHAR(4),
           TERR_SPLIT_IND CHAR(1),
           ORGNL_POS_TRANSACTION_DATE CHAR(8),
           ORGNL_POS_TERM_NUMBER CHAR(5),
           ORGNL_POS_TRANSACTION_NBR CHAR(5),
           ORIGINAL_DATA_IND CHAR(1),
           PURCHASE_ORDER_NUMBER CHAR(20),
           BOOK_DATE_SEQUENCE CHAR(5)           
         ) 
                                       )
      LOCATION
       ( 'CCN99CTR_LABOR.TXT'
       )
    );
