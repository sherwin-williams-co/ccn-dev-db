  CREATE TABLE MEMBER_BANK_CC 
   (LEAD_BANK_ACCOUNT_NBR VARCHAR2(16 BYTE) NOT NULL ENABLE, 
	LEAD_STORE_NBR VARCHAR2(6 BYTE) NOT NULL ENABLE, 
	MEMBER_STORE_NBR VARCHAR2(6 BYTE) NOT NULL ENABLE, 
	EFFECTIVE_DATE DATE NOT NULL ENABLE, 
	EXPIRATION_DATE DATE, 
	MEMBER_BANK_ACCOUNT_NBR VARCHAR2(16 BYTE), 
	BANK_BRANCH_NBR VARCHAR2(8 BYTE), 
	UPDATE_DATE DATE NOT NULL ENABLE, 
	LAST_UPD_USER_ID VARCHAR2(8 BYTE) NOT NULL ENABLE, 
	 CONSTRAINT MEMBER_BANK_CC_PK PRIMARY KEY (LEAD_BANK_ACCOUNT_NBR, LEAD_STORE_NBR, MEMBER_STORE_NBR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE BANKING_DATA  ENABLE, 
	 CONSTRAINT MEMBER_BANK_CC_FK FOREIGN KEY (LEAD_BANK_ACCOUNT_NBR, LEAD_STORE_NBR)
	  REFERENCES BANKING.LEAD_BANK_CC (LEAD_BANK_ACCOUNT_NBR, LEAD_STORE_NBR) ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "BANKING_DATA" ;
  /