/*
Below grants and synonyms are needed for batch job execution

Created : 11/7/2019 jxc517 CCN Project Team....
Changed :
*/

GRANT EXECUTE ON CUSTOMER_DEPOSITS_DAILY_LOAD    to CSTMR_DPSTS_USR;
CREATE OR REPLACE SYNONYM CSTMR_DPSTS_USR.CUSTOMER_DEPOSITS_DAILY_LOAD FOR CSTMR_DPSTS.CUSTOMER_DEPOSITS_DAILY_LOAD;

GRANT EXECUTE ON CUST_DEP_BATCH_PKG              to CSTMR_DPSTS_USR;
CREATE OR REPLACE SYNONYM CSTMR_DPSTS_USR.CUST_DEP_BATCH_PKG FOR CSTMR_DPSTS.CUST_DEP_BATCH_PKG;