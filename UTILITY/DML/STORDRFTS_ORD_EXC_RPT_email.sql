/*
Below script will set-up the mailing details for store drafts automated batch orders

Created : 10/08/2019 jxc517 CCN Project Team....
Changed :
*/
Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('143','ccndevelopment.team@sherwin.com');
Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('STORDRFTS_ORD_EXC_RPT','143','Store Drafts Ordered Report','ccndevelopment.team@sherwin.com','Please find attached the Store Drafts Ordered Report','Thanks,'||CHR(13)||'CCN Application Support Group | ccnsupport.team@sherwin.com | 2164690192 | Sherwin Williams - Stores IT');
COMMIT;
