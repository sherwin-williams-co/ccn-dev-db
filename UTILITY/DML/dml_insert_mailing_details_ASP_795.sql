REM INSERTING into MAILING_GROUP
SET DEFINE OFF;
Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('64','jmkeating@sherwin.com;baeverden@sherwin.com;ccnoracle.team@sherwin.com');
Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('65','jmkeating@sherwin.com;baeverden@sherwin.com;ccnoracle.team@sherwin.com');
Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('66','jmkeating@sherwin.com;baeverden@sherwin.com;ccnoracle.team@sherwin.com');


REM INSERTING into MAILING_DETAILS
SET DEFINE OFF;
Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('STORE_BANK_CARD_MERCHANT','64','Store Bank Card Merchant ID File generation','ccnoracle.team@sherwin.com','Please find the Store 
Bank Card Merchant File details attached.','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('STORE_BANK_CARD_SERIAL','65','Store Bank Card Serial File generation','ccnoracle.team@sherwin.com','Please find the Store 
Bank Card Serial File details attached.','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('STORE_BANK_CARD_ERROR','66','Store Bank Card File generation failed','ccnoracle.team@sherwin.com','Store Bank Card File generation failed - Please refer attachment for Error log file','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

commit;