  /********************************************************************************* 
This script is created to insert data into MAILING_GROUP and MAILING_DETAILS table for Banking concentration monthly report.

Created : 10/09/2018 pxa852 CCN Project ASP-1141....
Modified: 
**********************************************************************************/
-- INSERTING into MAILING_GROUP

Insert into MAILING_GROUP(GROUP_ID,MAIL_ID) VALUES('124','ccnoracle.team@sherwin.com;marcy.lee@sherwin.com');

-- INSERTING into MAILING_DETAILS

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
values ('BANKING_MEMBER_CONCENTRATION_RPT',
        '124',
        'Monthly Banking Concentration Report',
        'ccnoracle.team@sherwin.com',
        'Attached are the requested member concentration details as of DD-MON-YYYY.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

-- INSERTING into MAILING_FILE_DETAILS

commit;