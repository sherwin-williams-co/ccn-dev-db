/*****************************************************************************
Below script is to store mailing details for 90 day report

created : 05/11/2016 jxc517 CCN Project....
changed :
*****************************************************************************/
INSERT INTO MAILING_GROUP VALUES (32, 'Keith.D.Parker@sherwin.com;Shahla.Husain@sherwin.com;Nirajan.Karki@sherwin.com;Jaydeep.Cheruku@sherwin.com;Abhitej.Kasula@sherwin.com;amarender.reddy.devidi@sherwin.com;mahesh.repala@sherwin.com');
INSERT INTO MAILING_DETAILS VALUES ('SD_90_DAY_STOP_PAY_RPT', 32, 'Store Drafts 90 Day Stop Pay Report', 'Keith.D.Parker@sherwin.com', 'Please find attached the Store Drafts 90 Day Stop Pay Report', 'Thanks,' || CHR(10) ||'Keith D. Parker' || CHR(10) || 'IT Manager' || CHR(10) || 'Sherwin Williams - Stores IT');

COMMIT;
