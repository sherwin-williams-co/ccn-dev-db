  CREATE TABLE BANK_MICR_FORMAT 
   (	BANK_ACCOUNT_NBR VARCHAR2(16 BYTE) NOT NULL ENABLE, 
	FORMAT_NAME VARCHAR2(6 BYTE) NOT NULL ENABLE, 
	DJDE_FORM_PARM VARCHAR2(6 BYTE), 
	DJDE_FEED_PARM VARCHAR2(5 BYTE), 
	MICR_COST_CNTR VARCHAR2(8 BYTE), 
	MICR_ROUTING_NBR VARCHAR2(11 BYTE), 
	MICR_FORMAT_ACTNBR VARCHAR2(17 BYTE), 
	REORDER_POINT VARCHAR2(5 BYTE), 
	REORDER_NUMBER_BKS VARCHAR2(5 BYTE), 
	IMAGES_PER_PAGE VARCHAR2(1 BYTE), 
	NBR_FORMS_PER_BK VARCHAR2(5 BYTE), 
	PART_PAPER_PER_FORM VARCHAR2(1 BYTE), 
	NBR_DEP_TICKETS_PER_BK VARCHAR2(5 BYTE), 
	SHEETS_OF_PAPER_PER_BK VARCHAR2(5 BYTE), 
	EFFECTIVE_DATE DATE NOT NULL ENABLE, 
	EXPIRATION_DATE DATE, 
	LAST_MAINTENANCE_DATE DATE, 
	LAST_MAINT_USER_ID VARCHAR2(6 BYTE), 
	UPDATE_DATE DATE NOT NULL ENABLE, 
	LAST_UPD_USER_ID VARCHAR2(8 BYTE) NOT NULL ENABLE, 
	 CONSTRAINT BANK_MICR_FORMAT_PK PRIMARY KEY (BANK_ACCOUNT_NBR, FORMAT_NAME, EFFECTIVE_DATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE BANKING_DATA  ENABLE, 
	 CONSTRAINT BANK_MICR_FORMAT_FK1 FOREIGN KEY (BANK_ACCOUNT_NBR)
	  REFERENCES BANKING.BANK_ACCOUNT (BANK_ACCOUNT_NBR) ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "BANKING_DATA" ;
 /