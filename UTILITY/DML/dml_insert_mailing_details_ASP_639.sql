/********************************************************************************** 
This script is created to insert data into MAILING_GROUP and MAILING_DETAILS table.

Created : 06/05/2017 sxg151 CCN Project ASP-639....
Modified: 
**********************************************************************************/
SET DEFINE OFF;

Insert into MAILING_GROUP(GROUP_ID,MAIL_ID) VALUES('40','ccnoracle.team@sherwin.com');

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
values ('STORE_BANK_DPST_RECON_DT_ERROR',
        '40',
        'Store Bank Deposit Reconciliation Data Process Failed',
        'ccnoracle.team@sherwin.com',
        'Store bank deposit reconciliation data file generation process failed. Please check the log files.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
        
Insert into MAILING_GROUP(GROUP_ID,MAIL_ID) VALUES('41','ccnoracle.team@sherwin.com');

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
values ('STORE_BANK_DPST_RECON_DT',
        '41',
        'Store Bank Deposit Reconciliation Data',
        'ccnoracle.team@sherwin.com',
        'Please find the attached excel sheet for list of store bank deposit reconciliation data for the last two weeks.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

commit;