
  ********************************************************************************** 
This script is used to create a history table in costcenter database. Need this table for cleansing address process. 
CCN_ADDRESS_GEO_V_HIST - History will be maintained in this table

Created : 07/19/2018 pxa852 CCN Project ASP-873....
Modified: 
**********************************************************************************/
CREATE TABLE CCN_ADDRESS_GEO_V_HIST 
   (STORE              VARCHAR2(6),
    STREET             VARCHAR2(100),
    STREET2            VARCHAR2(100),
    CITY               VARCHAR2(25),
    STATE              VARCHAR2(10),
    ZIP                VARCHAR2(10),
    ZIP4               VARCHAR2(4),
    LON                VARCHAR2(11),
    LAT                VARCHAR2(11),
    COUNTRY_3          VARCHAR2(3),
    MANUAL_OVERRIDE    VARCHAR2(10),
    COUNTY             VARCHAR2(30),
    LOAD_DATE          DATE,
CONSTRAINT "PK_CCN_ADDRESS_GEO_V_HIST" PRIMARY KEY (STORE, LOAD_DATE));