SET DEFINE OFF;
/*********************************************************** 
 Added a new Mailing details/groups for POS_START_DATE_EXT_LST
 created : 04/24/2018 nxk927 CCN project
 revisions: 
************************************************************/
Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('110','ccnoracle.team@sherwin.com');

Insert into MAILING_DETAILS values ('POS_START_DATE_EXT_LST','110','List of stores with POS start date','ccnoracle.team@sherwin.com','Please find the attached excel sheet with the lists of stores that have the Pos Start date and can not be updated.','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');


COMMIT;