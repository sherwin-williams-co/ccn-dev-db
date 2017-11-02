/********************************************************************************** 
Below script is created to insert data into MAILING_GROUP and MAILING_DETAILS table.

Created : 11/02/2017 sxg151 CCN Project ASP-892....
Modified: 
**********************************************************************************/
-- INSERTING into MAILING_GROUP
SET DEFINE OFF;
Insert into MAILING_GROUP(GROUP_ID,MAIL_ID) values ('99','ccnoracle.team@sherwin.com');

-- INSERTING into MAILING_DETAILS

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)
Values ('LOAD_MEMER_BANK_CONCENT_CC_ERROR',
        '99',
        'New banking concentration data load failed.',
        'ccnoracle.team@sherwin.com',
        'New Banking Concentration data failed.Please check the log files.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

commit;