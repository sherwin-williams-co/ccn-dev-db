/*
Below script will load the intermediate tables with the data before go-live
CCN_HEADERS_T 
CCN_SALES_LINES_T
CUST_DEP_CCN_ACCUMS_T

Created : 08/10/2018 sxh487 CCN Project Team....
Changed : 
*/

DECLARE
    V_COUNT NUMBER;
BEGIN
    V_COUNT := 0;
    FOR rec IN (SELECT TRAN_GUID, AMT, ACCUM_ID, RLS_RUN_CYCLE, SYSDATE FROM PNP.PRE_GO_LIVE_ACCUMS WHERE RLS_RUN_CYCLE < 1333) LOOP
        V_COUNT := V_COUNT + 1;
        INSERT INTO CUST_DEP_CCN_ACCUMS_T VALUES rec;
        IF V_COUNT = 1000 THEN
            V_COUNT := 0;
            COMMIT;
        END IF;
    END LOOP;
    COMMIT;
END;
DECLARE
    V_COUNT NUMBER;
BEGIN
    V_COUNT := 0;
    FOR rec IN (SELECT * FROM PNP.PRE_GO_LIVE_HEADERS WHERE RLS_RUN_CYCLE < 1333) LOOP
        V_COUNT := V_COUNT + 1;
        INSERT INTO CCN_HEADERS_T VALUES rec;
        IF V_COUNT = 1000 THEN
            V_COUNT := 0;
            COMMIT;
        END IF;
    END LOOP;
    COMMIT;
END;
DECLARE
    V_COUNT NUMBER;
BEGIN
    V_COUNT := 0;
    FOR rec IN (SELECT * FROM PNP.PRE_GO_LIVE_SALES WHERE RLS_RUN_CYCLE < 1333) LOOP
        V_COUNT := V_COUNT + 1;
        INSERT INTO CCN_SALES_LINES_T VALUES rec;
        IF V_COUNT = 1000 THEN
            V_COUNT := 0;
            COMMIT;
        END IF;
    END LOOP;
    COMMIT;
END;