-- created by rxv940 on 03/13/2018
-- Run this in COSTCNTR

-- Script to take a backup and delete unnecessary rows from HST table
SET SERVEROUTPUT ON 
BEGIN
    EXECUTE IMMEDIATE 'CREATE TABLE POLLING_HST_NEW AS SELECT * FROM POLLING_HST ';   
    
    DELETE 
	  FROM POLLING_HST 
     WHERE (COST_CENTER_CODE, POLLING_STATUS_CODE, NVL(MULTICAST_IND, 'Z'), NVL(TIME_ZONE, '9'), NVL(POLLING_IND, 'Z'), NVL(NEXT_DOWNLOAD_BLOCK_COUNT, 'ABCDEFGH')) IN 
       (
        SELECT COST_CENTER_CODE, 
		       POLLING_STATUS_CODE, 
			   NVL(MULTICAST_IND, 'Z'), 
			   NVL(TIME_ZONE, '9'), 
			   NVL(POLLING_IND, 'Z'), 
			   NVL(NEXT_DOWNLOAD_BLOCK_COUNT, 'ABCDEFGH') 
	      FROM POLLING 
        );
       COMMIT;
END ;


-- wiping off the HST table and re-loading it
SET SERVEROUTPUT ON 
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE POLLING_HST';
    
    INSERT INTO POLLING_HST
    (
    COST_CENTER_CODE
    , POLLING_STATUS_CODE
    , CHANGED_DATE
    , MULTICAST_IND
    , TIME_ZONE
    , POLLING_IND
    , NEXT_DOWNLOAD_BLOCK_COUNT
    , CURRENT_FLAG
    , EFFECTIVE_DATE
    , EXPIRATION_DATE
    )
    SELECT  T.COST_CENTER_CODE
          , T.POLLING_STATUS_CODE
          , T.CHANGED_DATE
          , T.MULTICAST_IND
          , T.TIME_ZONE
          , T.POLLING_IND
          , T.NEXT_DOWNLOAD_BLOCK_COUNT
          , T.CURRENT_FLAG
          , COALESCE(LG, T.EFFECTIVE_DATE, T.CHANGED_DATE) EFFECTIVE_DATE  -- exp dt of prev rec (or) eff dt of curr rec (or) exp dt of curr rec
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
            ORDER BY COST_CENTER_CODE, CHANGED_DATE
          ) T;
          
    COMMIT;
END;    
END;
        );
       COMMIT;
END ;

SET SERVEROUTPUT ON 
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE POLLING_HST';
    
    INSERT INTO POLLING_HST
    (
    COST_CENTER_CODE
    , POLLING_STATUS_CODE
    , CHANGED_DATE
    , MULTICAST_IND
    , TIME_ZONE
    , POLLING_IND
    , NEXT_DOWNLOAD_BLOCK_COUNT
    , CURRENT_FLAG
    , EFFECTIVE_DATE
    , EXPIRATION_DATE
    )
    SELECT  T.COST_CENTER_CODE
          , T.POLLING_STATUS_CODE
          , T.CHANGED_DATE
          , T.MULTICAST_IND
          , T.TIME_ZONE
          , T.POLLING_IND
          , T.NEXT_DOWNLOAD_BLOCK_COUNT
          , T.CURRENT_FLAG
          , COALESCE(LG, T.EFFECTIVE_DATE, T.CHANGED_DATE) EFFECTIVE_DATE  -- exp dt of prev rec (or) eff dt of curr rec (or) exp dt of curr rec
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
            ORDER BY COST_CENTER_CODE, CHANGED_DATE
          ) T;
          
    COMMIT;
END; 



-- Script to drop backup table
SET SERVEROUTPUT ON 
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE POLLING_HST_NEW PURGE';      
END;