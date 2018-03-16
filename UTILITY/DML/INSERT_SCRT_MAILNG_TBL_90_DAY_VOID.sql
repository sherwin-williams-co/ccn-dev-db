/***************************************************************************** 
Below script is created to insert data into MAILING_GROUP,MAILING_DETAILS table.

These tables holds the information regarding mailing details of the file.

Created : 03/15/2018 bxa919 CCN Project....

*****************************************************************************/

Insert into mailing_GROUP (GROUP_ID,MAIL_ID)
values ('39','ccnoracle.team@sherwin.com');


Insert into mailing_details (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
values ('SD_90_DAY_VOID_PAY_RPT'
,'39'
,'Store Drafts 90 Day void Report'
,'ccnoracle.team@sherwin.com'
,'Please find the attached Store Drafts 90 Day void Report'
,'Thanks'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT'
);


Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) 
values ('50','ccnoracle.team@sherwin.com');


Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
values ('SD_90_DAY_VOID_PAY_RPT_FAILURE'
,'50'
,'SD 90 DAY VOID PAY REPORT GENERATION FAILURE'
,'ccnoracle.team@sherwin.com'
,'Error while generating the Store Draft report '
,'Thanks'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT'
);


COMMIT;
