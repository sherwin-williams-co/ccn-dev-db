/********************************************************************
03/11/2016 nxk927 CCN Project Team. 
adding new mail group 28 for pci terminal id and terminal number count mis match
*********************************************************************/
SET SCAN OFF;
REM INSERTING into MAILING_GROUP
SET DEFINE OFF;

Insert into MAILING_GROUP values ('28','Keith.D.Parker@sherwin.com;Shahla.Husain@sherwin.com;Nirajan.Karki@sherwin.com;Jaydeep.Cheruku@sherwin.com;Abhitej.Kasula@sherwin.com;durga.sowjanya.vanaparti@sherwin.com;amarender.reddy.devidi@sherwin.com;mahesh.repala@sherwin.com');
COMMIT;

SET SCAN OFF;
REM INSERTING into MAILING_DETAILS
SET DEFINE OFF;
Insert into MAILING_DETAILS values ('PCI_POS_TERMINAL_MISMATCH', '28', 'PCI Terminal ID count and terminal number count do not match', 'Keith.D.Parker@sherwin.com', 'Please find the attached excel sheet for cost center CCCCCC which do not have same number of PCI Terminal ID and terminal number.','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
COMMIT;