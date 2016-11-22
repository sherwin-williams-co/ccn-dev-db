/**********************************************************
  This script will generate the excel report for 
  all the deposit bagss that were ordered today and send email
  to the SMIS group

created : sxh487 11/21/2016
**********************************************************/
declare
CURSOR dep_tick_cur IS
        SELECT *
          FROM BANK_DEP_BAG_TICKORD BDBTO
         WHERE ORDER_DATE = TRUNC(SYSDATE)
           AND NOT EXISTS (SELECT 1
                             FROM ERROR_LOG EL
                            WHERE MODULE            = 'DPST_BAGS_UPDATE_BATCH_PKG.PROCESS'
                              AND TRUNC(ERROR_DATE) = TRUNC(SYSDATE)
                              AND COST_CENTER_CODE  = BDBTO.COST_CENTER_CODE);
        
V_CLOB     CLOB;    
BEGIN
   --Building the header
   V_CLOB := 'BANK_ACCOUNT_NBR,COST_CENTER_CODE,DEPOSIT_BAG_ORDER_PRIORITY,DEPOSIT_BAG_ORDER_STATUS,DEPOSIT_BAG_ORDER_SEQ_NBR,EFFECTIVE_DATE,EXPIRATION_DATE,LAST_MAINTENANCE_DATE,LAST_MAINT_USER_ID,ORDER_DATE,EXTRACTED_USER_ID '||  UTL_TCP.crlf;

   FOR REC IN dep_tick_cur LOOP        
            V_CLOB := V_CLOB 
                      ||REC.BANK_ACCOUNT_NBR ||',' || CHR(9)
                      ||REC.COST_CENTER_CODE ||',' || CHR(9)
                      ||REC.DEPOSIT_BAG_ORDER_PRIORITY ||','      
                      ||REC.DEPOSIT_BAG_ORDER_STATUS ||','  
                      ||REC.DEPOSIT_BAG_ORDER_SEQ_NBR ||','     
                      ||REC.EFFECTIVE_DATE ||','        
                      ||REC.EXPIRATION_DATE ||','         
                      ||REC.LAST_MAINTENANCE_DATE ||','         
                      ||REC.LAST_MAINT_USER_ID ||',' || CHR(9)  
                      ||REC.ORDER_DATE ||','      
                      ||REC.EXTRACTED_USER_ID || CHR(9)|| CHR(10); 
        END LOOP;
    IF V_CLOB <> EMPTY_CLOB() THEN
       MAIL_PKG.SEND_MAIL('DEP_BAG_TICKORD_EXC_RPT', NULL, NULL, V_CLOB);
    END IF;

EXCEPTION
  WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('FAILED ' || SQLCODE || ' ' || substr(SQLERRM,1,500));
      :exitCode := 2;
END;
/