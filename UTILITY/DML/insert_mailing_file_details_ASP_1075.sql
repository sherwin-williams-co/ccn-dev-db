/*******************************************************************************
Insert scripts to insert record for filename'CCN_ACCNT_REPORT/CCN_ADMIN_HRCHY_FORMAT' in 
Mailing file deatils table 

CREATED : 05/31/2018 sxg151 CCN PROJECT....ASP-1075
*******************************************************************************/

-- INSERTING into MAILING_GROUP
SET DEFINE OFF;
Insert into MAILING_GROUP(GROUP_ID,MAIL_ID) values ('113','ccnoracle.team@sherwin.com');

-- INSERTING into MAILING_DETAILS

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)
VALUES ('CCN_EPM_FILE_REPORT',
        '113',
        'CCN Accounting/EPM Reports',
        'ccnoracle.team@sherwin.com',
        'Please find attached the CCN Accounting/EPM Reports.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');


INSERT INTO MAILING_FILE_DETAILS (FILE_ID,GROUP_ID,FILE_NAME,DIRECTORY_NAME,IS_ACTIVE) 
values (1,'113','CCN_ACCNT_REPORT','CCN_DATAFILES','A');
INSERT INTO MAILING_FILE_DETAILS (FILE_ID,GROUP_ID,FILE_NAME,DIRECTORY_NAME,IS_ACTIVE) 
values (2,'113','ADMIN_HRCHY_FORMAT','CCN_DATAFILES','A');

COMMIT;

SELECT * FROM MAILING_FILE_DETAILS WHERE GROUP_ID = '113';

/********************************************************************
06/20/2018. Adding .Fabio.DiSanza@sherwin.com
*********************************************************************/
--Execute only in PROD

update mailing_group 
set mail_id = 'ccnoracle.team@sherwin.com;psg.finplan@sherwin.com;fabio.disanza@sherwin.com;'
where group_id = '86';

commit;

select * from mailing_group where group_id = '86';

