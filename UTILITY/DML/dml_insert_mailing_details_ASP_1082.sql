/********************************************************************************** 
Below script is created to insert data into MAILING_DETAILS table to send an email if Bank Card load Files.

Created : 06/22/2018 sxg151 CCN Project ASP-1082....
Modified: 
**********************************************************************************/

--INSERT into MAILING_GROUP
Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('64','ccnoracle.team@sherwin.com');
Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('65','ccnoracle.team@sherwin.com');

-- INSERTING into MAILING_DETAILS

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
values ('STORE_BANK_CARD_SERIAL',
        '64',
        'Store Bank Card File',
        'ccnoracle.team@sherwin.com',
        'Please find the Store Bank Card data file attached.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
values ('STORE_BANK_CARD_MERCHANT',
        '65',
        'Store Bank Card Merchant File',
        'ccnoracle.team@sherwin.com',
        'Please find the Store Bank Card Merchant data file attached.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
COMMIT; 

-- in Production only :

Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('64','smis@sherwin.com;ccnoracle.team@sherwin.com');
Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('65','smis@sherwin.com;ccnoracle.team@sherwin.com');

-- INSERTING into MAILING_DETAILS

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
values ('STORE_BANK_CARD_SERIAL',
        '64',
        'Store Bank Card File',
        'ccnoracle.team@sherwin.com',
        'Please find the Store Bank Card data file attached.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
values ('STORE_BANK_CARD_MERCHANT',
        '65',
        'Store Bank Card Merchant File',
        'ccnoracle.team@sherwin.com',
        'Please find the Store Bank Card Merchant data file attached.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
COMMIT; 

SELECT * FROM MAILING_DETAILS WHERE GROUP_ID IN (64,65); 
SELECT * FROM MAILING_GROUP WHERE GROUP_ID  IN (64,65);