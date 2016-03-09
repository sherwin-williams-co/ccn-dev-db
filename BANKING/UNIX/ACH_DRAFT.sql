DECLARE
    V_LOAD_DATE   DATE:= &1;
    CURSOR ACH_INS_CUR IS
        SELECT TACH.COST_CENTER_CODE,
               TACH.CENTURY,
               TACH.BANK_DEP_AMT,
               TACH.BANK_ACCOUNT_NBR,
               TACH.BANK_AUTO_REC_IND,
               TO_DATE(MONTH||'-'||DAY||'-'||YEAR, 'MM-DD-RRRR') TRANSACTION_DATE,
               V_LOAD_DATE LOAD_DATE
          FROM TEMP_ACH_DRFTS_EXTRCT_CNTRL_FL TACH
          ---This is done to avoid loading duplicates. We don't want to insert same record again if they sent it next day.
          ---Usually they are sending the same data with the new data for a certain time
          ---this should not be sent
         WHERE NOT EXISTS  (SELECT 1
                             FROM ACH_DRFTS_EXTRCT_CNTRL_FL ACH
                            WHERE ACH.COST_CENTER_CODE          = TACH.COST_CENTER_CODE
                              AND ACH.CENTURY                   = TACH.CENTURY
                              AND ACH.TRANSACTION_DATE          = TO_DATE(MONTH||'-'||DAY||'-'||YEAR, 'MM-DD-RRRR')
                              AND ACH.BANK_DEP_AMT              = TACH.BANK_DEP_AMT
                              AND ACH.BANK_ACCOUNT_NBR          = TACH.BANK_ACCOUNT_NBR
                              AND NVL(ACH.BANK_AUTO_REC_IND,'X')= NVL(TACH.BANK_AUTO_REC_IND,'X'));
        V_COUNT NUMBER := 0;
        V_TCOUNT NUMBER :=0;
BEGIN
    FOR REC IN ACH_INS_CUR LOOP
        INSERT INTO ACH_DRFTS_EXTRCT_CNTRL_FL VALUES REC;
        V_COUNT := V_COUNT +1;
        V_TCOUNT := V_TCOUNT+1;
        IF V_COUNT = 1000 then
            COMMIT;
            V_COUNT := 0;
        END IF;
    END LOOP;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Total rows inserted ACH_DRFTS_EXTRCT_CNTRL_FL ' || V_TCOUNT);	
EXCEPTION
    WHEN OTHERS THEN
	DBMS_OUTPUT.PUT_LINE('FAILED ' || SQLCODE || ' ' || SQLERRM);
END;
/