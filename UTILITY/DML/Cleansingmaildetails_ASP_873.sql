

  ********************************************************************************** 
This script is created to insert data into MAILING_GROUP and MAILING_DETAILS table for Cleansing address batch process.

Created : 07/11/2018 pxa852 CCN Project ASP-873....
Modified: 
**********************************************************************************/
-- INSERTING into MAILING_GROUP

SET DEFINE OFF;

Insert into MAILING_GROUP(GROUP_ID,MAIL_ID) VALUES('115','ccnoracle.team@sherwin.com');

-- INSERTING into MAILING_DETAILS

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
values ('CCN_CLEANSING_ERROR',
        '115',
        'Cleansing/Standardization address job failed',
        'ccnoracle.team@sherwin.com',
        'Cleansing/Standardization job failed - Please refer the log file.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
        

commit;
