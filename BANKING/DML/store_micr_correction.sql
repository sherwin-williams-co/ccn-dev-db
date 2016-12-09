/*
created : 12/06/2016 jxc517 CCN Project Team....
          correcting store MICR details
*/

ALTER TRIGGER TR_STORE_MICR_FORMAT_DTLS_UPD DISABLE;

SET SERVEROUTPUT ON;
DECLARE
    V_MICR_FORMAT_ID NUMBER;
BEGIN
    FOR rec IN (SELECT COST_CENTER_CODE, LEAD_BANK_ACCOUNT_NBR, EFFECTIVE_DATE
                  FROM (SELECT MBC.LEAD_STORE_NBR,
                               MBC.MEMBER_STORE_NBR,
                               NVL(MBC.LEAD_BANK_ACCOUNT_NBR, BDT.BANK_ACCOUNT_NBR) AS LEAD_BANK_ACCOUNT_NBR,
                               BDT.*
                          FROM BANK_DEP_TICK BDT,
                               MEMBER_BANK_CC MBC
                         WHERE BDT.COST_CENTER_CODE = MBC.MEMBER_STORE_NBR(+)
                           AND COST_CENTER_CODE NOT IN (SELECT COST_CENTER_CODE FROM STORE_MICR_FORMAT_DTLS)
                        ) A
                  WHERE (LEAD_STORE_NBR NOT IN (SELECT COST_CENTER_CODE FROM STORE_MICR_FORMAT_DTLS) OR LEAD_STORE_NBR IS NULL)
                    AND BUSINESS_RULES_PKG.IS_PLACING_DPT_TKT_BAG_ORD_OK(COST_CENTER_CODE) = 'Y'
                    AND NVL(REORDER_SWITCH, 'X') <> 'L') LOOP
        V_MICR_FORMAT_ID := NULL;
        FOR rec1 IN (SELECT * FROM BANK_DEP_TICK_T WHERE COST_CENTER_CODE = rec.COST_CENTER_CODE) LOOP
            V_MICR_FORMAT_ID := BANKING_COMMON_TOOLS.GET_MICR_FRMT_ID_FR_BA_FRMT_NM(rec.LEAD_BANK_ACCOUNT_NBR,
                                                                                    rec1.FORMAT_NAME,
                                                                                    NULL);
            IF V_MICR_FORMAT_ID IS NOT NULL THEN
                INSERT INTO STORE_MICR_FORMAT_DTLS VALUES(
                      rec.LEAD_BANK_ACCOUNT_NBR,
                      V_MICR_FORMAT_ID,
                      rec.COST_CENTER_CODE,
                      rec1.MICR_COST_CNTR,
                      rec1.MICR_ROUTING_NBR,
                      rec1.MICR_FORMAT_ACCT_NBR,
                      rec.EFFECTIVE_DATE,
                      NULL
                      );
            END IF;
        END LOOP;
    END LOOP;
END;
/

COMMIT;
ALTER TRIGGER TR_STORE_MICR_FORMAT_DTLS_UPD ENABLE;
