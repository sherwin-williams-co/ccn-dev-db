

  ********************************************************************************** 
This script is created to insert data into MAILING_GROUP and MAILING_DETAILS table for Hierarchy File generation process

Created : 07/11/2018 pxa852 CCN Project ASP-1068....
Modified: 
**********************************************************************************/
-- INSERTING into MAILING_GROUP

SET DEFINE OFF;

Insert into MAILING_GROUP(GROUP_ID,MAIL_ID) VALUES('113','ccnoracle.team@sherwin.com');

-- INSERTING into MAILING_DETAILS

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
values ('CCN_HIERARCHY_FILE_MAIL',
        '113',
        'Report for all Hierarchy types of a Cost Center',
        'ccnoracle.team@sherwin.com',
        'Please find the attached Hierarchy reporting details with this email.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

-- INSERTING into MAILING_FILE_DETAILS

Insert into MAILING_FILE_DETAILS values (1,'113','CCN_HIERARCHY_FILE_MAIL','CCN_DATAFILES','A');
        

commit;
