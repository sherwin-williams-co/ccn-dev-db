--creating backup tables, index and deleting rls_run_cycle accounts for rls_cycle 0 rerun
--sxh487 08/30/2018

CREATE TABLE CCN_HDR_T_RLS0_BK AS SELECT * FROM CCN_HEADERS_T;
CREATE TABLE CCN_SALES_LINES_T_RLS0_BK AS SELECT * FROM CCN_SALES_LINES_T;

CREATE TABLE CUSTOMER_DEPOSIT_DET_BKUP2 AS SELECT * FROM CUSTOMER_DEPOSIT_DETAILS;
CREATE TABLE CUSTOMER_DEPOSIT_HEADER_BKUP2 AS SELECT * FROM CUSTOMER_DEPOSIT_HEADER;
CREATE TABLE CUST_DEP_REDEMPTION_DET_BKUP2 AS SELECT * FROM CUST_DEP_REDEMPTION_DETAILS;
CREATE TABLE CUST_DEP_CREDIT_DET_BKUP2 AS SELECT * FROM CUST_DEP_CREDIT_DETAILS;

CREATE INDEX CUSTOMER_DEPOSIT_DETAILS_INDX ON CUSTOMER_DEPOSIT_DETAILS (CUSTOMER_ACCOUNT_NUMBER);
