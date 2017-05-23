/*
Created  : dxv848 
Modified : nxk927 04/26/2016 inserting into UAR_JV_EXTRCT_CNTRL_FL table instead of JV_EXTRCT_CNTRL_FL
*/
DECLARE 
    V_LOAD_DATE   DATE:= &1;
    CURSOR JV_CUR IS
        SELECT BANK_ACCOUNT_NBR,
               COST_CENTER_CODE,
               CENTURY,
               TRAN_SEQNUM,
               TCODE,
               AMOUNT,
               JV_TYPE,
               CFA_SIGN,
               REFEED_TCODE,
               DR_DIV,
               DR_PRIME,
               DR_SUB,
               DR_CC,
               DR_PROJ,
               DR_OFFSET_CDE,
               CR_DIV,
               CR_PRIME,
               CR_SUB,
               CR_CC,
               CR_PROJ,
               CR_OFFSET_CDE,
               FILLER,
               TO_DATE(MONTH||'-'||DAY||'-'||YEAR, 'MM-DD-RRRR') TRANSACTION_DATE,
               V_LOAD_DATE LOAD_DATE  
          FROM TEMP_JV_EXTRCT_CNTRL_FL JV
          ---This is done to avoid loading duplicates. We don't want to insert same record again if they sent it next day.
          ---Usually they are sending the same data with the new data for a certain time
          ---this should not be sent
         WHERE NOT EXISTS (SELECT 1
                             FROM UAR_JV_EXTRCT_CNTRL_FL
                            WHERE BANK_ACCOUNT_NBR     = JV.BANK_ACCOUNT_NBR
                              AND COST_CENTER_CODE     = JV.COST_CENTER_CODE
                              AND TRAN_SEQNUM          = JV.TRAN_SEQNUM
                              AND NVL(TCODE, 'XXX')    = NVL(JV.TCODE,'XXX')
                              AND AMOUNT               = JV.AMOUNT
                              AND TRANSACTION_DATE     = TO_DATE(MONTH||'-'||DAY||'-'||YEAR, 'MM-DD-RRRR')
                              AND NVL(REFEED_TCODE,'X')= NVL(JV.REFEED_TCODE,'X'));
        V_COUNT NUMBER := 0;
        V_TCOUNT NUMBER := 0;
BEGIN
    FOR REC IN JV_CUR LOOP
        INSERT INTO UAR_JV_EXTRCT_CNTRL_FL VALUES REC;
        V_COUNT := V_COUNT +1;
        V_TCOUNT := V_TCOUNT+1;
        IF V_COUNT = 1000 THEN
            COMMIT;
            V_COUNT := 0;
        END IF;
    END LOOP;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Total rows inserted UAR_JV_EXTRCT_CNTRL_FL ' || V_TCOUNT);	
EXCEPTION
    WHEN OTHERS THEN
	DBMS_OUTPUT.PUT_LINE('FAILED ' || SQLCODE || ' ' || SQLERRM);
	
END;
