/***************************************************************************** 
Below script is created to store mailing groups email id for 
Banking gift_card and ticket (for both data load and diff process).

Script Name: DML_mail_banking_dataload_and_diff_process.SQL

Created  : 05/23/2017 gxg192 CCN Project....
Modified : 06/23/2017 gxg192 Removed setup for success email.
         : 08/30/2017 rxa457 Added setup for SRA11000 summary file.
*****************************************************************************/

SET DEFINE OFF;

INSERT INTO MAILING_GROUP (GROUP_ID,MAIL_ID)
     VALUES ('42','ccnoracle.team@sherwin.com;smis@sherwin.com');
        
INSERT INTO MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)
VALUES ('BANKING_RECONCILE_FILES_GEN',
        '42',
        'Banking reconcile data generation.',
        'ccnoracle.team@sherwin.com',
        'Please find the banking reconcile data files.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

INSERT INTO MAILING_FILE_DETAILS (FILE_ID,GROUP_ID,FILE_NAME,DIRECTORY_NAME,IS_ACTIVE)
     VALUES (24,'42','GIFT_CARD_RECONCILE_DATA','BANKING_DATA_FILES','A');


INSERT INTO MAILING_FILE_DETAILS (FILE_ID,GROUP_ID,FILE_NAME,DIRECTORY_NAME,IS_ACTIVE)
     VALUES (11,'42','POSXML_DEPOSIT_TICKET_DIFF','BANKING_DATA_FILES','A');

INSERT INTO MAILING_FILE_DETAILS (FILE_ID,GROUP_ID,FILE_NAME,DIRECTORY_NAME,IS_ACTIVE)
     VALUES (12,'42','POSXML_INTERIM_DEPST_DIFF','BANKING_DATA_FILES','A');

INSERT INTO MAILING_FILE_DETAILS (FILE_ID,GROUP_ID,FILE_NAME,DIRECTORY_NAME,IS_ACTIVE)
     VALUES (25,'42','POS_SRA11000_DIFF','BANKING_DATA_FILES','A');

INSERT INTO MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
VALUES ('GIFT_CARD_PROCESS_ERROR',
        '48',
        'SRA3000 Gift Card Process failed',
        'ccnoracle.team@sherwin.com',
        'Processing of the SRA30000 Gift Card file failed.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
        
INSERT INTO MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)
VALUES ('POS_BANK_DATA_LOAD_ERROR',
        '48',
        'Banking POS Data Load Process failed',
        'ccnoracle.team@sherwin.com',
        'Processing of loading the data from POS failed.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

INSERT INTO MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)
VALUES ('BANKING_DIFF_PROCESS_ERROR',
        '48',
        'Banking Reconcile Diff Process failed',
        'ccnoracle.team@sherwin.com',
        'Processing of reconcile Diff process for Banking failed.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

COMMIT;