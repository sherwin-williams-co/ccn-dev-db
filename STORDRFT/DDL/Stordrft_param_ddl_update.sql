/*
  STOREDRFT_PARAM Table
  modified: axk326 CCN Project Team....
            Added new date columns as per their category 
*/

DROP TABLE STOREDRFT_PARAM;
COMMIT;


CREATE TABLE STOREDRFT_PARAM
   (
    DAILY_LOAD_RUNDATE DATE, 
	PL_GAIN_RUNDATE DATE, 
	GAINLOSS_MNTLY_RUNDATE DATE, 
	SD_REPORT_QRY_RUNDATE DATE, 
	JV_MNTLY_RUNDATE DATE, 
	QTLY_1099_RUNDATE DATE, 
	MNTLY_1099_RUNDATE DATE, 
	MID_MNTLY_1099_RUNDATE DATE, 
	DAILY_PREV_RUNDATE DATE
   );
COMMIT;

/*COMMENTS FOR STOREDRFT_PARAM*/
COMMENT ON TABLE STOREDRFT_PARAM IS 'This table holds all the dates required along with the dates for Storedrft_jv and Gainloss_jv, always 1st day of every month. Ex:01-Jan-2015';
COMMENT ON COLUMN STOREDRFT_PARAM.DAILY_LOAD_RUNDATE IS 'it holds date for daily load run';
COMMENT ON COLUMN STOREDRFT_PARAM.PL_GAIN_RUNDATE IS 'it holds date for PL gain loss report run';
COMMENT ON COLUMN STOREDRFT_PARAM.GAINLOSS_MNTLY_RUNDATE IS 'it holds date for Gainloss monthly run';
COMMENT ON COLUMN STOREDRFT_PARAM.SD_REPORT_QRY_RUNDATE IS 'it holds date for Store drafts report query run';
COMMENT ON COLUMN STOREDRFT_PARAM.JV_MNTLY_RUNDATE IS 'it holds date for Monthly JV run';
COMMENT ON COLUMN STOREDRFT_PARAM.QTLY_1099_RUNDATE IS 'it holds date for 1099 process quarterly  run';
COMMENT ON COLUMN STOREDRFT_PARAM.MNTLY_1099_RUNDATE IS 'it holds date for 1099 process monthly run';
COMMENT ON COLUMN STOREDRFT_PARAM.MID_MNTLY_1099_RUNDATE IS 'it holds date for 1099 process mid monthly run';
COMMENT ON COLUMN STOREDRFT_PARAM.DAILY_PREV_RUNDATE IS 'it holds date for daily load previous day run';

COMMIT;