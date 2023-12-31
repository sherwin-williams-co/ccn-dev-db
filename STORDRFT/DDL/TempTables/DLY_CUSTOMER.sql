BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE DLY_CUSTOMER';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

  CREATE TABLE DLY_CUSTOMER 
   (	COST_CENTER_CODE VARCHAR2(4 BYTE), 
	TERMINAL_NUMBER VARCHAR2(5 BYTE), 
	TRANSACTION_NUMBER VARCHAR2(5 BYTE), 
	SORT_FORCE VARCHAR2(3 BYTE), 
	SEGMENT_CODE VARCHAR2(2 BYTE), 
	SUB_SEGMENT_CODE VARCHAR2(2 BYTE), 
	FILLER VARCHAR2(5 BYTE), 
	TRANSACTION_DATE VARCHAR2(7 BYTE), 
	CUSTOMER_ACCOUNT_NUMBER VARCHAR2(9 BYTE), 
	CUSTOMER_JOB_NUMBER VARCHAR2(2 BYTE), 
	POS_TRANSACTION_NUMBER_BATCH VARCHAR2(6 BYTE), 
	POS_TRANSACTION_TIME VARCHAR2(4 BYTE), 
	CYCLE_RUN_NUMBER VARCHAR2(2 BYTE), 
	EMPLOYEE_NUMBER VARCHAR2(2 BYTE), 
	POS_MODE_INDICATOR VARCHAR2(1 BYTE), 
	BUSINESS_TYPE_CODE VARCHAR2(2 BYTE), 
	SLS_TERRITORY_NUMBER VARCHAR2(4 BYTE), 
	SLS_TERRITORY_NUMBER_NO_CORR VARCHAR2(4 BYTE), 
	TERRITORY_SPLIT_INDICATOR VARCHAR2(1 BYTE), 
	POS_TRANSACTION_CODE VARCHAR2(2 BYTE), 
	POS_TRANSACTION_DATE VARCHAR2(7 BYTE), 
	POS_TERMINAL_NUMBER VARCHAR2(5 BYTE), 
	POS_TRANSACTION_NUMBER VARCHAR2(5 BYTE), 
	DATA_INDICATOR VARCHAR2(1 BYTE), 
	PURCHASE_ORDER_NUMBER VARCHAR2(20 BYTE)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY STORDRFT_LOAD_FILES
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE
        badfile STORDRFT_LOAD_FILES:'DLY_CUSTOMER.bad'
        logfile STORDRFT_LOAD_FILES:'DLY_CUSTOMER.log'
        discardfile STORDRFT_LOAD_FILES:'DLY_CUSTOMER.dsc'
        LOAD WHEN ((18:19) = '00')
        FIELDS(
                COST_CENTER_CODE         CHAR(4),
                TERMINAL_NUMBER          CHAR(5),
                TRANSACTION_NUMBER       CHAR(5),
                SORT_FORCE               CHAR(3),
                SEGMENT_CODE             CHAR(2),
                SUB_SEGMENT_CODE         CHAR(2),
                FILLER                   CHAR(5),
                TRANSACTION_DATE         CHAR(7),
                CUSTOMER_ACCOUNT_NUMBER  CHAR(9),
                CUSTOMER_JOB_NUMBER      CHAR(2),
                POS_TRANSACTION_NUMBER_BATCH CHAR(6),
                POS_TRANSACTION_TIME     CHAR(4),
                CYCLE_RUN_NUMBER         CHAR(2),
                EMPLOYEE_NUMBER          CHAR(2),
                POS_MODE_INDICATOR       CHAR(1),
                BUSINESS_TYPE_CODE       CHAR(2),
                SLS_TERRITORY_NUMBER     CHAR(4),
                SLS_TERRITORY_NUMBER_NO_CORR CHAR(4),
                TERRITORY_SPLIT_INDICATOR CHAR(1),
                POS_TRANSACTION_CODE     CHAR(2),
                POS_TRANSACTION_DATE     CHAR(7),
                POS_TERMINAL_NUMBER      CHAR(5),
                POS_TRANSACTION_NUMBER   CHAR(5),
                DATA_INDICATOR           CHAR(1),
                PURCHASE_ORDER_NUMBER    CHAR(20)
                               )
              )
      LOCATION
       ( 'CUSTOMER_LABOR.TXT'
       )
    );
