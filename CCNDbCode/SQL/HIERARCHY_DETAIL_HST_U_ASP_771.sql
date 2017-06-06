/*
   This procedure is intended to clean up the xml attribute upper_lvl_ver_value in hierarchy_detail_hst table for price district hierarchy
   updating upper_lvl_ver_value xml value to null for price district hierarchy for all level in the hierarchy_detail_hst table.

created by: sxp130 06-06-17 for ASP-771
*/
DECLARE
   CURSOR hier_detail_hst_price_dist_cur IS
      SELECT ROWID
        FROM hierarchy_detail_hst
       WHERE Upper(hrchy_hdr_name) = Upper('PRICE_DISTRICT');

   -- varible declaration
   v_count INTEGER := 0;
   v_commit INTEGER := 0;

BEGIN
   FOR hier_detail_hst_price_dist_rec IN hier_detail_hst_price_dist_cur LOOP
      BEGIN
         --performing the update using the rowid is measurable quicker than using the primary, even if the index blocks are cached.
         --this is because the index search is unnecessary if the rowid is specified
         UPDATE hierarchy_detail_hst
            SET upper_lvl_ver_value = NULL
          WHERE ROWID = hier_detail_hst_price_dist_rec.ROWID ;

         v_count := v_count + 1;
         v_commit := v_commit + 1;
         IF v_commit > 500 THEN
            COMMIT;
            v_commit := 0;
         END IF;

      EXCEPTION
         WHEN OTHERS THEN
            Dbms_Output.put_line('invalid update of hierarchy_detail_hst table for row '
                                || hier_detail_hst_price_dist_rec.ROWID
                                || ' '
                                || SQLERRM);
      END;
   END LOOP;
   COMMIT; --if v_commit is < 500 records should commit
   Dbms_Output.put_line('total update hierarchy_detail_hst : '
                        || v_count);
EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      Dbms_Output.put_line('table not updated stopped on record - '
                           || v_count);
END;
/