
  CREATE TABLE VENDOR_INFO
   (TAX_ID VARCHAR2(90 BYTE), 
	VENDOR_NO VARCHAR2(450 BYTE), 
	VENDOR_NAME VARCHAR2(720 BYTE), 
	SITE_LAST_UPDATE_DATE DATE
   ) ;

  CREATE INDEX VNDR_TX_ID_ST_LST_UPDT_DT_IDX ON VENDOR_INFO (TAX_ID, SITE_LAST_UPDATE_DATE);
