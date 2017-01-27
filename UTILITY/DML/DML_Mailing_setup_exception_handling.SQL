/***************************************************************************** 
Below script is created to store mailing setup below:
    1. Deposit Bag FTP Failure reporting
    2. Current to History batch
    3. Future to current batch
    4. Hierarchy batch process
    5. Future to current hierarchy batch

created : 01/25/2017 gxg192 CCN Project....
*****************************************************************************/

SET DEFINE OFF;

/* ---------------------------------------
    1. Deposit Bag FTP Failure reporting
   --------------------------------------- */
INSERT INTO MAILING_GROUP (GROUP_ID, MAIL_ID)
   VALUES ('57', 'ccnoracle.team@sherwin.com');
   

INSERT INTO MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
VALUES ('DEPOSIT_BAG_FTP_FAILED',
        '57',
        'Deposit Bag File Needs to be checked for error occurred in FTP process',
        'ccnoracle.team@sherwin.com',
        'FTP for Deposit bag for Cost Center CCCCCC failed. The file is moved into folder named ftp_failed_files on app server.'||CHR(10)||
        'This file needs to be checked for the issue.'||CHR(10)||
        'Please check the corresponding log in app server for more details located at ZZZ.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

/* ------------------------------
    2. Current to History batch
   ------------------------------ */
INSERT INTO MAILING_GROUP (GROUP_ID, MAIL_ID)
   VALUES ('58', 'ccnoracle.team@sherwin.com');
   

INSERT INTO MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
VALUES ('CURRENT_TO_HISTORY_BATCH_ERROR',
        '58',
        'Current To History Batch Error',
        'ccnoracle.team@sherwin.com',
        'Current to History batch processing failed. Please check the log files.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

/* ------------------------------
    3. Future to current batch
   ------------------------------ */
INSERT INTO MAILING_GROUP (GROUP_ID, MAIL_ID)
   VALUES ('59', 'ccnoracle.team@sherwin.com');
   

INSERT INTO MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
VALUES ('FUTURE_TO_CURRENT_BATCH_ERROR',
        '59',
        'Future To Current Batch Error',
        'ccnoracle.team@sherwin.com',
        'Future to Current batch processing failed. Please check the log files.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

/* ------------------------------
    4. Hierarchy batch process
   ------------------------------ */
INSERT INTO MAILING_GROUP (GROUP_ID, MAIL_ID)
   VALUES ('60', 'ccnoracle.team@sherwin.com');
   

INSERT INTO MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
VALUES ('HIERARCHY_BATCH_ERROR',
        '60',
        'Hierarchy Batch Process Error',
        'ccnoracle.team@sherwin.com',
        'Hierarchy Batch processing failed. Please check the log files.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

/* ------------------------------
    5. Future to current hierarchy batch
   ------------------------------ */
INSERT INTO MAILING_GROUP (GROUP_ID, MAIL_ID)
   VALUES ('61', 'ccnoracle.team@sherwin.com');
   

INSERT INTO MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
VALUES ('HIERARCHY_FUT_TO_CURR_ERROR',
        '61',
        'Hierarchy Future To Current Batch Error',
        'ccnoracle.team@sherwin.com',
        'Hierarchy Future to Current batch processing failed. Please check the log files.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');