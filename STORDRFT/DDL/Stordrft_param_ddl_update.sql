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
COMMIT;