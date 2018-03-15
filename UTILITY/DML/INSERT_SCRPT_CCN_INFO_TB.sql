/***************************************************************************** 
Below script is created to insert data into MAILING_GROUP,MAILING_DETAILS AND 
MAILING_FILE_DETAILS table.

These tables holds the information regarding mailing details of the file.

Created : 03/14/2018 bxa919 CCN Project....


*****************************************************************************/

SET DEFINE OFF;

Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) 
values ('75','ccnoracle.team@sherwin.com');

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
values ('CCN_STORE_INFO_IN_TB'
,'75'
,'CCN Store Info report'
,'ccnoracle.team@sherwin.com'
,'Please find the attached Store Info Report'
,'Thanks'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT'
);


Insert into MAILING_FILE_DETAILS (FILE_ID,GROUP_ID,FILE_NAME,DIRECTORY_NAME,IS_ACTIVE) 
values (1,'75','STORE_INFO_IN_TB_CCN08900_D','CCN_DATAFILES','A');



Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) 
values ('76','ccnoracle.team@sherwin.com');


Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
values ('CCN_STORE_INFO_REPORT_FAILURE'
,'76'
,'CCN STORE INFO REPORT GENERATION FAILURE'
,'ccnoracle.team@sherwin.com'
,'Error while generating the Store Draft report '
,'Thanks'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT'
);


COMMIT;