

/********************************************************************************** 
This script is created to insert records into MAILING_GROUP and MAILING_DETAILS tables for generating stores cash flow adjustment file failure records.

Created : 12/17/2018 pxa852 CCN Project ASP-1176....
Modified: 
**********************************************************************************/

SET DEFINE OFF;

Insert into MAILING_GROUP(GROUP_ID,MAIL_ID) VALUES('127','ccnoracle.team@sherwin.com');

-- INSERTING into MAILING_DETAILS

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
values ('GENERATE_CORRECTS_FILE_PROC_FAIL',
        '127',
        'Stores Cash Flow Adjustment failure records',
        'ccnoracle.team@sherwin.com',
        'Attached are the list of cost centers excluded from stores cash flow adjustmet file.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');


commit;
