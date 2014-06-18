CREATE TABLE "STORDRFT"."STORE_DRAFT_DETAIL_T" 
   (	"COST_CENTER_CODE" VARCHAR2(6 BYTE), 
	"CHECK_SERIAL_NUMBER" VARCHAR2(10 BYTE), 
	"TRANSACTION_DATE" VARCHAR2(8 BYTE), 
	"TERM_NUMBER" VARCHAR2(5 BYTE), 
	"TRANSACTION_NUMBER" VARCHAR2(5 BYTE), 
	"CUSTOMER_ACCOUNT_NUMBER" VARCHAR2(9 BYTE), 
	"CUSTOMER_JOB_NUMBER" VARCHAR2(2 BYTE), 
	"GL_PRIME_ACCOUNT_NUMBER" VARCHAR2(4 BYTE), 
	"GL_SUB_ACCOUNT_NUMBER" VARCHAR2(3 BYTE), 
	"ITEM_QUANTITY" VARCHAR2(7 BYTE), 
	"ITEM_PRICE" VARCHAR2(7 BYTE), 
	"ITEM_EXT_AMOUNT" VARCHAR2(7 BYTE), 
	"BOOK_DATE_SEQUENCE" VARCHAR2(5 BYTE), 
	"LBR_TRANSACTION_DATE" VARCHAR2(8 BYTE), 
	"LBR_TERM_NUMBER" VARCHAR2(5 BYTE), 
	"LBR_TRANSACTION_NUMBER" VARCHAR2(5 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "STORDRFT_DATA" ;

  CREATE INDEX "STORDRFT"."STORE_DRAFT_DETAIL_T_INDX" ON "STORDRFT"."STORE_DRAFT_DETAIL_T" ("COST_CENTER_CODE", "LBR_TRANSACTION_DATE", "LBR_TERM_NUMBER", "LBR_TRANSACTION_NUMBER") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "STORDRFT_DATA" ;
