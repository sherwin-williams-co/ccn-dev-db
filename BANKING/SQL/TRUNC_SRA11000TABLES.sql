/*
Created  : dxv848 03/08/2016 truncate the tables before initload process
Modified : nxk927 04/26/2016 added Truncate for UAR TABLES
*/


EXECUTE IMMEDIATE 'TRUNCATE TABLE  ACH_DRFTS_EXTRCT_CNTRL_FL';

EXECUTE IMMEDIATE 'TRUNCATE TABLE  SUMMARY_EXTRCT_CNTRL_FL';

EXECUTE IMMEDIATE 'TRUNCATE TABLE  JV_EXTRCT_CNTRL_FL';

EXECUTE IMMEDIATE 'TRUNCATE TABLE  UAR_ACH_DRFTS_EXTRCT_CNTRL_FL';

EXECUTE IMMEDIATE 'TRUNCATE TABLE  UAR_SUMMARY_EXTRCT_CNTRL_FL';

EXECUTE IMMEDIATE 'TRUNCATE TABLE  UAR_JV_EXTRCT_CNTRL_FL';

