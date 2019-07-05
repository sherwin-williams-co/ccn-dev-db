/***************************************************************************************
This script insert record into MAILING_GROUP and MAILING_DETAILS for sending mail for CCN Store 
dispatch services update failure records.

Created : 06/14/2019 akj899 CCNCC-13 CCN Project...
***************************************************************************************/

INSERT INTO MAILING_GROUP VALUES(137, 'ccnoracle.team@sherwin.com');
INSERT INTO MAILING_DETAILS VALUES('STORE_DSPTCH_SRVS_UI_BULK_LD_UPD_PROC_FAIL',137,'CCN Store dispatch services type code update failure records','ccnoracle.team@sherwin.com', 'Attached the list of stores for which the dispatch services type code is not updated.',
                                   'Thanks,'||CHR(10)||'Keith D. Parker'|| CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

COMMIT;
