/*
script to update the rls_run_cycle 0 from pre_go_live tables
sxh487 08/30/2018
*/
declare
cursor all_accts is 
       select *
         from ccn_headers_T
        where rls_run_cycle =0
         order by tran_timestamp;

v_rls_run_cycle NUMBER;    
V_COUNT NUMBER;
BEGIN
    V_COUNT := 0;
    FOR each_acctnbr IN all_accts LOOP
        V_COUNT := V_COUNT + 1;
            BEGIN
               select rls_run_cycle
                 INTO v_rls_run_cycle
                 from
                 (select * 
                    from ccn_headers_T a
                   where A.rls_run_cycle > 0
                     and tran_timestamp > each_acctnbr.tran_timestamp
                  )
                WHERE rownum < 2;
             EXCEPTION
                WHEN OTHERS THEN
                   NULL;
             END;
             
            update ccn_headers_T a
               set rls_run_cycle = v_rls_run_cycle                      
             where tran_timestamp = each_acctnbr.tran_timestamp
               and rls_run_cycle =0;     
            
            update ccn_sales_lines_T a
               set rls_run_cycle = v_rls_run_cycle
             where rls_run_cycle =0 
               AND tran_guid IN (SELECT TRAN_GUID
                                   FROM ccn_headers_T
                                  WHERE rls_run_cycle =v_rls_run_cycle
                                )
              and non_merch_code ='05'; 
              
             IF V_COUNT = 1000 THEN
                V_COUNT := 0;
                COMMIT;
             END IF;
    END LOOP;

END;
/