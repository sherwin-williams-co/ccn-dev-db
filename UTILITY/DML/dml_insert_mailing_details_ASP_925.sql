/********************************************************************************** 
Below script is created to insert data into MAILING_GROUP and MAILING_DETAILS table.

Created : 04/24/2018 sxg151 CCN Project ASP-925....
Modified: 
**********************************************************************************/
-- INSERTING into MAILING_GROUP

Insert into MAILING_GROUP(GROUP_ID,MAIL_ID) values ('112','ccnoracle.team@sherwin.com');

-- INSERTING into MAILING_DETAILS

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)
VALUES ('LOAD_CCN_DSC_CODE_DETAILS',
        '112',
        'CCN_DSC_CODE_DESC table load failed',
        'ccnoracle.team@sherwin.com',
        'Loading data into CCN_DSC_CODE_DESC failed - Please refer the log file...',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

commit;