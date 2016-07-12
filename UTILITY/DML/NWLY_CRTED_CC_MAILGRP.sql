/********************************************************************
04/04/2016 nxk927 CCN Project Team. 
adding new mail group 30 for newly created cost centers info
*********************************************************************/
SET SCAN OFF;
REM INSERTING into MAILING_GROUP
SET DEFINE OFF;

Insert into MAILING_GROUP values ('30','ccnoracle.team@sherwin.com');
COMMIT;

SET SCAN OFF;
REM INSERTING into MAILING_DETAILS
SET DEFINE OFF;
Insert into MAILING_DETAILS values ('NEWLY_CRTD_COST_CENTER', '30', 'List of Newly Created Cost Centers', 'ccnoracle.team@sherwin.com', 'Please find the attached excel sheet for list of newly created cost centers.','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
COMMIT;