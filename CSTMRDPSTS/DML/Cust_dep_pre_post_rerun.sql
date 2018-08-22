/*
Script to re-load the customer deposit header and details
for pre-go-live data and post-go-live data
sxh487 08/10/2018
*/
BEGIN
    FOR each_cycle IN( SELECT distinct RLS_RUN_CYCLE FROM CUST_DEP_CCN_ACCUMS_T WHERE RLS_RUN_CYCLE <> 0 ORDER BY RLS_RUN_CYCLE) LOOP
        CUSTOMER_DEPOSITS_DAILY_LOAD.LOAD_CUSTOMER_DEPOSIT_HDR( each_cycle.RLS_RUN_CYCLE);
        CUSTOMER_DEPOSITS_DAILY_LOAD.LOAD_CUSTOMER_DEPOSIT_DETAILS(each_cycle.RLS_RUN_CYCLE);
    END LOOP;
END;
/