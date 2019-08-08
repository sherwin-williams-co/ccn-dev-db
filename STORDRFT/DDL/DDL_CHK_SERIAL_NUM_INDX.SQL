/**********************************************************************************
Below script will be used to create index on CCN_CHECK_SERIAL_NUMBER column of table 
SD_CHECK_NBR_PRNT_EXTRCT_DTLS.

Created : 08/06/2019 akj899 CNNSD-8 CCN Project Team....
**********************************************************************************/

CREATE INDEX CHK_SERIAL_NUM_INDX
ON SD_CHECK_NBR_PRNT_EXTRCT_DTLS(CCN_CHECK_SERIAL_NUMBER);


