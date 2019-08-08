/**********************************************************************************
Below script will be used to create index on COST_CENTER_CODE and ORDERED_DRFT_NUMBER
column of table SD_CHECK_NBR_PRNT_EXTRCT_DTLS.

Created : 08/06/2019 akj899 CNNSD-8 CCN Project Team....
**********************************************************************************/

CREATE INDEX CC_DRFT_NUM_INDX
ON SD_CHECK_NBR_PRNT_EXTRCT_DTLS(COST_CENTER_CODE,ORDERED_DRFT_NUMBER);