/*Below script is created to insert data into MAILING_GROUP and MAILING_DETAILS table.

Created : 01/28/2019 sxg151 CCN Project ASP-1202....
Modified: 
**********************************************************************************/

SELECT * FROM MAILING_DETAILS where GROUP_ID = '130';

SELECT * FROM MAILING_GROUP where GROUP_ID = '130';

-- INSERTING into MAILING_GROUP
SET DEFINE OFF;
Insert into MAILING_GROUP(GROUP_ID,MAIL_ID) values ('130','ccnoracle.team@sherwin.com');

-- INSERTING into MAILING_DETAILS

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)
VALUES ('CCN_MONTHLY_SNAPSHOT_LOAD',
        '130',
        'CCN Monthly Snapshot Load Failed',
        'ccnoracle.team@sherwin.com',
        'Monthly Shnapshot Load failed Please check the log file.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

SELECT * FROM MAILING_DETAILS where GROUP_ID = '130';

SELECT * FROM MAILING_GROUP where GROUP_ID = '130';

commit;