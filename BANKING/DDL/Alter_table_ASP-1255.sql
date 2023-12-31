/*
ASP-1255 This script will modify column COST_CENTER_CODE from 4 to 6 chars.
Created  : 06/13/2019 sxs484 
*/

SET SERVEROUTPUT ON;
DECLARE
    V_CC VARCHAR2(6);
BEGIN
    FOR rec IN (SELECT DISTINCT COST_CENTER_CODE FROM POS_SUMMARY_EXTRCT_CNTRL_FL) LOOP --2575  Rows
        BEGIN
            V_CC := COMMON_TOOLS.COST_CENTER_LOOK_UP_FNC(rec.COST_CENTER_CODE);
            UPDATE POS_SUMMARY_EXTRCT_CNTRL_FL SET COST_CENTER_CODE = V_CC WHERE COST_CENTER_CODE = rec.COST_CENTER_CODE;
            COMMIT;
            V_CC := NULL;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE(SQLCODE ||':'|| SQLERRM);
        END;
    END LOOP;
END;
ALTER TABLE POS_SUMMARY_EXTRCT_CNTRL_FL MODIFY COST_CENTER_CODE	NOT NULL;


SET SERVEROUTPUT ON;
DECLARE
    V_CC VARCHAR2(6);
BEGIN
    FOR rec IN (SELECT DISTINCT COST_CENTER_CODE FROM POS_SUMMARY_EXTRCT_CNTRL_HST) LOOP --2575  Rows
        BEGIN
            V_CC := COMMON_TOOLS.COST_CENTER_LOOK_UP_FNC(rec.COST_CENTER_CODE);
            UPDATE POS_SUMMARY_EXTRCT_CNTRL_HST SET COST_CENTER_CODE = V_CC WHERE COST_CENTER_CODE = rec.COST_CENTER_CODE;
            COMMIT;
            V_CC := NULL;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE(SQLCODE ||':'|| SQLERRM);
        END;
    END LOOP;
END;
ALTER TABLE POS_SUMMARY_EXTRCT_CNTRL_HST MODIFY COST_CENTER_CODE	NOT NULL;


ALTER TABLE POS_INTERIM_DEPST MODIFY COST_CENTER_CODE	VARCHAR2(6);

SET SERVEROUTPUT ON;
DECLARE
    V_CC VARCHAR2(6);
BEGIN
    FOR rec IN (SELECT DISTINCT COST_CENTER_CODE FROM POS_INTERIM_DEPST) LOOP --2575  Rows
        BEGIN
            V_CC := COMMON_TOOLS.COST_CENTER_LOOK_UP_FNC(rec.COST_CENTER_CODE);
            UPDATE POS_INTERIM_DEPST SET COST_CENTER_CODE = V_CC WHERE COST_CENTER_CODE = rec.COST_CENTER_CODE;
            COMMIT;
            V_CC := NULL;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE(SQLCODE ||':'|| SQLERRM);
        END;
    END LOOP;
END;
ALTER TABLE POS_INTERIM_DEPST MODIFY COST_CENTER_CODE	NOT NULL;


ALTER TABLE POS_DPST_TICKET_COUNTS MODIFY COST_CENTER_CODE	VARCHAR2(6);
-- Data Conversion of POS_DPST_TICKET_COUNTS existing 4 digit COST_CENTER_CODE to 6 .
SET SERVEROUTPUT ON;
DECLARE
    V_CC VARCHAR2(6);
BEGIN
    FOR rec IN (SELECT DISTINCT COST_CENTER_CODE FROM POS_DPST_TICKET_COUNTS) LOOP --2575  Rows
        BEGIN
            V_CC := COMMON_TOOLS.COST_CENTER_LOOK_UP_FNC(rec.COST_CENTER_CODE);
            UPDATE POS_DPST_TICKET_COUNTS SET COST_CENTER_CODE = V_CC WHERE COST_CENTER_CODE = rec.COST_CENTER_CODE;
            COMMIT;
            V_CC := NULL;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE(SQLCODE ||':'|| SQLERRM);
        END;
    END LOOP;
END;

ALTER TABLE POS_DPST_TICKET_COUNTS MODIFY COST_CENTER_CODE	NOT NULL;



ALTER TABLE POS_GIFT_CARD_POS_TRANS RENAME COLUMN STORE_NBR TO STORECCN;

-- Data Conversion of existing 4 digit store_no to 6 .
SET SERVEROUTPUT ON;
DECLARE
    V_CC VARCHAR2(6);
BEGIN
    FOR rec IN (SELECT DISTINCT STORECCN FROM POS_GIFT_CARD_POS_TRANS) LOOP --2575  Rows
        BEGIN
            V_CC := COMMON_TOOLS.COST_CENTER_LOOK_UP_FNC(rec.STORECCN);
            UPDATE POS_GIFT_CARD_POS_TRANS SET STORECCN = V_CC WHERE STORECCN = rec.STORECCN;
            COMMIT;
            V_CC := NULL;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE(SQLCODE ||':'|| SQLERRM);
        END;
    END LOOP;
END;







