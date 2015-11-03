/***************************************************************
This DML will Insert the first record into STOREDRFT_PARAM table 
CREATED : 11/03/2015 axk326 CCN Project team....
MODIFIED: 
****************************************************************/
-- DELETE any records (if existing) from STOREDRFT_PARAM table 
DELETE FROM STOREDRFT_PARAM;
COMMIT;

-- INSERT the first record INTO STOREDRFT_PARAM table
INSERT INTO STOREDRFT_PARAM (DAILY_LOAD_RUNDATE,
                             PL_GAIN_RUNDATE,
                             GAINLOSS_MNTLY_RUNDATE,
                             SD_REPORT_QRY_RUNDATE,
                             JV_MNTLY_RUNDATE,
                             QTLY_1099_RUNDATE,
                             MNTLY_1099_RUNDATE,
                             MID_MNTLY_1099_RUNDATE,
                             DAILY_PREV_RUNDATE) 
                    VALUES (TRUNC(SYSDATE),
                            TRUNC(SYSDATE,'Q'),
                            TRUNC(ADD_MONTHS(SYSDATE,-1),'MM'),
                            TRUNC(SYSDATE,'MM'),
                            TRUNC(SYSDATE,'MM'),
                            TRUNC(SYSDATE,'MM'),
                            TRUNC(SYSDATE,'MM'),
                            TRUNC(ADD_MONTHS(SYSDATE,-1),'MM'),
                            TRUNC(sysdate-1));
COMMIT;							