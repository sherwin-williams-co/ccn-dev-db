/*****************************************************************************
Below script is to store mailing details for SRA11000_no_concentration

created : 08/15/2017 nxk927 CCN Project....
changed :
*****************************************************************************/
INSERT INTO MAILING_GROUP VALUES (72, 'ccnoracle.team@sherwin.com;marcy.lee@sherwin.com;smis@sherwin.com');
INSERT INTO MAILING_DETAILS VALUES ('SRA11000_MISSING_CC', 72, 'SRA11000 - Cost Center not present in the New Banking concentration', 'ccnoracle.team@sherwin.com', 'Please find the attached list of the cost center that are not present in the New Banking concentration.', 'Thanks,' || CHR(10) ||'Keith D. Parker' || CHR(10) || 'IT Manager' || CHR(10) || 'Sherwin Williams - Stores IT');

COMMIT;
