/*
   This procedure is intended to clean up the XML attribute upper_lvl_ver_value in HIERARCHY_DESCRIPTION table for Price District Hierarchy
   Updating upper_lvl_ver_value xml value to NULL for Price District Hierarchy for all level in the HIERARCHY_DESCRIPTION Table.

Created by: SXP130 4-19-17 for ASP-771
*/

DECLARE
   cursor HIER_DESC_PRICE_DIST_CUR is
     select ROWID
       FROM HIERARCHY_DESCRIPTION
      WHERE UPPER(HRCHY_HDR_NAME) = UPPER('PRICE_DISTRICT');

   -- Varible Declaration
   v_count integer := 0;
   v_commit integer := 0;


Begin
   for HIER_DESC_PRICE_DIST_REC in HIER_DESC_PRICE_DIST_CUR loop
 BEGIN
         --Performing the update using the ROWID is measurable quicker than using the primary, even if the index blocks are cached.
         --This is because the index search is unnecessary if the ROWID is specified
         UPDATE  HIERARCHY_DESCRIPTION set upper_lvl_ver_value = NULL
            where ROWID = HIER_DESC_PRICE_DIST_REC.ROWID ;

         v_count := v_count + 1;
         v_commit := v_commit + 1;
         if v_commit > 500 then
            commit;
            v_commit := 0;
         end if;

   EXCEPTION
      WHEN others then
         dbms_output.put_line('Invalid Update of HIERARCHY_DESCRIPTION Table for row '
            || HIER_DESC_PRICE_DIST_REC.rowid
	          || ' '
            || sqlerrm);
 END;
END LOOP;
commit; --if v_commit is < 500 records should commit
   dbms_output.put_line('Total Update HIERARCHY_DESCRIPTION : '
      || v_count);
EXCEPTION
   when others then
   rollback;
      dbms_output.put_line('Table Not updated Stopped on Record - '
      || v_count);
END;
/