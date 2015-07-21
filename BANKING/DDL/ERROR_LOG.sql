  CREATE TABLE ERROR_LOG 
   (ERROR_ID NUMBER NOT NULL ENABLE, 
	BANK_ACCOUNT_NBR VARCHAR2(16) NOT NULL ENABLE, 
	ERROR_DATE DATE NOT NULL ENABLE, 
	"MODULE" VARCHAR2(65) NOT NULL ENABLE, 
	ERROR_TEXT VARCHAR2(500), 
	NOTES VARCHAR2(200), 
	ERROR_CODE VARCHAR2(9), 
	COST_CENTER_CODE VARCHAR2(6), 
	TABLE_NAME VARCHAR2(30), 
	CONSTRAINT ERROR_LOG_PK PRIMARY KEY (ERROR_ID, BANK_ACCOUNT_NBR, ERROR_DATE, MODULE)
     );
  
   COMMENT ON COLUMN "BANKING"."ERROR_LOG"."ERROR_ID" IS 'Transaction Sequence ID';
   COMMENT ON COLUMN "BANKING"."ERROR_LOG"."BANK_ACCOUNT_NBR" IS 'Bank Account Number causing error';
   COMMENT ON COLUMN "BANKING"."ERROR_LOG"."ERROR_DATE" IS 'Date error was added';
   COMMENT ON COLUMN "BANKING"."ERROR_LOG"."MODULE" IS 'Application Name/or batch job name';
   COMMENT ON COLUMN "BANKING"."ERROR_LOG"."ERROR_TEXT" IS 'Error message text';
   COMMENT ON COLUMN "BANKING"."ERROR_LOG"."NOTES" IS 'Free Notes....';
   COMMENT ON COLUMN "BANKING"."ERROR_LOG"."ERROR_CODE" IS 'ERROR CODE';
   COMMENT ON COLUMN "BANKING"."ERROR_LOG"."COST_CENTER_CODE" IS 'Cost Center Code causing error';
   COMMENT ON COLUMN "BANKING"."ERROR_LOG"."TABLE_NAME" IS 'table name for which error occured';

  CREATE INDEX "BANKING"."ERROR_LOG_INDEX1" ON "BANKING"."ERROR_LOG" ("ERROR_ID", "ERROR_DATE", "BANK_ACCOUNT_NBR", "MODULE");

  /