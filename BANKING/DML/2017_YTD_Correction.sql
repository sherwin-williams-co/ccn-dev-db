/*
This script will clean up teh YTD values for ticket/bag orders

Created : jxc517/nxk927 CCN Project Team....
Updated : nxk927 CCN Project Team....
          looping only once for the orders placed
*/
DECLARE
    V_DATE      DATE := '01-JAN-2017';
    V_YTD_VAL   NUMBER;
    V_EFFECT_DT DATE;
BEGIN
    FOR rec IN (SELECT * FROM BANK_DEP_TICK) LOOP
        V_YTD_VAL   := rec.YTD_DEP_TKTS_ORDERED_QTY;
        V_EFFECT_DT := rec.EFFECTIVE_DATE;
        
        rec.YTD_DEP_TKTS_ORDERED_QTY := 0;
        FOR rec1 IN (SELECT * FROM BANK_DEP_TICKORD WHERE COST_CENTER_CODE = rec.COST_CENTER_CODE AND ORDER_DATE >= '01-JAN-2017') LOOP
            rec.YTD_DEP_TKTS_ORDERED_QTY := rec.NBR_DEP_TICKETS_PER_BK * rec.REORDER_NUMBER_BKS;
        END LOOP;
        rec.EFFECTIVE_DATE  := LEAST(NVL(rec.EXPIRATION_DATE, V_DATE), V_DATE);
        TABLE_IU_PKG.BANK_DEP_TICK_I_SP(rec);
        
        rec.YTD_DEP_TKTS_ORDERED_QTY := V_YTD_VAL - rec.YTD_DEP_TKTS_ORDERED_QTY;
        rec.EFFECTIVE_DATE           := V_EFFECT_DT;
        rec.EXPIRATION_DATE          := NVL(rec.EXPIRATION_DATE, V_EFFECT_DT);
        TABLE_IU_PKG.BANK_DEP_TICK_HIST_I_SP(rec);
        COMMIT;
    END LOOP;
    FOR rec IN (SELECT * FROM BANK_DEP_BAG_TICK) LOOP
        V_YTD_VAL   := rec.DEPBAG_YTD_ORDERED_QTY;
        V_EFFECT_DT := rec.EFFECTIVE_DATE;
        
        rec.DEPBAG_YTD_ORDERED_QTY := 0;
        FOR rec1 IN (SELECT * FROM BANK_DEP_BAG_TICKORD WHERE COST_CENTER_CODE = rec.COST_CENTER_CODE AND ORDER_DATE >= '01-JAN-2017') LOOP
            rec.DEPBAG_YTD_ORDERED_QTY := rec.DEPBAG_REORDER_QTY;
        END LOOP;
        rec.EFFECTIVE_DATE  := LEAST(NVL(rec.EXPIRATION_DATE, V_DATE), V_DATE);
        TABLE_IU_PKG.BANK_DEP_BAG_TICK_I_SP(rec);

        rec.DEPBAG_YTD_ORDERED_QTY := V_YTD_VAL - rec.DEPBAG_YTD_ORDERED_QTY;
        rec.EFFECTIVE_DATE         := V_EFFECT_DT;
        rec.EXPIRATION_DATE        := NVL(rec.EXPIRATION_DATE, V_EFFECT_DT);
        TABLE_IU_PKG.BANK_DEP_BAG_TICK_HIST_I_SP(rec);
        COMMIT;
    END LOOP;
END;
/
