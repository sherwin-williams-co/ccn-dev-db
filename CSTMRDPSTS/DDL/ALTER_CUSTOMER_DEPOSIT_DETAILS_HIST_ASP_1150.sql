/***************************************************
This script to drop the field "TOTAL_SALES" from  CUSTOMER_DEPOSIT_DETAILS_HIST

Created : 12/06/2018 sxg151 CCN Project Team....
        : ASP-1150
***************************************************/

ALTER TABLE CUSTOMER_DEPOSIT_DETAILS_HIST
DROP COLUMN TOTAL_SALES;