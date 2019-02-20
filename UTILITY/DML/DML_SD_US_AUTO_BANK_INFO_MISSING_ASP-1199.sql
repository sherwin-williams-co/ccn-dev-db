/**********************************************************************************
Below script is created to insert data into MAILING_GROUP and MAILING_DETAILS table
for SD_US_AUTO_BANK_INFO_MISSING.
Created : 01/29/2019 kxm302 CCN Project 
Modified:
**********************************************************************************/
REM INSERTING into MAILING_GROUP
SET DEFINE OFF;
Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('128','pmmalloy@sherwin.com;jeklodnick@sherwin.com;ccnoracle.team@sherwin.com');

REM INSERTING into MAILING_DETAILS
SET DEFINE OFF;
Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
values ('SD_US_AUTO_BANK_INFO_MISSING',
        '128',
        'Store Drafts US Auto Bank missing Payee Information Report',
        'ccnoracle.team@sherwin.com',
        'Below excel contains the details about Store Drafts US Auto Bank Info missing Report.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

COMMIT;