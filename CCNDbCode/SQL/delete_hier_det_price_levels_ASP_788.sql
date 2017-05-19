/*
Below script to delete HIERARCHY_DETAIL price district levels which are cost centers are not attached to them.

Created : 05/16/2017 sxp130 : ASP-788 Price district hierarchy : cleanup of unattached levels
*/

BEGIN
    CCN_BATCH_PKG.LOCK_DATABASE_SP();
END;
/

DECLARE
    V_HRCHY_HDR_LVL_NBR     HIERARCHY_DESCRIPTION.HRCHY_HDR_LVL_NBR%TYPE;
BEGIN
    --get Price District Cost center level number
    V_HRCHY_HDR_LVL_NBR := CCN_HIER_BUSINESS_RULES_PKG.GET_HDR_LVL_NBR_SP('PRICE_DISTRICT',
                                                                          'Cost Center');

    --selecting all those records which are not mapped to any child record 
    FOR REC IN (SELECT HD.*,
                       ROWID
                  FROM HIERARCHY_DETAIL HD 
                 WHERE HD.HRCHY_HDR_NAME = 'PRICE_DISTRICT'
                   AND HRCHY_DTL_LEVEL   < V_HRCHY_HDR_LVL_NBR
                   AND NOT EXISTS (SELECT 1
                                     FROM HIERARCHY_DETAIL
                                    WHERE HRCHY_HDR_NAME         = HD.HRCHY_HDR_NAME
                                      AND HRCHY_DTL_LEVEL        = (HD.HRCHY_DTL_LEVEL + '1')
                                      AND HRCHY_DTL_PREV_LVL_VAL = HD.HRCHY_DTL_CURR_LVL_VAL
                                      AND HRCHY_DTL_CURR_LVL_VAL = HD.HRCHY_DTL_NEXT_LVL_VAL)) LOOP

        --deleting all those records which are not mapped to any child record 
        DELETE 
          FROM HIERARCHY_DETAIL
         WHERE ROWID = rec.ROWID;
        COMMIT;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
       DBMS_OUTPUT.PUT_LINE('FAILED ' || SQLCODE || ' ' || SQLERRM);
       :EXITCODE := 2;
END;
/

BEGIN
    CCN_BATCH_PKG.UNLOCK_DATABASE_SP();
END;
/
