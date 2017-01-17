/***************************************************************************** 
Below script is created to store mailing groups email id for 
Deposit Ticket FTP Failure reporting

created : 01/16/2017 gxg192 CCN Project....
*****************************************************************************/

SET DEFINE OFF;

INSERT INTO MAILING_GROUP (GROUP_ID, MAIL_ID)
   VALUES ('50', 'ccnoracle.team@sherwin.com');
   
/***************************************************************************** 
Below script is created to store mailing details for Deposit Ticket FTP Failure reporting
*****************************************************************************/

INSERT INTO MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
VALUES ('DEPOSIT_TCKT_FTP_FAILED',
        '50',
        'Deposit Ticket File Needs to be checked for error occurred in FTP process',
        'ccnoracle.team@sherwin.com',
        'FTP for Deposit ticket for Cost Center CCCCCC failed. The file is archieved into folder named recovered_file on app server.'||CHR(10)||
        'This file needs to be checked for the issue.'||CHR(10)||
        'Please check the corresponding log in app server for more details located at ZZZ.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
