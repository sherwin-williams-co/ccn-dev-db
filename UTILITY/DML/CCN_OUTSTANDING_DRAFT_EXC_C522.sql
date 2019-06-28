/********************************************************************************** 
This script is created to insert data into MAILING_GROUP and MAILING_DETAILS table.

Created : 06/25/2019 axm868 CCN Project CCNSD-2....
Modified: 
**********************************************************************************/
SET DEFINE OFF;

Insert into MAILING_GROUP(GROUP_ID,MAIL_ID) VALUES('136','ccnoracle.team@sherwin.com;joseph.p.zbiegien@sherwin.com');

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
values ('OUTSTANDING_DRAFT_EXC_C522',
        '136',
        'OUTSTANDING DRAFT EXCEL SHEET FOR DIVISION C522',
        'ccnoracle.team@sherwin.com',
        'Please find the OUTSTANDING DRAFT EXCEL SHEET FOR DIVISION C522.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

commit;