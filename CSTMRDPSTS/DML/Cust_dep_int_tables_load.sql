/*
Below script will create temporary tables and loads them using PNP (POS) table

Created : 25/29/2018  jxc517 CCN Project Team....
Changed : 
*/
CREATE TABLE CCN_HEADERS_T AS SELECT * FROM PNP.CCN_HEADERS WHERE 1=2; --57751158
CREATE TABLE CCN_SALES_LINES_T AS SELECT * FROM PNP.CCN_SALES_LINES WHERE 1=2; --27007333

DECLARE
    V_COUNT NUMBER;
BEGIN
    V_COUNT := 0;
    FOR rec IN (SELECT * FROM PNP.CCN_HEADERS) LOOP
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
    FOR rec IN (SELECT * FROM PNP.CCN_SALES_LINES) LOOP
        V_COUNT := V_COUNT + 1;
        INSERT INTO CCN_SALES_LINES_T VALUES rec;
        IF V_COUNT = 1000 THEN
            V_COUNT := 0;
            COMMIT;
        END IF;
    END LOOP;
    COMMIT;
END;