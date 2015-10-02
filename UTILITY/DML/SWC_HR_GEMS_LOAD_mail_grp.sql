SET SCAN OFF;
REM INSERTING into MAILING_GROUP
SET DEFINE OFF;

Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('23','Nirajan.Karki@sherwin.com;Shahla.Husain@sherwin.com;Jaydeep.Cheruku@sherwin.com;Keith.D.Parker@sherwin.com;Abhitej.Kasula@sherwin.com;sinthujan.thamo@sherwin.com');
COMMIT;

SET SCAN OFF;
REM INSERTING into MAILING_DETAILS
SET DEFINE OFF;
Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('SWC_HR_GEMS_LOAD', '23', 'SWC_HR_GEMS_TB TABLE LOAD FAILED', 'Keith.D.Parker@sherwin.com', 'Please check the load process. SWC_HR_GEMS_TB table was not loaded.','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
COMMIT;