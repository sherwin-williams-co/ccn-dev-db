/* 
    created by bxa919 on 03/13/2018
    Run this in COSTCNTR
	This script takes a copy of current POLLING_HST table 
	Deletes records in POLLING_HST that are also available in POLLING for 6 attributes
	Truncates the POLLING_HST table
	and repopulates the polling_hst table with updated effective and expiration dates
*/


-- Script to take a backup and delete unnecessary rows from HST table
SET SERVEROUTPUT ON 
BEGIN
    -- Takes copy of current POLLING_HST table
    EXECUTE IMMEDIATE 'CREATE TABLE POLLING_HST_NEW AS SELECT * FROM POLLING_HST ';   
    -- Truncates the POLLING_HST table
    EXECUTE IMMEDIATE 'TRUNCATE TABLE POLLING_HST';
END;

SET SERVEROUTPUT ON 
BEGIN
    -- repopulates the polling_hst table with updated current_flag and expiration dates
    INSERT INTO POLLING_HST
    SELECT  T.COST_CENTER_CODE
          , T.POLLING_STATUS_CODE
          , T.CHANGED_DATE
          , T.MULTICAST_IND
          , T.TIME_ZONE
          , T.POLLING_IND
          , T.NEXT_DOWNLOAD_BLOCK_COUNT
          , T.CURRENT_FLAG
          , COALESCE(LG, T.EFFECTIVE_DATE, T.CHANGED_DATE) EFFECTIVE_DATE  -- prev eff dt (or) eff dt of curr rec (or) chng dt of curr rec -- 
          , T.EXPIRATION_DATE
      FROM (SELECT A.COST_CENTER_CODE
                 , A.POLLING_STATUS_CODE
                 , A.CHANGED_DATE
                 , A.MULTICAST_IND
                 , A.TIME_ZONE
                 , A.POLLING_IND
                 , A.NEXT_DOWNLOAD_BLOCK_COUNT
                 , 'N' CURRENT_FLAG                                        -- Hardcoded to N
                 , A.EFFECTIVE_DATE
                 , NVL(A.EXPIRATION_DATE, A.CHANGED_DATE) EXPIRATION_DATE  -- Get the CHANGED_DATE if EXPIRATION_DATE is not available
                 , LAG(CHANGED_DATE) OVER(PARTITION BY COST_CENTER_CODE ORDER BY CHANGED_DATE) LG
             FROM POLLING_HST_NEW A
            --below condition will avoid the duplicate records that are present in the POlling table 
            WHERE (COST_CENTER_CODE, POLLING_STATUS_CODE, NVL(MULTICAST_IND, 'Z'), NVL(TIME_ZONE, '9'), NVL(POLLING_IND, 'Z'), NVL(NEXT_DOWNLOAD_BLOCK_COUNT, 'ABCDEFGH')) NOT IN
               (SELECT COST_CENTER_CODE,
                       POLLING_STATUS_CODE,
                       NVL(MULTICAST_IND, 'Z'),
                       NVL(TIME_ZONE, '9'),
                       NVL(POLLING_IND, 'Z'),
                       NVL(NEXT_DOWNLOAD_BLOCK_COUNT, 'ABCDEFGH')
                  FROM POLLING )
            ORDER BY COST_CENTER_CODE, CHANGED_DATE
          ) T;

    COMMIT;
END;
