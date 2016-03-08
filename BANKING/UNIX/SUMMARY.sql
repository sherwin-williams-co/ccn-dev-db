DECLARE
    sq NUMBER;
    se VARCHAR2(1000);
	V_LOAD_DATE   DATE:= &1;
CURSOR SUM_CUR IS
   SELECT COST_CENTER_CODE,
          CENTURY,
          BANK_DEP_AMT,
          FILLER,
          BANK_ACCOUNT_NBR,
          TO_DATE(MONTH||'-'||DAY||'-'||YEAR, 'MM-DD-RRRR') TRANSACTION_DATE,
          V_LOAD_DATE LOAD_DATE
     FROM TEMP_SUMMARY_EXTRCT_CNTRL_FL SM
     ---This is done to avoid loading duplicates. We don't want to insert same record again if they sent it next day.
     ---Usually they are sending the same data with the new data for a certain time
     ---this should not be sent
    WHERE NOT EXISTS (SELECT 1
                        FROM SUMMARY_EXTRCT_CNTRL_FL
                       WHERE COST_CENTER_CODE = SM.COST_CENTER_CODE
                         AND CENTURY          = SM.CENTURY
                         AND BANK_DEP_AMT     = SM.BANK_DEP_AMT
                         AND BANK_ACCOUNT_NBR = SM.BANK_ACCOUNT_NBR
                         AND TRANSACTION_DATE = TO_DATE(MONTH||'-'||DAY||'-'||YEAR, 'MM-DD-RRRR'));
    V_COUNT NUMBER := 0;
	V_TCOUNT NUMBER := 0;
BEGIN
    FOR REC IN SUM_CUR LOOP
        INSERT INTO SUMMARY_EXTRCT_CNTRL_FL VALUES REC;
        V_COUNT := V_COUNT +1;
		V_TCOUNT := V_TCOUNT+1;
        IF V_COUNT = 1000 then
            COMMIT;
            V_COUNT := 0;
        END IF;
    END LOOP;
    COMMIT;
	DBMS_OUTPUT.PUT_LINE('Total rows inserted SUMMARY_EXTRCT_CNTRL_FL ' || V_TCOUNT);
EXCEPTION
    WHEN OTHERS THEN
	sq := SQLCODE;
	se := SQLERRM;

	DBMS_OUTPUT.PUT_LINE('FAILED ' || sq || ' ' || se);
	
END;
/