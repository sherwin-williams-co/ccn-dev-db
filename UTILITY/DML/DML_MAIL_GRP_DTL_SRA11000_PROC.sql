/*****************************************************************************
Below script is to store mailing details for installer retainage refund report

created : 07/21/2017 nxk927 CCN Project....
changed :
*****************************************************************************/
INSERT INTO MAILING_GROUP VALUES (91, 'ccnoracle.team@sherwin.com');
INSERT INTO MAILING_DETAILS VALUES ('SRA11000_PROCESS_FAIL', 91, 'SRA11000 Process Failed to Run', 'ccnoracle.team@sherwin.com', 'SRA11000 Process did not find the data to run the process. Please check the data source.', 'Thanks,' || CHR(10) ||'Keith D. Parker' || CHR(10) || 'IT Manager' || CHR(10) || 'Sherwin Williams - Stores IT');

COMMIT;
