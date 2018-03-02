/**********************************************************************************
 This Block is used to copies MERCHANT_ID values to feild MERCH_ID_CAN_MC in BANK_CARD table.
 While copying that field to this new field replace starting "8" with "9".

created :02/09/2018 bxa919 CCN Project..
**********************************************************************************/
DECLARE
 
V_MERCHANT_ID      BANK_CARD.MERCHANT_ID%TYPE;
V_MERCH_ID_CAN_MC  BANK_CARD.MERCHANT_ID%TYPE;

CURSOR CC1 IS
      SELECT COST_CENTER_CODE 
        FROM COST_CENTER 
       WHERE COUNTRY_CODE='CAN';
  
CURSOR CUR_BANK_CARD (P_COST_CENTER_CODE VARCHAR2) IS
      SELECT MERCHANT_ID  
        FROM BANK_CARD
       WHERE COST_CENTER_CODE=P_COST_CENTER_CODE
      ORDER BY MERCHANT_ID DESC;
BEGIN
    FOR REC_CC IN CC1 LOOP       
        FOR REC_BC IN CUR_BANK_CARD (REC_CC.COST_CENTER_CODE)  LOOP
      
                IF SUBSTR(REC_BC.MERCHANT_ID,1,1)='8' THEN 
                    
                    V_MERCHANT_ID :=substr(REC_BC.MERCHANT_ID,2);
                    V_MERCH_ID_CAN_MC :='9'||V_MERCHANT_ID;
         
                    UPDATE BANK_CARD 
                       SET MERCH_ID_CAN_MC = V_MERCH_ID_CAN_MC
                     WHERE COST_CENTER_CODE=REC_CC.COST_CENTER_CODE
                       AND MERCHANT_ID= REC_BC.MERCHANT_ID;  
                END IF;
        END LOOP;
    END LOOP;
      COMMIT;  
END;

