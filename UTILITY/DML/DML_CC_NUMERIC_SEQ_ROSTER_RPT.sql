/**********************************************************************************
Below script is created to insert data into MAILING_GROUP and MAILING_DETAILS table
for CC_NUMERIC_SEQ_ROSTER_RPT to Mobius Team.
Created : 08/10/2018 kxm302 CCN Project 
Modified: 08/20/2018 kxm302 CCN Project
        : changed the subject line for the report.
**********************************************************************************/

REM INSERTING into MAILING_GROUP
SET DEFINE OFF;
Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('120','ccnoracle.team@sherwin.com');


REM INSERTING into MAILING_FILE_DETAILS
SET DEFINE OFF;
Insert into MAILING_FILE_DETAILS (FILE_ID,GROUP_ID,FILE_NAME,DIRECTORY_NAME,IS_ACTIVE) values (1,'120','CC_NUMERIC_SEQ_ROSTER_RPT','CCN_DATAFILES','A');

REM INSERTING into MAILING_DETAILS
SET DEFINE OFF;
Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
values ('CC_NUMERIC_SEQ_ROSTER_RPT',
        '120',
        'Cost Center Numeric Sequence Roster Report',
        'ccnoracle.team@sherwin.com',
        'Please find the attached Cost Center Numeric Sequence Roster Report.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

COMMIT;
