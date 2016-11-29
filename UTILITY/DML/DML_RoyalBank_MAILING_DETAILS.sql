/***************************************************************************** 
Below script is created to store mailing details for Royal Bank report 
created : 11/18/2016 gxg192 CCN Project.... 
changed : 
*****************************************************************************/
SET DEFINE OFF;

INSERT INTO MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
    VALUES ('ROYAL_BANK_REPORT_ERROR',
            '47','Royal Bank Report failed',
            'ccnoracle.team@sherwin.com',
            'Processing Failed for Royal Bank Report',
            'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');