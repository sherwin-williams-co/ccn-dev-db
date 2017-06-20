/***************************************************************************** 
Below script is created to store mailing groups email id for 
Banking gift_card and ticket (for both data load and diff process).

Script Name: DML_mail_banking_dataload_and_diff_process.SQL

Created  : 05/23/2017 gxg192 CCN Project....
Modified :
*****************************************************************************/

SET DEFINE OFF;

INSERT INTO MAILING_GROUP (GROUP_ID,MAIL_ID)
     VALUES ('54','ccnoracle.team@sherwin.com;smis@sherwin.com');
        
INSERT INTO MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)
VALUES ('POS_GIFT_CARD_TRAN_FILE',
        '54',
        'POS Gift Card Transaction Delta File for',
        'ccnoracle.team@sherwin.com',
        'Please find attached the POS Gift Card Transaction Delta File.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

INSERT INTO MAILING_FILE_DETAILS (FILE_ID,GROUP_ID,FILE_NAME,DIRECTORY_NAME,IS_ACTIVE)
     VALUES (24,'54','GIFT_CARD_RECONCILE_DATA','BANKING_DATA_FILES','A');


INSERT INTO MAILING_GROUP (GROUP_ID,MAIL_ID)
     VALUES ('42','ccnoracle.team@sherwin.com;smis@sherwin.com');

INSERT INTO MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)
VALUES ('POS_BANK_DEP_TICK_CNT',
        '42',
        'POS Bank Deposit Ticket Count Delta File','ccnoracle.team@sherwin.com',
        'Please find the POS Bank Deposit Ticket Count Delta File.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

INSERT INTO MAILING_FILE_DETAILS (FILE_ID,GROUP_ID,FILE_NAME,DIRECTORY_NAME,IS_ACTIVE)
     VALUES (11,'42','POSXML_DEPOSIT_TICKET_DIFF','BANKING_DATA_FILES','A');

INSERT INTO MAILING_GROUP (GROUP_ID,MAIL_ID)
     VALUES ('52','ccnoracle.team@sherwin.com;smis@sherwin.com');
     
INSERT INTO MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)
VALUES ('POS_INTERIM_DEPST',
        '52','POS Interim Deposit Delta File',
        'ccnoracle.team@sherwin.com',
        'Please find the POS Interim Deposit Delta File',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

INSERT INTO MAILING_FILE_DETAILS (FILE_ID,GROUP_ID,FILE_NAME,DIRECTORY_NAME,IS_ACTIVE)
     VALUES (12,'52','POSXML_INTERIM_DEPST_DIFF','BANKING_DATA_FILES','A');

INSERT INTO MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
VALUES ('GIFT_CARD_PROCESS_ERROR',
        '48',
        'SRA3000 Gift Card Process failed',
        'ccnoracle.team@sherwin.com',
        'Processing of the SRA30000 Gift Card file failed.'
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
        
INSERT INTO MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)
VALUES ('GIFT_CARD_PROCESS_SUCCESS',
        '48',
        'SRA3000 Gift Card Process Completed',
        'ccnoracle.team@sherwin.com',
        'Processing of the SRA30000 Gift Card file completed successfully.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

INSERT INTO MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)
VALUES ('POS_BANK_DEP_TICK_ERROR',
        '48',
        'Banking Deposit Ticket Process failed',
        'ccnoracle.team@sherwin.com',
        'Processing of the Deposit Ticket file failed.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
        
INSERT INTO MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)
VALUES ('POS_BANK_DEP_TICK_SUCCESS',
        '48',
        'Banking Deposit Ticket Process Completed.',
        'ccnoracle.team@sherwin.com',
        'Processing of the Banking Deposit Ticket file completed successfully.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

COMMIT;