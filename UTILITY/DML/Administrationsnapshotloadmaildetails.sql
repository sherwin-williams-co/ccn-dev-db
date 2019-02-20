/********************************************************************************** 
This script is created to insert data into MAILING_GROUP and MAILING_DETAILS table for Administration snapshot load process.

Created : 02/20/2019 pxa852 CCN Project Team....
Modified: 
**********************************************************************************/
-- INSERTING into MAILING_GROUP

SET DEFINE OFF;

Insert into MAILING_GROUP(GROUP_ID,MAIL_ID) VALUES('134','ccnoracle.team@sherwin.com');

-- INSERTING into MAILING_DETAILS

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
values ('ADMIN_MONTHLY_SNAPSHOT_LOAD',
        '134',
        'Administration Monthly Snapshot load job failed',
        'ccnoracle.team@sherwin.com',
        'Administration Monthly Snapshot load job failed - Please refer the log file.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
        

commit;