/********************************************************************************** 
Below script is created to insert data into MAILING_GROUP and MAILING_DETAILS table.

Created : 12/21/2017 sxg151 CCN Project 
Modified: 
**********************************************************************************/
-- INSERTING into MAILING_GROUP
SET DEFINE OFF;
Insert into MAILING_GROUP(GROUP_ID,MAIL_ID) values ('100','ccnoracle.team@sherwin.com');

-- INSERTING into MAILING_DETAILS

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)
Values ('HIERARCHY_DETAIL_SNAPSHOT_ERROR',
        '100',
        'Hierarchy Detail snapshot data load failed.',
        'ccnoracle.team@sherwin.com',
        'Hierarchy Detail snapshot data load failed.Please check the log files.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

commit;