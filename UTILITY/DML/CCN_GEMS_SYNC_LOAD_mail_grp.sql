/*
Below script will insert a new group for CCN_GEMS_SYNC_LOAD
Created : 10/26/2016 sxh487 CCN Project Team....
*/

SET SCAN OFF;
REM INSERTING into MAILING_DETAILS
SET DEFINE OFF;
INSERT INTO MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) VALUES( 'CCN_GEMS_SYNC_LOAD', '23', 'EMP_GEMS_SYNC_TB TABLE LOAD FAILED',	'ccnoracle.team@sherwin.com', 'Please check the load process. EMP_GEMS_SYNC_TB table was not loaded.','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
COMMIT;