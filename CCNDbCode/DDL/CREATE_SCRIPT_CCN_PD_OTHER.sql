/*******************************************************************************
Created : 03/22/2018 bxa919 CCN Project Team...
          The script will created tables  CCN_COST_CENTER_INFO table.The data in the table 
          is used to generate 'CCN08900' file to sens ro Real Estate.
        : 03/27/2018 bxa919 CCN Project Team ...
          As joan asked to dispaly Province and state in one column renamed teh column name
          as "STORE_ADDRESS_STATE/PROVINCE"
*******************************************************************************/
DROP TABLE CCN_PRICING_DISTRICT_OTHER;
CREATE TABLE CCN_PRICING_DISTRICT_OTHER(
    STORE_NO                                   VARCHAR2(6), 
    STORE_NO_DESC                              VARCHAR2(100), 
    STORE_ADDRESS_STREET                       VARCHAR2(100), 
    STORE_ADDRESS_CITY                         VARCHAR2(25), 
    "STORE_ADDRESS_STATE/PROVINCE"             VARCHAR2(25), 
    STORE_ADDRESS_POSTAL                       VARCHAR2(15), 
    STORE_PHONE_NO                             VARCHAR2(15), 
    STORE_FAX_NO                               VARCHAR2(15), 
    STORE_DIV                                  VARCHAR2(3), 
    STORE_DIV_DESC                             VARCHAR2(4000), 
    STORE_AREA                                 VARCHAR2(4000), 
    STORE_AREA_NAME                            VARCHAR2(4000), 
    STORE_AREA_NAME_SHORT                      VARCHAR2(4000), 
    STORE_DAD                                  VARCHAR2(4000), 
    STORE_DAD_DESC                             VARCHAR2(4000), 
    STORE_OPEN_DATE                            DATE, 
    STORE_CLOSE_DATE                           DATE, 
    STATEMENT_TYPE                             VARCHAR2(3), 
    STATEMENT_TYPE_DESC                        VARCHAR2(4000), 
    STORE_POLLING_STATUS_CODE                  VARCHAR2(1), 
    STORE_POLLING_STATUS_CODE_DESC             VARCHAR2(4000), 
    STORE_TYPE                                 VARCHAR2(3), 
    STORE_TYPE_DESC                            VARCHAR2(4000), 
    STORE_PRICING_DISTRICT                     VARCHAR2(4000));


 
GRANT SELECT ON CCN_PRICING_DISTRICT_OTHER TO CCN_UTILITY;
CREATE OR REPLACE SYNONYM CCN_UTILITY.CCN_PRICING_DISTRICT_OTHER FOR CCN_PRICING_DISTRICT_OTHER;

