/**********************************************************************************
Below script is created to insert data into MAILING_GROUP and MAILING_DETAILS table
for ADMINORG_HIERARCHY_MNTHLY_PRCSS.
Created : 07/17/2018 kxm302 CCN Project 
Modified:
**********************************************************************************/
REM INSERTING into MAILING_GROUP
SET DEFINE OFF;
Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('116','ccnoracle.team@sherwin.com');


REM INSERTING into MAILING_FILE_DETAILS
SET DEFINE OFF;
Insert into MAILING_FILE_DETAILS (FILE_ID,GROUP_ID,FILE_NAME,DIRECTORY_NAME,IS_ACTIVE) values (1,'116','AdminOrgHierarchyAttrbt','CCN_DATAFILES','A');

REM INSERTING into MAILING_DETAILS
SET DEFINE OFF;
Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('ADMINORG_HIERARCHY_MNTHLY_PRCSS','116','Report for AdminOrg hierarchy','ccnoracle.team@sherwin.com','Please find the attached AdminOrg hierarchy details with this email','Thanks,
Keith D. Parker
IT Manager
Sherwin Williams - Stores IT');

COMMIT;


