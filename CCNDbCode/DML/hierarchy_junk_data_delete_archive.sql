/*
Below script will expire the current hierarchy detail records that are dummy
comment added to comment the commit intentionally to validate the data in current and history tables before committing the changes

1 - expire the dummy records
2 - loop through the expired records
3 - build history parent details, if needed
4 - insert current details from current table to history table
5 - delete the current table and update any parent which is having this alone as a child

Takes around 1.5 to 2 minutes based on the volume of dummy details in the environment being ran

created : 09/29/2016 jxc517 CCN Project Team....
changed :
*/
DECLARE
    CURSOR master_cur IS
        SELECT *
          FROM HIERARCHY_DETAIL
         WHERE HRCHY_DTL_EXP_DATE <= TRUNC(SYSDATE);
    
    CURSOR cur(IN_HIERARCHY_DETAIL_REC HIERARCHY_DETAIL%ROWTYPE) IS
        SELECT HD.*
          FROM HIERARCHY_DETAIL HD,
               (SELECT HRCHY_HDR_NAME,
                       HRCHY_HDR_LVL_NBR,
                       SUBSTR(IN_HIERARCHY_DETAIL_REC.HRCHY_DTL_CURR_LVL_VAL, 1, SUM_VAL - LVL_VALUE_SIZE) PREV_VAL, --702770
                       SUBSTR(IN_HIERARCHY_DETAIL_REC.HRCHY_DTL_CURR_LVL_VAL, 1, SUM_VAL) CURR_VAL
                  FROM (SELECT HRCHY_HDR_NAME,
                               HRCHY_HDR_LVL_NBR,
                               LVL_VALUE_SIZE,
                               SUM(LVL_VALUE_SIZE) OVER (PARTITION BY HRCHY_HDR_NAME ORDER BY HRCHY_HDR_LVL_NBR) SUM_VAL
                          FROM HIERARCHY_DESCRIPTION
                         WHERE HRCHY_HDR_NAME    = IN_HIERARCHY_DETAIL_REC.HRCHY_HDR_NAME
                           AND HRCHY_HDR_LVL_NBR <= IN_HIERARCHY_DETAIL_REC.HRCHY_DTL_LEVEL)) A
         WHERE HRCHY_DTL_CURR_LVL_VAL = PREV_VAL
           AND HRCHY_DTL_NEXT_LVL_VAL = CURR_VAL
           AND HD.HRCHY_HDR_NAME      = A.HRCHY_HDR_NAME
           AND HD.HRCHY_DTL_LEVEL+1   = A.HRCHY_HDR_LVL_NBR;
    V_HIERARCHY_DETAIL_ROW HIERARCHY_DETAIL%ROWTYPE;

PROCEDURE HIERARCHY_DELETE_WRAPPER(
    IN_HIERARCHY_DETAIL_ROW IN HIERARCHY_DETAIL%ROWTYPE)
IS
BEGIN
       DELETE FROM HIERARCHY_DETAIL
        WHERE HRCHY_HDR_NAME         = IN_HIERARCHY_DETAIL_ROW.HRCHY_HDR_NAME
          AND HRCHY_DTL_LEVEL        = IN_HIERARCHY_DETAIL_ROW.HRCHY_DTL_LEVEL
          AND HRCHY_DTL_CURR_LVL_VAL = IN_HIERARCHY_DETAIL_ROW.HRCHY_DTL_CURR_LVL_VAL
          AND HRCHY_DTL_NEXT_LVL_VAL = IN_HIERARCHY_DETAIL_ROW.HRCHY_DTL_NEXT_LVL_VAL;
END HIERARCHY_DELETE_WRAPPER;

PROCEDURE DELETE_DETAIL_PROCESS(
    IN_HIST_FLAG            IN VARCHAR2,
    IN_HIERARCHY_DETAIL_ROW IN HIERARCHY_DETAIL%ROWTYPE)
IS
   V_LAST_CHILD                  VARCHAR2(1);
   V_HIERARCHY_DETAIL_ROW_PREV   HIERARCHY_DETAIL%ROWTYPE;
BEGIN
   --Before deleting, check if the record exists using below condition
   IF CCN_HIERARCHY.CURRENT_LVL_EXISTS(IN_HIST_FLAG, IN_HIERARCHY_DETAIL_ROW) = 'Y' THEN
      --Delete the existing record
      HIERARCHY_DELETE_WRAPPER(IN_HIERARCHY_DETAIL_ROW);
      
      --Get previous record for update/delete, if one exists
      CCN_HIERARCHY.GET_PREVIOUS_LVL(IN_HIST_FLAG,
                                     IN_HIERARCHY_DETAIL_ROW,
                                     V_HIERARCHY_DETAIL_ROW_PREV);
      
      BEGIN
         --Check if this is the last record being deleted at parent level
         SELECT DECODE(COUNT(*),1,'Y','N') INTO V_LAST_CHILD
           FROM HIERARCHY_DETAIL
          WHERE HRCHY_HDR_NAME         = IN_HIERARCHY_DETAIL_ROW.HRCHY_HDR_NAME
            AND HRCHY_DTL_LEVEL        = (IN_HIERARCHY_DETAIL_ROW.HRCHY_DTL_LEVEL -'1')
            AND HRCHY_DTL_CURR_LVL_VAL = IN_HIERARCHY_DETAIL_ROW.HRCHY_DTL_PREV_LVL_VAL;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            V_LAST_CHILD := 'N';
      END;
      IF V_LAST_CHILD = 'Y' THEN
         --This is the last record at parent level. So update previous[parent] records next level value as ~~~
         V_HIERARCHY_DETAIL_ROW_PREV.HRCHY_DTL_NEXT_LVL_VAL := '~~~';
         CCN_HIERARCHY.HIERARCHY_UPDATE_WRAPPER(IN_HIST_FLAG, V_HIERARCHY_DETAIL_ROW_PREV);
      ELSE
         --This is the NOT the last record at parent level. So we can delete this at parent level
         HIERARCHY_DELETE_WRAPPER(V_HIERARCHY_DETAIL_ROW_PREV);
      END IF;
   
   END IF;
END DELETE_DETAIL_PROCESS;
BEGIN
    --Expire all the junk records
    UPDATE HIERARCHY_DETAIL
       SET HRCHY_DTL_EXP_DATE = TRUNC(SYSDATE)
     WHERE LENGTH(HRCHY_DTL_CURR_ROW_VAL) = 6
       AND NOT EXISTS (SELECT 1
                         FROM COST_CENTER
                        WHERE COST_CENTER_CODE = HRCHY_DTL_CURR_ROW_VAL);

    --loop through all the expired records
    FOR rec1 IN master_cur LOOP
        --build history parent levels as needed
        FOR rec IN cur(rec1) LOOP
            IF CCN_HIERARCHY.CURRENT_LVL_EXISTS('H', rec) = 'N' THEN        
                CCN_HIERARCHY.HIERARCHY_INSERT_WRAPPER('H', rec);
            END IF;
        END LOOP;
        V_HIERARCHY_DETAIL_ROW := rec1;
        --insert history current level
        CCN_HIERARCHY.HIERARCHY_INSERT_WRAPPER('H', V_HIERARCHY_DETAIL_ROW);
        --delete the current level from current table
        DELETE_DETAIL_PROCESS(NULL, V_HIERARCHY_DETAIL_ROW);
    END LOOP;
    
    COMMIT; --comment out while running to validate data before committing
END;
/