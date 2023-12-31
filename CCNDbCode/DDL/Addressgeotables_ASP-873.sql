

  ********************************************************************************** 
This script is used to create a history table and current table in costcenter database. Need these two tables for cleansing address process. 
CCN_ADDRESS_GEO_V_HIST - History will be maintained in this table
CCN_ADDRESS_GEO_V_DETAILS - Evenryday this table will be truncated and reloaded. This table will always store the current data.

Created : 07/19/2018 pxa852 CCN Project ASP-873....
Modified: 
**********************************************************************************/
CREATE TABLE "COSTCNTR"."CCN_ADDRESS_GEO_V_HIST" 
   (	"STORE" VARCHAR2(6 BYTE) NOT NULL ENABLE, 
	"STREET" VARCHAR2(100 BYTE), 
	"STREET2" VARCHAR2(100 BYTE), 
	"CITY" VARCHAR2(25 BYTE), 
	"STATE" VARCHAR2(10 BYTE), 
	"ZIP" VARCHAR2(10 BYTE), 
	"ZIP4" VARCHAR2(4 BYTE), 
	"LON" VARCHAR2(11 BYTE), 
	"LAT" VARCHAR2(11 BYTE), 
	"COUNTRY_3" VARCHAR2(3 BYTE), 
	"MANUAL_OVERRIDE" VARCHAR2(10 BYTE), 
	"COUNTY" VARCHAR2(30 BYTE), 
	"LOAD_DATE" DATE, 
	 CONSTRAINT "PK_CCN_ADDRESS_GEO_V_HIST" PRIMARY KEY ("STORE", "LOAD_DATE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "COSTCNTR_DATA"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "COSTCNTR_DATA" ;   

CREATE TABLE "COSTCNTR"."CCN_ADDRESS_GEO_V_DETAILS" 
   (	"STORE" VARCHAR2(6 BYTE) NOT NULL ENABLE, 
	"STREET" VARCHAR2(100 BYTE), 
	"STREET2" VARCHAR2(100 BYTE), 
	"CITY" VARCHAR2(25 BYTE), 
	"STATE" VARCHAR2(10 BYTE), 
	"ZIP" VARCHAR2(10 BYTE), 
	"ZIP4" VARCHAR2(4 BYTE), 
	"LON" VARCHAR2(11 BYTE), 
	"LAT" VARCHAR2(11 BYTE), 
	"COUNTRY_3" VARCHAR2(3 BYTE), 
	"MANUAL_OVERRIDE" VARCHAR2(10 BYTE), 
	"COUNTY" VARCHAR2(30 BYTE), 
	 CONSTRAINT "PK_CCN_ADDRESS_GEO_V_DETAILS" PRIMARY KEY ("STORE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "COSTCNTR_DATA"  ENABLE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "COSTCNTR_DATA" ;


