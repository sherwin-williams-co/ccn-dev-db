/*
Created :dxv848 09/01/2015 DDL for MARKETING_TEMP table.
*/

  CREATE TABLE MARKETING_TEMP
   (STORE_NUMBER VARCHAR2(6), 
	NAME VARCHAR2(35), 
	CITY VARCHAR2(35), 
	STATE VARCHAR2(2), 
	DAD_DESC VARCHAR2(35), 
	BRAND VARCHAR2(1), 
	MISSION VARCHAR2(3), 
	SALE_FLOOR_SQ_FT VARCHAR2(2), 
	WAREHOUSE_SQ_FT  VARCHAR2(2), 
	REAL_ESTATE_SET  VARCHAR2(2), 
	MISSION_CODE  VARCHAR2(2), 
	AOM_DSC  VARCHAR2(35), 
	VOC  VARCHAR2(20), 
	DAD_ID  VARCHAR2(5), 
	COUNTRY  VARCHAR2(3), 
	DBKEY  VARCHAR2(6), 
	COUNTY  VARCHAR2(35), 
	STATUS  VARCHAR2(6), 
	MGR_LAST_NAME  VARCHAR2(35), 
	MGR_FIRST_NAME  VARCHAR2(35), 
	ADDRESS_LINE_1  VARCHAR2(35), 
	ADDRESS_LINE_2  VARCHAR2(35), 
	PHONE  NUMBER(10,0), 
	ZIPCODE  VARCHAR2(20), 
	DIY_QUANTITY  NUMBER(10,2), 
	DIV_ID  VARCHAR2(2), 
	DIV_ID_DESC  VARCHAR2(35), 
	AREA_ID  VARCHAR2(3), 
	AREA_DESC  VARCHAR2(35), 
	DB_USER  VARCHAR2(10), 
	FLAG_1  VARCHAR2(2), 
	DB_TIME  DATE, 
	DATE_FROM  DATE, 
	DATE_TO  DATE, 
	DBCURRENTUSER  VARCHAR2(10)
   ) ;

   
   
/*
Alter marketing table.
*/   

ALTER TABLE MARKETING
  MODIFY  (MKT_SALES_FLOOR_SIZE VARCHAR(2),
           MKT_WAREHOUSE_SIZE VARCHAR(2),
           MKT_REAL_ESTATE_SETTING VARCHAR(2));