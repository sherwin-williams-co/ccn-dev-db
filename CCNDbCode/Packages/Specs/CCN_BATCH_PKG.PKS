CREATE OR REPLACE PACKAGE CCN_BATCH_PKG AS
/*********************************************************** 
This package "SPEC" has procedures and functions related to the batch
job table

created : 04/10/2013 SH CCN project
revisions: 
************************************************************/
  
PROCEDURE INSERT_BATCH_JOB (
/**********************************************************
	INSERT_BATCH_JOB

	This procedure is intended to insert a record in the Batch_Job
        table with the details related to the batch run

created : 04/10/2013 SH CCN project....
**********************************************************/
    IN_BATCH_JOB_NAME      IN BATCH_JOB.BATCH_JOB_NAME%TYPE,
    OUT_BATCH_NUMBER       OUT BATCH_JOB.BATCH_JOB_NUMBER%TYPE
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

PROCEDURE LOAD_FIPS_CODE_UPDATES
/*****************************************************************************
	LOAD_FIPS_CODE_UPDATES

	This procedure is intended to perform the FIPS Code updates to USA Addresses.
  The FIPS Code Updates will be available from a Flat File from the HEARS Group.
  That Flat File is currently referenced as an exteral Temp Table definition.
  
	This Procedure will Loop thru the Temp Table and process each entry.
  For each entry:
    Locate the 6 digit Cost Center referenced by the 4 digit Cost Center supplied.
    Verify that the Cost Center is a USA Cost Center.
    Select the Address_USA associated with the Cost_Center.
    Compare the existing FIPS Code to the new FIPS Code.
    IF they are different, then 
      Replace the existing FIPS Code with the new FIPS Code.
      Update the Address_USA entry.
      
created : 05/15/2013 TAL CCN Project....
revised : 
******************************************************************************/
   ;
 
PROCEDURE UPDATE_TERR_PHONE_NUMBERS_SP
(FIRST_CHARACTER IN VARCHAR) ;

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


END CCN_BATCH_PKG;

