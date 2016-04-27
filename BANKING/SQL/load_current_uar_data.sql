/*
Created  : nxk927 04/26/2016 inserting current and previous day data in SUMMARY_EXTRCT_CNTRL_FL table
           and current day data in  JV_EXTRCT_CNTRL_FL and ACH_DRFTS_EXTRCT_CNTRL_FL.
		   We need previous day data for summary as we are back dating 1 day for summary
Modified : 
*/
DECLARE
    V_COUNT NUMBER := 0;
BEGIN
    FOR REC IN (SELECT * 
	              FROM UAR_SUMMARY_EXTRCT_CNTRL_FL 
	             WHERE LOAD_DATE >= (SELECT MAX(LOAD_DATE)
                                       FROM SUMMARY_EXTRCT_CNTRL_FL
                                      WHERE LOAD_DATE < TRUNC(SYSDATE))) LOOP
	    BEGIN
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
END;
/