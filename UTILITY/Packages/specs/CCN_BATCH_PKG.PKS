create or replace PACKAGE CCN_BATCH_PKG AS
/*********************************************************** 
This package "SPEC" has procedures and functions related to the batch
job table

created : 04/10/2013 SH CCN project
revisions: 03/26/2019 mxs216 ASP-1207 CCN Project...
           Added new PUBLIC TYPE BATCH_JOB_TYPE.
************************************************************/

BATCH_JOB_TYPE 	BATCH_JOB%ROWTYPE;
  
PROCEDURE INSERT_BATCH_JOB (
/**********************************************************
	INSERT_BATCH_JOB

	This procedure is intended to insert a record in the Batch_Job
        table with the details related to the batch run

created : 04/10/2013 SH CCN project....
Modified: 08/19/2016 nxk927 CCN project....
          changed signature. Added servername and logfile name
**********************************************************/
    IN_BATCH_JOB_NAME      IN BATCH_JOB.BATCH_JOB_NAME%TYPE,
    OUT_BATCH_NUMBER       OUT BATCH_JOB.BATCH_JOB_NUMBER%TYPE,
    IN_SERVER_NAME         IN  BATCH_JOB.SERVER_NAME%TYPE DEFAULT NULL,
    IN_LOG_FILE            IN  BATCH_JOB.LOG_FILE%TYPE DEFAULT NULL
                          );

PROCEDURE UPDATE_BATCH_JOB(
/**********************************************************
	INSERT_BATCH_JOB

	This procedure is intended to update the record in the Batch_Job
        table with the Status of - IN_PROCESSING, COMPLETED OR ERROR

created : 04/10/2013 SH CCN project....
**********************************************************/
    IN_BATCH_JOB_NAME      IN BATCH_JOB.BATCH_JOB_NAME%TYPE,
    IN_BATCH_JOB_NUMBER    IN BATCH_JOB.BATCH_JOB_NUMBER%TYPE,
    IN_TRANS_STATUS        IN BATCH_JOB.TRANS_STATUS%TYPE
                          );

PROCEDURE LOCK_DATABASE_SP
/*****************************************************************************
Name:   : LOCK_DATABASE_SP
created : 11/15/2013 CCN KDP Project....
revised : 
******************************************************************************/
;

PROCEDURE UNLOCK_DATABASE_SP
/*****************************************************************************
Name:   : unLOCK_DATABASE_SP
created : 11/15/2013 CCN KDP Project....
revised : 
******************************************************************************/
;

PROCEDURE FILE_UPLOAD(
/******************************************************************************
FILE_UPLOAD

This procedure will create file on server and dump the passed BLOB data Into the file created

IN_BLOB          - blob value delimited by , and termianted by new line character
IN_FILE_NAME     - name of the file on server

******************************************************************************/
IN_BLOB        IN       BLOB,
IN_FILE_NAME   IN       VARCHAR2,
IN_DIRECTORY   IN       VARCHAR2 DEFAULT 'CCN_LOAD_FILES');

FUNCTION FILE_EXISTS(
/******************************************************************************
Created : 10/04/2017 axt754 CCN Project Team....
FILE_EXISTS

This procedure will check if the file exists in directory and returns 'Y' or 'N'
******************************************************************************/
IN_FILE_NAME    IN       VARCHAR2,
IN_DIRECTORY    IN       VARCHAR2) RETURN VARCHAR2;

PROCEDURE FILE_RENAME(
/******************************************************************************
Created : 09/29/2017 axt754 CCN Project Team....
FILE_RENAME

This procedure will rename file on server by taking the old name and new name.
******************************************************************************/
IN_OLD_FILE    IN       VARCHAR2,
IN_NEW_FILE    IN       VARCHAR2,
IN_DIRECTORY   IN       VARCHAR2 DEFAULT 'CCN_LOAD_FILES');

FUNCTION GET_LAST_RUNDATE(
/******************************************************************
This function will return the LAST BATCH RUN DATE for the batch name passed

created : 09/27/2017 nxk927 CCN Project....
changed :
******************************************************************/
IN_BATCH_NAME       IN   VARCHAR2) RETURN DATE;

FUNCTION GET_LAST_STARTDATE(
/******************************************************************
This function will return the LAST BATCH START DATE for the batch name passed

created : 09/28/2017 nxk927 CCN Project....
changed :
******************************************************************/
IN_BATCH_NAME       IN   VARCHAR2) RETURN DATE;

END CCN_BATCH_PKG;