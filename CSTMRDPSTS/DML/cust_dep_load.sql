/*
Script to re-load the customer deposit header and details
sxh487 05/29/2018
*/
BEGIN
    FOR each_cycle IN( SELECT * FROM POS_CSTMR_DEP_LOAD_STATUS ORDER BY RLS_RUN_CYCLE) LOOP
        CUSTOMER_DEPOSITS_DAILY_LOAD.LOAD_CUSTOMER_DEPOSIT_HDR( each_cycle.RLS_RUN_CYCLE);
        CUSTOMER_DEPOSITS_DAILY_LOAD.LOAD_CUSTOMER_DEPOSIT_DETAILS(each_cycle.RLS_RUN_CYCLE);
    END LOOP;
END;
/