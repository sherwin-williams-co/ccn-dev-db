/*
Below script to delete HIERARCHY_DETAIL price district levels which are cost centers are not attached to them.

Created : 05/16/2017 sxp130 : ASP-788 Price district hierarchy : cleanup of unattached levels
Approx execution Time : 2 to 3 minutes based on the volume
*/

BEGIN
    CCN_BATCH_PKG.LOCK_DATABASE_SP();
END;
/

DECLARE
    V_COUNT           NUMBER := 0;
    V_MAX_VALUE       NUMBER := 0;	
BEGIN

       --Check if the PRICE_DISTRICT levels are there in HIERARCHY_DESCRIPTION table 
       BEGIN
           SELECT COUNT(1) 
             INTO V_COUNT
             FROM HIERARCHY_DESCRIPTION
            WHERE HRCHY_HDR_NAME = 'PRICE_DISTRICT';
       EXCEPTION
           WHEN NO_DATA_FOUND THEN 
               RETURN;  --Exiting as there are no PRICE_DISTRICT levels
		   WHEN OTHERS THEN	   
               V_COUNT := 0;		   
       END;
	   
       --If record exists then get max value
       IF V_COUNT > 0 THEN
           --Below query will get the maximum level for PRICE_DISTRICT
           SELECT MAX(HRCHY_HDR_LVL_NBR)
             INTO V_MAX_VALUE
             FROM HIERARCHY_DESCRIPTION
            WHERE HRCHY_HDR_NAME = 'PRICE_DISTRICT';
       END IF;	   

	   
		--SELECTING ALL THOSE RECORDS WHICH ARE NOT MAPPED TO ANY CHILD RECORD 
		FOR REC IN ( SELECT HD.*, ROWID  FROM HIERARCHY_DETAIL HD 
					  WHERE HD.HRCHY_HDR_NAME = 'PRICE_DISTRICT'    
						AND HRCHY_DTL_LEVEL        <> V_MAX_VALUE       --EXCLUDED LEAF NODES, AS LEAF NODES ARE ALWAYS MAP WITH COST CENTER    
						AND NOT EXISTS (SELECT 1               
										  FROM HIERARCHY_DETAIL       
										 WHERE HRCHY_HDR_NAME         = HD.HRCHY_HDR_NAME         
										   AND HRCHY_DTL_LEVEL        = (HD.HRCHY_DTL_LEVEL + '1')
										   AND HRCHY_DTL_PREV_LVL_VAL = HD.HRCHY_DTL_CURR_LVL_VAL      
										   AND HRCHY_DTL_CURR_LVL_VAL = HD.HRCHY_DTL_NEXT_LVL_VAL)) LOOP
										   
		    --DELETING ALL THOSE RECORDS WHICH ARE NOT MAPPED TO ANY CHILD RECORD 
			DELETE 
			  FROM HIERARCHY_DETAIL
			 WHERE ROWID                  = rec.ROWID;
			   
		COMMIT;	 
		END LOOP;

END;
/

BEGIN
    CCN_BATCH_PKG.UNLOCK_DATABASE_SP();
END;
/
