/*******************************************************************************
Below indexes were created to improve the performance of the 1099 mid monthly/monthly runs

Created : 06/16/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
--DROP INDEX HST_STORE_DRAFTS_IX;
--DROP INDEX UNATTACHED_MNL_DRFT_DTL_HST_IX;

CREATE INDEX HST_STORE_DRAFTS_IX ON HST_STORE_DRAFTS(CHECK_SERIAL_NUMBER);
CREATE INDEX UNATTACHED_MNL_DRFT_DTL_HST_IX ON UNATTACHED_MNL_DRFT_DTL_HST(CHECK_SERIAL_NUMBER);
