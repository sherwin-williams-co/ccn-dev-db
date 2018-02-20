/*******************************************************************************
Created : 02/20/2018 BXA919 CCN Project Team...
		 The script will created tables  CCN_PD_USA  table. PRICE DISTRICT report 
		 is generated with multiple tabs(CAN,USA) the data for each country is strored
		 in corresponding table
*******************************************************************************/
CREATE TABLE CCN_PD_USA (	
	STORE_NO VARCHAR2(6 BYTE), 
	STORE_NO_DESC VARCHAR2(100 BYTE), 
	STORE_ADDRESS_STREET VARCHAR2(100 BYTE), 
	STORE_ADDRESS_CITY VARCHAR2(25 BYTE), 
	STORE_ADDRESS_STATE VARCHAR2(3 BYTE), 
	STORE_ADDRESS_ZIP VARCHAR2(15 BYTE), 
	STORE_PHONE_NO VARCHAR2(15 BYTE), 
	STORE_FAX_NO VARCHAR2(15 BYTE), 
	STORE_DIV VARCHAR2(3 BYTE), 
	STORE_DIV_DESC VARCHAR2(4000 BYTE), 
	STORE_AREA VARCHAR2(4000 BYTE), 
	STORE_AREA_NAME VARCHAR2(4000 BYTE), 
	STORE_AREA_NAME_SHORT VARCHAR2(4000 BYTE), 
	STORE_DAD VARCHAR2(4000 BYTE), 
	STORE_DAD_DESC VARCHAR2(4000 BYTE), 
	STORE_OPEN_DATE DATE, 
	STORE_CLOSE_DATE DATE, 
	STATEMENT_TYPE VARCHAR2(3 BYTE), 
	STATEMENT_TYPE_DESC VARCHAR2(4000 BYTE), 
	STORE_POLLING_STATUS_CODE VARCHAR2(1 BYTE), 
	STORE_POLLING_STATUS_CODE_DESC VARCHAR2(4000 BYTE), 
	STORE_TYPE VARCHAR2(3 BYTE), 
	STORE_TYPE_DESC VARCHAR2(4000 BYTE), 
	STORE_PRICING_DISTRICT VARCHAR2(4000 BYTE)); 