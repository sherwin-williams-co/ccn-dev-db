create or replace PACKAGE CUST_DEP_BATCH_PKG AS
/*********************************************************** 
This package spec has procedures and functions related to the batch
job table

created : 09/27/2017 sxh487 CCN project
revisions: 
************************************************************/
  
PROCEDURE INSERT_BATCH_JOB (
/**********************************************************
INSERT_BATCH_JOB

This procedure is intended to insert a record in the Batch_Job
table with the details related to the batch run
created : 09/27/2017 sxh487 CCN project
**********************************************************/
IN_BATCH_JOB_NAME      IN BATCH_JOB.BATCH_JOB_NAME%TYPE,
OUT_BATCH_NUMBER       OUT BATCH_JOB.BATCH_JOB_NUMBER%TYPE,
IN_SERVER_NAME         IN  BATCH_JOB.SERVER_NAME%TYPE DEFAULT NULL,
IN_LOG_FILE            IN  BATCH_JOB.LOG_FILE%TYPE DEFAULT NULL
);

PROCEDURE UPDATE_BATCH_JOB(
/**********************************************************
UPDATE_BATCH_JOB

This procedure is intended to update the record in the Batch_Job
table with the Status of - IN_PROCESSING, COMPLETED OR ERROR
created : 09/27/2017 sxh487 CCN project
**********************************************************/
IN_BATCH_JOB_NAME      IN BATCH_JOB.BATCH_JOB_NAME%TYPE,
IN_BATCH_JOB_NUMBER    IN BATCH_JOB.BATCH_JOB_NUMBER%TYPE,
IN_TRANS_STATUS        IN BATCH_JOB.TRANS_STATUS%TYPE
);

END CUST_DEP_BATCH_PKG;