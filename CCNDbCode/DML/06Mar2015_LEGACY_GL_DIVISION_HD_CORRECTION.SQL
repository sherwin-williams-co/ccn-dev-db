--Below script will correct the legacy GL duivisions curr row value that is not matching with the curr level value
--have to send these details in audit
BEGIN
    CCN_BATCH_PKG.LOCK_DATABASE_SP();
    --COMMON_TOOLS.ALTER_ALL_TRIGGERS ('DISABLE');
END;
/

SELECT COUNT(*)
  FROM HIERARCHY_DETAIL HD
 WHERE HD.HRCHY_DTL_CURR_ROW_VAL <> SUBSTR(HD.HRCHY_DTL_CURR_LVL_VAL,
                                        -(SELECT LVL_VALUE_SIZE
                                            FROM HIERARCHY_DESCRIPTION
                                           WHERE HRCHY_HDR_LVL_NBR = HD.HRCHY_DTL_LEVEL
                                             AND HRCHY_HDR_NAME = HD.HRCHY_HDR_NAME));
--88 Row(s) Selected

UPDATE HIERARCHY_DETAIL HD
   SET HRCHY_DTL_CURR_ROW_VAL = SUBSTR(HD.HRCHY_DTL_CURR_LVL_VAL,
                                        -(SELECT LVL_VALUE_SIZE
                                            FROM HIERARCHY_DESCRIPTION
                                           WHERE HRCHY_HDR_LVL_NBR = HD.HRCHY_DTL_LEVEL
                                             AND HRCHY_HDR_NAME = HD.HRCHY_HDR_NAME))
 WHERE HD.HRCHY_DTL_CURR_ROW_VAL <> SUBSTR(HD.HRCHY_DTL_CURR_LVL_VAL,
                                        -(SELECT LVL_VALUE_SIZE
                                            FROM HIERARCHY_DESCRIPTION
                                           WHERE HRCHY_HDR_LVL_NBR = HD.HRCHY_DTL_LEVEL
                                             AND HRCHY_HDR_NAME = HD.HRCHY_HDR_NAME));
--88 Row(s) Updated

COMMIT;

BEGIN
    CCN_BATCH_PKG.UNLOCK_DATABASE_SP();
    --COMMON_TOOLS.ALTER_ALL_TRIGGERS ('ENABLE');
END;
/
