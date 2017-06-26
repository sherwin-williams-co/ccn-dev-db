/********************************************************************************** 
Below script is created to insert data into MAILING_GROUP and MAILING_DETAILS table for SRA11000 report.

Created : 06/26/2017 nxk927 CCN Project....
Modified: 
**********************************************************************************/
REM INSERTING into MAILING_GROUP
SET DEFINE OFF;
Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('90','ccnoracle.team@sherwin.com');


REM INSERTING into MAILING_DETAILS
SET DEFINE OFF;
Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
values ('ACH_DRAFT_BNK_ACT_MISMTH_RPT',
        '90',
        'ACH_DRAFT Source Bank Account Number mismatch with the database',
        'ccnoracle.team@sherwin.com',
        'Please find the attached list of bank account number for the cost center that do not match the our database bank account number.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
values ('MISCTRAN_BNK_ACT_MISMTH_RPT',
        '90',
        'MISCTRAN Source Bank Account Number mismatch with the database',
        'ccnoracle.team@sherwin.com',
        'Please find the attached list of bank account number for the cost center that do not match the our database bank account number.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
values ('OVERSHRT_BNK_ACT_MISMTH_RPT',
        '90',
        'OVERSHRT Source Bank Account Number mismatch with the database',
        'ccnoracle.team@sherwin.com',
        'Please find the attached list of bank account number for the cost center that do not match the our database bank account number.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
values ('SUMMARY_BNK_ACT_MISMTH_RPT',
        '90',
        'SUMMARY Source Bank Account Number mismatch with the database',
        'ccnoracle.team@sherwin.com',
        'Please find the attached list of bank account number for the cost center that do not match the our database bank account number.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
		
		
commit;
