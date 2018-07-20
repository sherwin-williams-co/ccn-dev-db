  ********************************************************************************** 
This script is used to create a table in costcenter database. Need this table for cleansing address process. 

CCN_ADDRESS_GEO_V_DETAILS - Everyday this table will be truncated and reloaded. This table will always store the current data.

Created : 07/19/2018 pxa852 CCN Project ASP-873....
Modified: 
**********************************************************************************/

CREATE TABLE CCN_ADDRESS_GEO_V_DETAILS 
   (STORE            VARCHAR2(6),
    STREET           VARCHAR2(100),
    STREET2          VARCHAR2(100),
    CITY             VARCHAR2(25),
    STATE            VARCHAR2(10),
    ZIP              VARCHAR2(10),
    ZIP4             VARCHAR2(4),
    LON              VARCHAR2(11),
    LAT              VARCHAR2(11),
    COUNTRY_3        VARCHAR2(3),
    MANUAL_OVERRIDE  VARCHAR2(10),
    COUNTY           VARCHAR2(30),
CONSTRAINT "PK_CCN_ADDRESS_GEO_V_DETAILS" PRIMARY KEY (STORE));
