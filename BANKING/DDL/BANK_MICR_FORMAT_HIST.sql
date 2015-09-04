  CREATE TABLE BANK_MICR_FORMAT_HIST 
   (	BANK_ACCOUNT_NBR VARCHAR2(20) NOT NULL ENABLE,
	FORMAT_NAME VARCHAR2(6) NOT NULL ENABLE,
	DJDE_FORM_PARM VARCHAR2(6),
	DJDE_FEED_PARM VARCHAR2(5),
	MICR_COST_CNTR VARCHAR2(8),
	MICR_ROUTING_NBR VARCHAR2(11),
	MICR_FORMAT_ACTNBR VARCHAR2(17),
	EFFECTIVE_DATE DATE NOT NULL ENABLE,
	EXPIRATION_DATE DATE,
	LAST_MAINTENANCE_DATE DATE,
	LAST_MAINT_USER_ID VARCHAR2(6),
	UPDATE_DATE DATE NOT NULL ENABLE,
	LAST_UPD_USER_ID VARCHAR2(8) NOT NULL ENABLE,
	MICR_FORMAT_ID NUMBER,
	CONSTRAINT BANK_MICR_FORMAT_HIST_PK PRIMARY KEY (MICR_FORMAT_ID,BANK_ACCOUNT_NBR,EFFECTIVE_DATE) ENABLE
   );
  / 
  CREATE INDEX BANK_MICR_FORMAT_HIST_INDX ON BANK_MICR_FORMAT_HIST (BANK_ACCOUNT_NBR, EFFECTIVE_DATE);
  /
