SET SCAN OFF;
REM INSERTING into MAILING_GROUP
SET DEFINE OFF;

Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('21','Nirajan.Karki@sherwin.com;Shahla.Husain@sherwin.com;Jaydeep.Cheruku@sherwin.com;Keith.D.Parker@sherwin.com;Abhitej.Kasula@sherwin.com;sinthujan.thamo@sherwin.com;CCN.PSG.Store.Drafts@sherwin.com');
COMMIT;

SET SCAN OFF;
REM INSERTING into MAILING_DETAILS
SET DEFINE OFF;
Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('SD_1099_NO_VNDR_ON_BNK_TP_RPRT', '21', 'Store Draft 1099 report - NO VENDOR ON BANK TP REPORT', 'Keith.D.Parker@sherwin.com', 'Please find the attached SD 1099  Report for NO VENDOR ON BANK TP','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('SD_1099_MTCHD_PRCSNG_RPRT','21','Store Draft 1099 report - MATCHED PROCESSING RPRT','Keith.D.Parker@sherwin.com','Please find the attached SD 1099 Report for MATCHED PROCESSING REPORT','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('SD_1099_NO_MTCHD_VENDOR_RPRT','21','Store Draft 1099 report  for No Matched Vendor Report','Keith.D.Parker@sherwin.com','Please find the attached SD 1099 Report for No matched vendor ','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('SD_1099_TXPYR_ID_AP_TRNS_CRT','21','Store Draft 1099 report - TAXPAYER ID AP TRNS CRT','Keith.D.Parker@sherwin.com','Please find the attached SD 1099 Report for TAX PAYER ID FOR AP TRNS CRT  Report','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
COMMIT;