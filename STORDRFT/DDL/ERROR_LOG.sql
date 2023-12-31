
  CREATE TABLE ERROR_LOG 
   (	ERROR_ID NUMBER NOT NULL ENABLE, 
	COST_CENTER VARCHAR2(6 BYTE) NOT NULL ENABLE, 
	ERROR_DATE DATE NOT NULL ENABLE, 
	MODULE VARCHAR2(200 BYTE) NOT NULL ENABLE, 
	CHECK_SERIAL_NUMBER VARCHAR2(100 BYTE), 
	ERROR_TEXT VARCHAR2(4000 BYTE), 
	NOTES VARCHAR2(2000 BYTE), 
	ERROR_CODE VARCHAR2(9 BYTE), 
	CONSTRAINT ERROR_LOG_PK PRIMARY KEY (ERROR_ID, COST_CENTER, ERROR_DATE, MODULE) ENABLE
   );

   COMMENT ON COLUMN ERROR_LOG.ERROR_ID IS 'Transaction Sequence ID';
   COMMENT ON COLUMN ERROR_LOG.COST_CENTER IS 'Cost Center cauding error';
   COMMENT ON COLUMN ERROR_LOG.ERROR_DATE IS 'Date error was added';
   COMMENT ON COLUMN ERROR_LOG.MODULE IS 'Application Name/or batch job name';
   COMMENT ON COLUMN ERROR_LOG.ERROR_TEXT IS 'Error message text';
   COMMENT ON COLUMN ERROR_LOG.NOTES IS 'Free Notes....';
   COMMENT ON COLUMN ERROR_LOG.ERROR_CODE IS 'ERROR CODE';
