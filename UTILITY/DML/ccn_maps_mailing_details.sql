SET DEFINE OFF;
/*********************************************************** 
 Added a new Mailing details for CCN_MAPS_FEED for sending Maps Feed to esri software
 created : 01/18/2018 mxv711 CCN project
 revisions: 
************************************************************/
Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('102','catalina.v.salamon@sherwin.com;ccnoracle.team@sherwin.com');

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
values ('CCN_MAPS_FEED','102','MAPS FEED FILES','ccnoracle.team@sherwin.com','Please find the attached MAPS FEED Files.','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

Insert into MAILING_FILE_DETAILS (FILE_ID,GROUP_ID,FILE_NAME,DIRECTORY_NAME,IS_ACTIVE) values (1,'102','USA_CCN_MAPS_FEED','CCN_DATAFILES','A');
Insert into MAILING_FILE_DETAILS (FILE_ID,GROUP_ID,FILE_NAME,DIRECTORY_NAME,IS_ACTIVE) values (2,'102','CAN_CCN_MAPS_FEED','CCN_DATAFILES','A');
Insert into MAILING_FILE_DETAILS (FILE_ID,GROUP_ID,FILE_NAME,DIRECTORY_NAME,IS_ACTIVE) values (3,'102','OTH_CCN_MAPS_FEED','CCN_DATAFILES','A');

COMMIT;