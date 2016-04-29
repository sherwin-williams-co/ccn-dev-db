/*
Created  : nxk927 04/26/2016 inserting current and previous day data in SUMMARY_EXTRCT_CNTRL_FL table
           and current day data in  JV_EXTRCT_CNTRL_FL and ACH_DRFTS_EXTRCT_CNTRL_FL.
           We need previous day data for summary as we are back dating 1 day for summary
Modified : 
*/
DECLARE
    V_COUNT NUMBER := 0;
    V_LEAD_BANK_CC_REC LEAD_BANK_CC%ROWTYPE;

PROCEDURE GET_LEAD_BANK_RECORD(
/******************************************************************************
This procedure gets the lead bank record for the cost center passed in

Created : 06/22/2015 jxc517 CCN Project....
Changed : Parameter IN_COST_CENTER_CODE should be passed as 4 characters. If 6 characters
          use substr(cc,3)
*******************************************************************************/
IN_COST_CENTER_CODE       IN     VARCHAR2,
OUT_LEAD_BANK_RECORD         OUT LEAD_BANK_CC%ROWTYPE)
IS
BEGIN
    --(assuming its a member)Get the lead for the passed cost center
    BEGIN
        SELECT LEAD_STORE_NBR
          INTO OUT_LEAD_BANK_RECORD.LEAD_STORE_NBR
          FROM MEMBER_BANK_CC
         WHERE SUBSTR(MEMBER_STORE_NBR,3) = IN_COST_CENTER_CODE
           AND ROWNUM < 2;
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;
    --get the lead details(if its not member NVL makes the passed cost center the lead)
    BEGIN
        SELECT *
          INTO OUT_LEAD_BANK_RECORD
          FROM LEAD_BANK_CC
         WHERE SUBSTR(LEAD_STORE_NBR,3) = NVL(SUBSTR(OUT_LEAD_BANK_RECORD.LEAD_STORE_NBR,3), IN_COST_CENTER_CODE);
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;
END GET_LEAD_BANK_RECORD;

BEGIN
    FOR REC IN (SELECT * 
                  FROM UAR_SUMMARY_EXTRCT_CNTRL_FL
                 WHERE LOAD_DATE >= (SELECT MAX(LOAD_DATE)
                                       FROM UAR_SUMMARY_EXTRCT_CNTRL_FL
                                      WHERE LOAD_DATE < TRUNC(SYSDATE))) LOOP
        BEGIN
            GET_LEAD_BANK_RECORD(rec.COST_CENTER_CODE,
                                 V_LEAD_BANK_CC_REC);
            REC.BANK_ACCOUNT_NBR := LPAD(NVL(REPLACE(V_LEAD_BANK_CC_REC.LEAD_BANK_ACCOUNT_NBR,'-'),0), 17, 0);
            INSERT INTO SUMMARY_EXTRCT_CNTRL_FL VALUES REC;
            IF V_COUNT > 100 THEN
               COMMIT;
               V_COUNT := 0;
            END IF;
            V_COUNT  := V_COUNT + 1;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('error for cost center ' || REC.COST_CENTER_CODE ||' while inserting in SUMMARY_EXTRCT_CNTRL_FL '|| substr(SQLERRM,1,500));
        END;
    END LOOP;
    COMMIT;

    V_COUNT := 0;
    FOR REC1 IN (SELECT * 
                   FROM UAR_JV_EXTRCT_CNTRL_FL 
                  WHERE LOAD_DATE = TRUNC(SYSDATE)) LOOP
        BEGIN
            GET_LEAD_BANK_RECORD(rec1.COST_CENTER_CODE,
                                 V_LEAD_BANK_CC_REC);
            REC1.BANK_ACCOUNT_NBR := LPAD(NVL(REPLACE(V_LEAD_BANK_CC_REC.LEAD_BANK_ACCOUNT_NBR,'-'),0), 17, 0);
            INSERT INTO JV_EXTRCT_CNTRL_FL VALUES REC1;
            IF V_COUNT > 100 THEN
               COMMIT;
               V_COUNT := 0;
            END IF;
            V_COUNT  := V_COUNT + 1;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('error for cost center ' || REC1.COST_CENTER_CODE ||' while inserting in JV_EXTRCT_CNTRL_FL '|| substr(SQLERRM,1,500));
        END;
    END LOOP;
    COMMIT;

    V_COUNT := 0;
    FOR REC2 IN (SELECT * 
                   FROM UAR_ACH_DRFTS_EXTRCT_CNTRL_FL 
                  WHERE LOAD_DATE = TRUNC(SYSDATE)) LOOP
        BEGIN
            GET_LEAD_BANK_RECORD(rec2.COST_CENTER_CODE,
                                 V_LEAD_BANK_CC_REC);
            REC2.BANK_ACCOUNT_NBR := LPAD(NVL(REPLACE(V_LEAD_BANK_CC_REC.LEAD_BANK_ACCOUNT_NBR,'-'),0), 17, 0);
            INSERT INTO ACH_DRFTS_EXTRCT_CNTRL_FL VALUES REC2;
            IF V_COUNT > 100 THEN
               COMMIT;
               V_COUNT := 0;
            END IF;
            V_COUNT  := V_COUNT + 1;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('error for cost center ' || REC2.COST_CENTER_CODE ||' while inserting in ACH_DRFTS_EXTRCT_CNTRL_FL '|| substr(SQLERRM,1,500));
        END;
    END LOOP;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('FAILED ' || SQLCODE || ' ' || SQLERRM);
    :exitCode := 2;
END;
