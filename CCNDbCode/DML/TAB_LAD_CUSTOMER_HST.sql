/*******************************************************************************
Created : 10/04/2018 sxg151 CCN Project Team...
          The script will create LAD_CUSTOMER_HST table to track changes on LAD_CUSTOMER table.
Changed :
*******************************************************************************/
CREATE TABLE LAD_CUSTOMER_HST
   (COST_CENTER_CODE  VARCHAR2(6) NOT NULL ,
    CATEGORY          VARCHAR2(1) NOT NULL,
    LAD_CUSTOMER_TYPE VARCHAR2(2),
    ALLOCATION_CC     VARCHAR2(10),
    CHANGED_DATE      DATE
    );