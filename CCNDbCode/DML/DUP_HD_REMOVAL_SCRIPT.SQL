--Below script is used to remove duplicates from HIERARCH_DETAIL table at any level

BEGIN
    CCN_BATCH_PKG.LOCK_DATABASE_SP();
END;
/

BEGIN
    FOR rec IN (SELECT HRCHY_HDR_NAME, HRCHY_DTL_LEVEL, HRCHY_DTL_PREV_LVL_VAL, HRCHY_DTL_CURR_LVL_VAL, HRCHY_DTL_NEXT_LVL_VAL, COUNT(*) CNT
                  FROM HIERARCHY_DETAIL
                 GROUP BY HRCHY_HDR_NAME, HRCHY_DTL_LEVEL, HRCHY_DTL_PREV_LVL_VAL, HRCHY_DTL_CURR_LVL_VAL, HRCHY_DTL_NEXT_LVL_VAL
                HAVING COUNT(*) >  1
                 ORDER BY HRCHY_HDR_NAME, HRCHY_DTL_LEVEL, HRCHY_DTL_PREV_LVL_VAL, HRCHY_DTL_CURR_LVL_VAL, HRCHY_DTL_NEXT_LVL_VAL) LOOP
        DELETE
          FROM HIERARCHY_DETAIL
         WHERE HRCHY_HDR_NAME                  = rec.HRCHY_HDR_NAME
           AND HRCHY_DTL_LEVEL                 = rec.HRCHY_DTL_LEVEL
           AND NVL(HRCHY_DTL_PREV_LVL_VAL,'X') = NVL(rec.HRCHY_DTL_PREV_LVL_VAL,'X')
           AND NVL(HRCHY_DTL_CURR_LVL_VAL,'X') = NVL(rec.HRCHY_DTL_CURR_LVL_VAL,'X')
           AND NVL(HRCHY_DTL_NEXT_LVL_VAL,'X') = NVL(rec.HRCHY_DTL_NEXT_LVL_VAL,'X')
           AND ROWNUM < rec.CNT;
    END LOOP;
    COMMIT;
END;
/

BEGIN
    CCN_BATCH_PKG.UNLOCK_DATABASE_SP();
END;
/
