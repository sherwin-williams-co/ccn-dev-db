

  ********************************************************************************** 
This script is created to insert data into MAILING_GROUP, MAILING_FILE_DETAILS and MAILING_DETAILS tables for generating standard address mismatch report.

Created : 07/18/2018 pxa852 CCN Project ASP-873....
Modified: 
**********************************************************************************/
-- INSERTING into MAILING_GROUP

SET DEFINE OFF;

Insert into MAILING_GROUP(GROUP_ID,MAIL_ID) VALUES('118','ccnoracle.team@sherwin.com');

-- INSERTING into MAILING_DETAILS

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
values ('CCN_STANDARDIZED_ADDRESS_MISMATCH',
        '118',
        'CCN and data services standardized address mismatch',
        'ccnoracle.team@sherwin.com',
        'Attached are the list of cost centers whose standardized address in CCN do not match data services.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

-- INSERTING into MAILING_FILE_DETAILS

INSERT INTO MAILING_FILE_DETAILS VALUES (1,118,'CCN_STANDARDIZED_ADDRESS_MISMATCH','CCN_LOAD_FILES','A');


commit;
