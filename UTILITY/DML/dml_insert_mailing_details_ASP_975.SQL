/********************************************************************************** 
Below script is created to insert data into MAILING_DETAILS table to send an email if Bulk load process fails.

Created : 02/09/2018 sxg151 CCN Project ASP-975....
Modified: 
**********************************************************************************/
SET DEFINE OFF;
INSERT INTO MAILING_DETAILS VALUES('CC_UI_BULK_LOAD_PROCESS_FAIL',24,'Cost Center Bulk Load Process Fail','ccnoracle.team@sherwin.com','Please see the attached files for the cost centers Bulk Load process failed.','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
INSERT INTO MAILING_DETAILS VALUES('HRCHY_BULK_TRANSFER_FAIL',24,'Hierarchy Bulk Transfer Failures','ccnoracle.team@sherwin.com','Please see the attached files for details about the cost centers that failed during Hierarchy Bulk Transfer Process.','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
INSERT INTO MAILING_DETAILS VALUES('HRCHY_BULK_INSERT_FAIL',24,'Hierarchy Bulk Insert Failures','ccnoracle.team@sherwin.com','Please see the attached files for details about the cost centers that failed during Hierarchy Bulk Insert Process.','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
COMMIT;