/*
Admin Org Hierarchy data clean up for domain, group and division
Updated domain, group and division levels to replace 9's with 0's for admin org hierarchy record. 
Created : 12/11/2017 mxv711 CCN Project Team....
*/
DECLARE
    v_hrchy_dtl_curr_lvl_val    HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE;
    v_hrchy_dtl_prev_lvl_val    HIERARCHY_DETAIL.HRCHY_DTL_PREV_LVL_VAL%TYPE;
    v_hrchy_dtl_next_lvl_val    HIERARCHY_DETAIL.HRCHY_DTL_NEXT_LVL_VAL%TYPE;
    v_hrchy_dtl_curr_row_val    HIERARCHY_DETAIL.HRCHY_DTL_CURR_ROW_VAL%TYPE;
    v_count                     NUMBER :=0;
    CURSOR main_cur IS
        SELECT ROWID as ROW_ID, A.*
          FROM HIERARCHY_DETAIL A
         WHERE HRCHY_HDR_NAME  = 'ADMINORG_HIERARCHY';
BEGIN
    FOR REC IN main_cur LOOP
        v_hrchy_dtl_curr_lvl_val := NULL;
        v_hrchy_dtl_prev_lvl_val := NULL;
        v_hrchy_dtl_next_lvl_val := NULL;
        v_hrchy_dtl_curr_row_val := NULL;
        -- if hierarchy is in domain, group and division level then we need to update complete record ( exclude cost center if exits)
        IF REC.hrchy_dtl_level IN ( 1,2,3) THEN
            IF length(REC.hrchy_dtl_curr_row_val) = 4 THEN
            -- if this row is not cost center level row.
                v_hrchy_dtl_curr_lvl_val  := REGEXP_REPLACE(REC.hrchy_dtl_curr_lvl_val, '9', '0') ;
                v_hrchy_dtl_prev_lvl_val  := REGEXP_REPLACE(REC.hrchy_dtl_prev_lvl_val, '9', '0') ;
                v_hrchy_dtl_curr_row_val  := REGEXP_REPLACE(REC.hrchy_dtl_curr_row_val, '9', '0');
                IF MOD(length(REC.hrchy_dtl_next_lvl_val),4) <> 0 THEN
                -- next level is cost center level.
                   v_hrchy_dtl_next_lvl_val := REGEXP_REPLACE(SUBSTR(REC.hrchy_dtl_next_lvl_val, 1, LENGTH(REC.hrchy_dtl_next_lvl_val)-6), '9', '0') || SUBSTR(REC.hrchy_dtl_next_lvl_val, LENGTH(REC.hrchy_dtl_next_lvl_val)-5);
                ELSE
                   v_hrchy_dtl_next_lvl_val  := REGEXP_REPLACE(REC.hrchy_dtl_next_lvl_val, '9','0' );
                END IF;
             ELSIF length(REC.hrchy_dtl_curr_row_val) = 6 THEN
             -- if this level is cost center row.
                 v_hrchy_dtl_curr_lvl_val  := REGEXP_REPLACE(SUBSTR(REC.hrchy_dtl_curr_lvl_val, 1,LENGTH(REC.hrchy_dtl_curr_lvl_val)-6), '9','0' ) || SUBSTR(REC.hrchy_dtl_curr_lvl_val, LENGTH(REC.hrchy_dtl_curr_lvl_val)-5) ;
                 v_hrchy_dtl_prev_lvl_val  := REGEXP_REPLACE(REC.hrchy_dtl_prev_lvl_val, '9','0');
             END IF; 
        ELSE 
        -- if the level is greater then 3 then we need to update the 9's in first 12 characters only.
              v_hrchy_dtl_curr_lvl_val := REGEXP_REPLACE(SUBSTR(REC.hrchy_dtl_curr_lvl_val,1,12), '9', '0') || SUBSTR(REC.hrchy_dtl_curr_lvl_val,13);
              v_hrchy_dtl_prev_lvl_val := REGEXP_REPLACE(SUBSTR(REC.hrchy_dtl_prev_lvl_val,1,12), '9', '0') || SUBSTR(REC.hrchy_dtl_prev_lvl_val,13);
              v_hrchy_dtl_next_lvl_val := REGEXP_REPLACE(SUBSTR(REC.hrchy_dtl_next_lvl_val,1,12), '9', '0') || SUBSTR(REC.hrchy_dtl_next_lvl_val,13);
        END IF;
                
        UPDATE HIERARCHY_DETAIL hd
           SET hd.hrchy_dtl_curr_lvl_val  = NVL(v_hrchy_dtl_curr_lvl_val, hd.hrchy_dtl_curr_lvl_val),
               hd.hrchy_dtl_prev_lvl_val  = NVL(v_hrchy_dtl_prev_lvl_val , hd.hrchy_dtl_prev_lvl_val),
               hd.hrchy_dtl_next_lvl_val  = NVL(v_hrchy_dtl_next_lvl_val, hd.hrchy_dtl_next_lvl_val),
               hd.hrchy_dtl_curr_row_val  = NVL(v_hrchy_dtl_curr_row_val, hd.hrchy_dtl_curr_row_val)
         WHERE ROWID = rec.ROW_ID;
        v_count := v_count +1;
    END LOOP;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('No of records updated for ADMINORG HIERARCHY : ' || v_count);
END;
