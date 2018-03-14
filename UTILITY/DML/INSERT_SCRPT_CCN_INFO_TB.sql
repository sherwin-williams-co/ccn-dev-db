/***************************************************************************** 
Below script is created to insert data into MAILING_GROUP,MAILING_DETAILS AND 
MAILING_FILE_DETAILS table.

These tables holds the information regarding mailing details of the file.

Created : 03/14/2018 bxa919 CCN Project....


*****************************************************************************/

SET DEFINE OFF;

Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) 
values ('72','ccnoracle.team@sherwin.com');


Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
values ('CCN_STORE_INFO_IN_TB','72','CCN Store Info report','ccnoracle.team@sherwin.com','Please find the attached Store Info Report','Thanks,
Keith D. Parker
IT Manager
Sherwin Williams - Stores IT');


Insert into MAILING_FILE_DETAILS (FILE_ID,GROUP_ID,FILE_NAME,DIRECTORY_NAME,IS_ACTIVE) 
values (1,'72','CCN_STORE_INFO_IN_TB','CCN_DATAFILES','A');

COMMIT;