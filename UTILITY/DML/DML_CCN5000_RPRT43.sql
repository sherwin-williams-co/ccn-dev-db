/**********************************************************************************
Below script is created to insert data into MAILING_GROUP and MAILING_DETAILS table
for CCN05000 REPORT 43 to Mobuis Team.
Created : 08/09/2018 kxm302 CCN Project 
Modified:
**********************************************************************************/

REM INSERTING into MAILING_GROUP
SET DEFINE OFF;
Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('120','ccnoracle.team@sherwin.com');


REM INSERTING into MAILING_FILE_DETAILS
SET DEFINE OFF;
Insert into MAILING_FILE_DETAILS (FILE_ID,GROUP_ID,FILE_NAME,DIRECTORY_NAME,IS_ACTIVE) values (1,'120','CCN5000_RPRT43','CCN_DATAFILES','A');

REM INSERTING into MAILING_DETAILS
SET DEFINE OFF;
Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
values ('CCN5000_RPRT43',
        '120',
        'CCN05000 REPORT 43',
        'ccnoracle.team@sherwin.com',
        'Please find the attached CCN05000 RPT 43.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

COMMIT;
