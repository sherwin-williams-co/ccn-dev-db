  /********************************************************************************* 
This script is created to insert data into MAILING_GROUP and MAILING_DETAILS table for Banking concentration monthly report.

Created : 10/09/2018 pxa852 CCN Project ASP-1141....
Modified: 
**********************************************************************************/
-- INSERTING into MAILING_GROUP

Insert into MAILING_GROUP(GROUP_ID,MAIL_ID) VALUES('124','ccnoracle.team@sherwin.com,marcy.lee@sherwin.com');

-- INSERTING into MAILING_DETAILS

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
values ('BANKING_MEMBER_CONCENTRATION_RPT',
        '124',
        'Banking Concentration Monthly Report',
        'ccnoracle.team@sherwin.com',
        'Please find the attached banking concentration monthly report with this email.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

-- INSERTING into MAILING_FILE_DETAILS

Insert into MAILING_FILE_DETAILS values (1,'124','BANKING_MEMBER_CONCENTRATION_RPT','CCN_DATAFILES','A');
        

commit;