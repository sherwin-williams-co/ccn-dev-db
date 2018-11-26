
  /********************************************************************************** 
This script is created to insert data into MAILING_GROUP and MAILING_DETAILS table for banking concentration report error.

Created : 11/26/2018 pxa852 CCN Project ASP-1141....
Modified: 
**********************************************************************************/
-- INSERTING into MAILING_GROUP

SET DEFINE OFF;

Insert into MAILING_GROUP(GROUP_ID,MAIL_ID) VALUES('125','ccnoracle.team@sherwin.com');

-- INSERTING into MAILING_DETAILS

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
values ('BANKING_CONCENTRATION_ERROR',
        '125',
        'Monthly Banking concentration report job failed',
        'ccnoracle.team@sherwin.com',
        'Monthly Banking concentration report job failed - Please refer the log file.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
        

commit;
