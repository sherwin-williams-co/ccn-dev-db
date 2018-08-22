/*******************************************************************************
Created : 02/20/2018 BXA919 CCN Project Team...
          The script will created tables  CCN_PD_CAN  table. PRICE DISTRICT report
          is generated with multiple tabs(CAN,USA) the data for each country is strored
          in corresponding table
Changed : 08/22/2018 pxa852 CCn Project Team...
          This script is modified to add new fields POS Start and POS End Date.
*******************************************************************************/
DROP TABLE CCN_PRICING_DISTRICT_CAN;

CREATE TABLE CCN_PRICING_DISTRICT_CAN(
     STORE_NO                       VARCHAR2(6),
     STORE_NO_DESC                  VARCHAR2(100),
     STORE_ADDRESS_STREET           VARCHAR2(100),
     STORE_ADDRESS_CITY             VARCHAR2(25),
     STORE_ADDRESS_PROVINCE         VARCHAR2(3),
     STORE_ADDRESS_POSTAL           VARCHAR2(15),
     STORE_PHONE_NO                 VARCHAR2(15),
     STORE_FAX_NO                   VARCHAR2(15),
     STORE_DIV                      VARCHAR2(3),
     STORE_DIV_DESC                 VARCHAR2(4000),
     STORE_AREA                     VARCHAR2(4000),
     STORE_AREA_NAME                VARCHAR2(4000),
     STORE_AREA_NAME_SHORT          VARCHAR2(4000),
     STORE_DAD                      VARCHAR2(4000),
     STORE_DAD_DESC                 VARCHAR2(4000),
     STORE_OPEN_DATE                DATE,
     STORE_CLOSE_DATE               DATE,
     STATEMENT_TYPE                 VARCHAR2(3),
     STATEMENT_TYPE_DESC            VARCHAR2(4000),
     STORE_POLLING_STATUS_CODE      VARCHAR2(1),
     STORE_POLLING_STATUS_CODE_DESC VARCHAR2(4000),
     STORE_TYPE                     VARCHAR2(3),
     STORE_TYPE_DESC                VARCHAR2(4000),
     STORE_PRICING_DISTRICT         VARCHAR2(4000),
     STORE_POS_START_DATE           DATE,
     STORE_POS_END_DATE             DATE);

GRANT SELECT ON CCN_PRICING_DISTRICT_CAN TO CCN_UTILITY;
CREATE OR REPLACE SYNONYM CCN_UTILITY.CCN_PRICING_DISTRICT_CAN FOR CCN_PRICING_DISTRICT_CAN;