/**********************************************************************************
Below script is created to insert data into MAILING_GROUP and MAILING_DETAILS table
for PRIME_SUB_DETAILS to Pats Team.
Created : 08/16/2018 kxm302 CCN Project 
Modified:
**********************************************************************************/

REM INSERTING into MAILING_GROUP
SET DEFINE OFF;
Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('122','ccnoracle.team@sherwin.com;smis@sherwin.com');

Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('123','ccnoracle.team@sherwin.com');


REM INSERTING into MAILING_FILE_DETAILS
SET DEFINE OFF;
Insert into MAILING_FILE_DETAILS (FILE_ID,GROUP_ID,FILE_NAME,DIRECTORY_NAME,IS_ACTIVE) values (1,'122','CCN_PRIMESUB_DETAILS','CCN_DATAFILES','A');


REM INSERTING into MAILING_DETAILS
SET DEFINE OFF;
Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)
values ('CCN_PRIMESUB_DETAILS',
        '122',
        'PrimeSub details report',
        'ccnoracle.team@sherwin.com;smis@sherwin.com',
        'Please find the attached Prime Sub details Report.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)
values ('PRIMESUB_DETAILS_FAIL',
        '123',
        'PrimeSub details Generation Report Failed',
        'ccnoracle.team@sherwin.com',
        'Please find the attached Prime Sub details Report.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

COMMIT;
