/**********************************************************************************
The existing code is deleting hierarchy records randomly during the hierarchy transfer. Fixed the code for this issue.
This script will insert missing records in hierarchy which are already deleted from hierarchy detail table.

Created : 12/27/2018 pxa852 CCN Project ASP-1183....
Modified:
**********************************************************************************/
SET SERVEROUTPUT ON;
DECLARE
    V_HD_REC HIERARCHY_DETAIL%ROWTYPE;
BEGIN
    FOR rec IN (SELECT HD.*
                  FROM HIERARCHY_DETAIL HD,
                       HIERARCHY_HEADER HH
                 WHERE HD.HRCHY_HDR_NAME = HH.HRCHY_HDR_NAME
                   AND HD.HRCHY_DTL_LEVEL = HH.HRCHY_HDR_LEVELS
                   AND NOT EXISTS (SELECT 1
                                     FROM HIERARCHY_DETAIL
                                    WHERE HRCHY_HDR_NAME         = HD.HRCHY_HDR_NAME
                                      AND HRCHY_DTL_LEVEL        = (HD.HRCHY_DTL_LEVEL - '1')
                                      AND HRCHY_DTL_CURR_LVL_VAL = HD.HRCHY_DTL_PREV_LVL_VAL
                                      AND HRCHY_DTL_NEXT_LVL_VAL = HD.HRCHY_DTL_CURR_LVL_VAL)) LOOP
        CCN_HIERARCHY.GET_PREVIOUS_LVL(NULL,rec,V_HD_REC);
        IF V_HD_REC.HRCHY_HDR_NAME IS NULL THEN
           DBMS_OUTPUT.PUT_LINE('Previous level not attached to any other cost center : ' || rec.HRCHY_HDR_NAME || '-' ||
                                                                                  rec.HRCHY_DTL_LEVEL || '-' ||
                                                                                  rec.HRCHY_DTL_PREV_LVL_VAL || '-' ||
                                                                                  rec.HRCHY_DTL_CURR_LVL_VAL || '-' ||
                                                                                  rec.HRCHY_DTL_NEXT_LVL_VAL
                                                                                  );
        ELSIF NVL(V_HD_REC.HRCHY_DTL_NEXT_LVL_VAL,'~~~') = '~~~' THEN
           --If previous level's Next Value is ~~~, we need to update that with current level value
           V_HD_REC.HRCHY_DTL_NEXT_LVL_VAL := rec.HRCHY_DTL_CURR_LVL_VAL;
           DBMS_OUTPUT.PUT_LINE('came here - update : '||rec.HRCHY_DTL_CURR_LVL_VAL);
           CCN_HIERARCHY.HIERARCHY_UPDATE_WRAPPER(NULL, V_HD_REC);
        ELSIF V_HD_REC.HRCHY_DTL_NEXT_LVL_VAL <> rec.HRCHY_DTL_CURR_LVL_VAL THEN
           --If previous level's Next Value is NOT ~~~ and NOT current level value, insert one
           V_HD_REC.HRCHY_DTL_NEXT_LVL_VAL := rec.HRCHY_DTL_CURR_LVL_VAL;
           V_HD_REC.HRCHY_DTL_EFF_DATE     := NVL(rec.HRCHY_DTL_EFF_DATE, SYSDATE);
           DBMS_OUTPUT.PUT_LINE('came here - insert : '||rec.HRCHY_DTL_CURR_LVL_VAL);
           CCN_HIERARCHY.HIERARCHY_INSERT_WRAPPER(NULL, V_HD_REC);
        END IF;
        COMMIT;
    END LOOP;
END;