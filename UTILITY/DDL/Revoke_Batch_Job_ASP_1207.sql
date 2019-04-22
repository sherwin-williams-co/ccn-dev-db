/*
     Revoke_Batch_Job_ASP_1207.sql
     This Script REVOKES all access on BATCH_JOB table from all CCN users
     and DROPs SYNONYMs for CCN_UTILITY.BATCH_JOB 

     Created : 03/20/2019 mxs216 ASP-1207 CCN Project Team....
*/
REVOKE ALL PRIVILEGES ON BATCH_JOB FROM BANKING;
REVOKE ALL PRIVILEGES ON BATCH_JOB FROM COSTCNTR;
REVOKE ALL PRIVILEGES ON BATCH_JOB FROM CSTMR_DPSTS;
REVOKE ALL PRIVILEGES ON BATCH_JOB FROM STORDRFT;

DROP SYNONYM BANKING.BATCH_JOB;
DROP SYNONYM COSTCNTR.BATCH_JOB;
DROP SYNONYM CSTMR_DPSTS.BATCH_JOB;
DROP SYNONYM STORDRFT.BATCH_JOB;