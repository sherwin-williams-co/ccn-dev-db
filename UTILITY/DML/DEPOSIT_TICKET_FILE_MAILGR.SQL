SET SCAN OFF;
REM INSERTING into MAILING_GROUP
SET DEFINE OFF;
delete from MAILING_DETAILS where GROUP_ID = '22';
delete from MAILING_GROUP where GROUP_ID = '22';
Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('22','ccnoracle.team@sherwin.com');
COMMIT;

SET SCAN OFF;
REM INSERTING into MAILING_DETAILS
SET DEFINE OFF;
Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('DEPOSIT_TICKET_FILE', '22', 'Deposit Ticket File Needs to be checked Asap for its missing corresponding file', 'ccnoracle.team@sherwin.com', 'Deposit ticket for Cost Center CCCCCC is missing its corresponding txt/xml file. The file is archieved in recovery folder and needs to be checked for the issue.','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
COMMIT;