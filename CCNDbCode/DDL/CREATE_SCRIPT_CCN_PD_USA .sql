/*******************************************************************************
Created : 02/20/2018 BXA919 CCN Project Team...
		 The script will created tables  CCN_PD_USA  table. PRICE DISTRICT report 
		 is generated with multiple tabs(CAN,USA) the data for each country is strored
		 in corresponding table
*******************************************************************************/
CREATE TABLE CCN_PRICING_DISTRICT_USA (	
	STORE_NO 					VARCHAR2(6), 
	STORE_NO_DESC 					VARCHAR2(100), 
	STORE_ADDRESS_STREET 				VARCHAR2(100), 
	STORE_ADDRESS_CITY 				VARCHAR2(25), 
	STORE_ADDRESS_STATE 				VARCHAR2(3), 
	STORE_ADDRESS_ZIP 				VARCHAR2(15), 
	STORE_PHONE_NO 					VARCHAR2(15), 
	STORE_FAX_NO 					VARCHAR2(15), 
	STORE_DIV 					VARCHAR2(3), 
	STORE_DIV_DESC 					VARCHAR2(4000), 
	STORE_AREA 					VARCHAR2(4000), 
	STORE_AREA_NAME 				VARCHAR2(4000), 
	STORE_AREA_NAME_SHORT 				VARCHAR2(4000), 
	STORE_DAD 					VARCHAR2(4000), 
	STORE_DAD_DESC 					VARCHAR2(4000), 
	STORE_OPEN_DATE 				DATE, 
	STORE_CLOSE_DATE 				DATE, 
	STATEMENT_TYPE 					VARCHAR2(3), 
	STATEMENT_TYPE_DESC 				VARCHAR2(4000), 
	STORE_POLLING_STATUS_CODE 			VARCHAR2(1), 
	STORE_POLLING_STATUS_CODE_DESC 			VARCHAR2(4000), 
	STORE_TYPE 					VARCHAR2(3), 
	STORE_TYPE_DESC 				VARCHAR2(4000), 
	STORE_PRICING_DISTRICT 				VARCHAR2(4000)); 