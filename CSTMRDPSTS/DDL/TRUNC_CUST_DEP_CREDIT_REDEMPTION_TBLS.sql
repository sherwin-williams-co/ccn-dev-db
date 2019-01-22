/**********************************************************************************
This script is used to create backup tables and truncate data from Credit and Redemption details tables to reload it with correct details.
Created : 01/16/2019 pxa852 CCN Project Team....
Modified:
**********************************************************************************/
--Creating backup tables
CREATE TABLE CUST_DEPOSIT_DETAILS_BKUP_17JAN2019 AS SELECT * FROM CUSTOMER_DEPOSIT_DETAILS;
CREATE TABLE CUST_DEP_CRD_DETAILS_BKUP_17JAN2019 AS SELECT * FROM CUST_DEP_CREDIT_DETAILS;
CREATE TABLE CUST_DEP_RED_DETAILS_BKUP_17JAN2019 AS SELECT * FROM CUST_DEP_REDEMPTION_DETAILS;
--Truncating tables
 TRUNCATE TABLE CUST_DEP_CREDIT_DETAILS;
 TRUNCATE TABLE CUST_DEP_REDEMPTION_DETAILS;