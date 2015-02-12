--Below script will eliminate the incorrect records and update the next level value with '~~~' for the records which doesn't have child records
BEGIN
    CCN_BATCH_PKG.LOCK_DATABASE_SP();
    COMMON_TOOLS.ALTER_ALL_TRIGGERS ('DISABLE');
END;
/

SELECT COUNT(*)
  FROM HIERARCHY_DETAIL
 WHERE HRCHY_DTL_NEXT_LVL_VAL IS NULL;
--2720 Row(s) Selected

--Update the next level value with ~~~ for which there are no childs
SELECT COUNT(*)
  FROM HIERARCHY_DETAIL HD
 WHERE HRCHY_DTL_NEXT_LVL_VAL IS NULL
   AND NOT EXISTS (SELECT 1
                     FROM HIERARCHY_DETAIL
                    WHERE HRCHY_HDR_NAME         = HD.HRCHY_HDR_NAME
                      AND HRCHY_DTL_LEVEL        = HD.HRCHY_DTL_LEVEL
                      AND HRCHY_DTL_PREV_LVL_VAL = HD.HRCHY_DTL_PREV_LVL_VAL
                      AND HRCHY_DTL_CURR_LVL_VAL = HD.HRCHY_DTL_CURR_LVL_VAL
                      AND HRCHY_DTL_NEXT_LVL_VAL IS NOT NULL);
--1728 Row(s) Selected
UPDATE HIERARCHY_DETAIL HD
   SET HRCHY_DTL_NEXT_LVL_VAL = '~~~'
 WHERE HRCHY_DTL_NEXT_LVL_VAL IS NULL
   AND NOT EXISTS (SELECT 1
                     FROM HIERARCHY_DETAIL
                    WHERE HRCHY_HDR_NAME         = HD.HRCHY_HDR_NAME
                      AND HRCHY_DTL_LEVEL        = HD.HRCHY_DTL_LEVEL
                      AND HRCHY_DTL_PREV_LVL_VAL = HD.HRCHY_DTL_PREV_LVL_VAL
                      AND HRCHY_DTL_CURR_LVL_VAL = HD.HRCHY_DTL_CURR_LVL_VAL
                      AND HRCHY_DTL_NEXT_LVL_VAL IS NOT NULL);
--1728 Row(s) Updated

--Delete the records which are having next level value as null but having anpther record mapped to child record [Duplicate records]
SELECT COUNT(*)
  FROM HIERARCHY_DETAIL HD
 WHERE HRCHY_DTL_NEXT_LVL_VAL IS NULL
   AND EXISTS (SELECT 1
                 FROM HIERARCHY_DETAIL
                WHERE HRCHY_HDR_NAME         = HD.HRCHY_HDR_NAME
                  AND HRCHY_DTL_LEVEL        = HD.HRCHY_DTL_LEVEL
                  AND HRCHY_DTL_PREV_LVL_VAL = HD.HRCHY_DTL_PREV_LVL_VAL
                  AND HRCHY_DTL_CURR_LVL_VAL = HD.HRCHY_DTL_CURR_LVL_VAL
                  AND HRCHY_DTL_NEXT_LVL_VAL IS NOT NULL);
--992 Row(s) Selected
DELETE
  FROM HIERARCHY_DETAIL HD
 WHERE HRCHY_DTL_NEXT_LVL_VAL IS NULL
   AND EXISTS (SELECT 1
                 FROM HIERARCHY_DETAIL
                WHERE HRCHY_HDR_NAME         = HD.HRCHY_HDR_NAME
                  AND HRCHY_DTL_LEVEL        = HD.HRCHY_DTL_LEVEL
                  AND HRCHY_DTL_PREV_LVL_VAL = HD.HRCHY_DTL_PREV_LVL_VAL
                  AND HRCHY_DTL_CURR_LVL_VAL = HD.HRCHY_DTL_CURR_LVL_VAL
                  AND HRCHY_DTL_NEXT_LVL_VAL IS NOT NULL);
--992 Row(s) Selected

COMMIT;

BEGIN
    CCN_BATCH_PKG.UNLOCK_DATABASE_SP();
    COMMON_TOOLS.ALTER_ALL_TRIGGERS ('ENABLE');
END;
/
