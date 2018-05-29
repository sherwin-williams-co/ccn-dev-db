/********************************************************************************** 
Below script is created to insert data into MAILING_GROUP and MAILING_DETAILS table.

Created : 03/15/2018 sxg151 CCN Project ASP-937....
Modified: 
**********************************************************************************/
-- INSERTING into MAILING_GROUP
SET DEFINE OFF;
Insert into MAILING_GROUP(GROUP_ID,MAIL_ID) values ('108','ccnoracle.team@sherwin.com');

-- INSERTING into MAILING_DETAILS

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)
VALUES ('GENERATE_EPM_FEED_FILE_FAIL',
        '108',
        'Generate EPM Feed File Failed.',
        'ccnoracle.team@sherwin.com',
        'Generating the EPM Feed File failed Please check the log file.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

-- Insert Mailing details for FTP

Insert into MAILING_GROUP(GROUP_ID,MAIL_ID) values ('111','ccnoracle.team@sherwin.com');

-- INSERTING into MAILING_DETAILS

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)
VALUES ('FTP_EPM_FEED_FILE_ERROR',
        '111',
        'FTP EPM Feed File Failed.',
        'ccnoracle.team@sherwin.com',
        'EPM Feed File FTP failed Please check the log file.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');


commit;