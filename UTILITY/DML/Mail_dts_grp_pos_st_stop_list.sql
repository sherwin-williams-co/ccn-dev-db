SET DEFINE OFF;
/*********************************************************** 
 Added a new Mailing details/groups for POS_ST_DT_EXT_LST
 created : 04/24/2018 nxk927 CCN project
 revisions: 
************************************************************/
Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('110','ccnoracle.team@sherwin.com');

Insert into MAILING_DETAILS values ('POS_ST_DT_EXT_LST','110','List for stores already having POS start date','ccnoracle.team@sherwin.com','Please find the attached excel sheet with the list of stores that had the Start date before we updated.','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');


COMMIT;