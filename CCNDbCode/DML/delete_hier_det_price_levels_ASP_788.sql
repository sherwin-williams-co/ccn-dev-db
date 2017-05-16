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
BEGIN
--SELECTING ALL THOSE RECORDS WHICH ARE NOT MAPPED TO ANY CHILD RECORD 
FOR REC IN ( SELECT HD.*, ROWID  FROM HIERARCHY_DETAIL HD 
              WHERE HD.HRCHY_HDR_NAME = 'PRICE_DISTRICT'    
				AND HRCHY_DTL_LEVEL        <> '2'       --EXCLUDED LEAF NODES, AS LEAF NODES ARE ALWAYS MAP WITH COST CENTER    
				AND NOT EXISTS (SELECT 1               
								  FROM HIERARCHY_DETAIL       
								 WHERE HD.HRCHY_HDR_NAME      = 'PRICE_DISTRICT'           
								   AND HRCHY_HDR_NAME         = HD.HRCHY_HDR_NAME         
								   AND HRCHY_DTL_LEVEL        = (HD.HRCHY_DTL_LEVEL + '1')
								   AND HRCHY_DTL_PREV_LVL_VAL = HD.HRCHY_DTL_CURR_LVL_VAL      
								   AND HRCHY_DTL_CURR_LVL_VAL = HD.HRCHY_DTL_NEXT_LVL_VAL)) LOOP
								   
--DELETING ALL THOSE RECORDS WHICH ARE NOT MAPPED TO ANY CHILD RECORD 
    DELETE 
      FROM HIERARCHY_DETAIL
     WHERE HRCHY_HDR_NAME         = rec.HRCHY_HDR_NAME
       AND HRCHY_DTL_LEVEL        = rec.HRCHY_DTL_LEVEL
       AND HRCHY_DTL_PREV_LVL_VAL = rec.HRCHY_DTL_PREV_LVL_VAL
       AND HRCHY_DTL_CURR_LVL_VAL = rec.HRCHY_DTL_CURR_LVL_VAL
       AND ROWID                  = rec.ROWID;
	   
COMMIT;	 
END LOOP;
 
COMMIT;
END;
/

BEGIN
    CCN_BATCH_PKG.UNLOCK_DATABASE_SP();
END;
/
