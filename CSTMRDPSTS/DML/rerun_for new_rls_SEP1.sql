--Rerun for the Accounts as the process for updating pre-post live data was still running
--sxh487 09/01/2018
--select distinct customer_account_number FROM CUSTOMER_DEPOSIT_DETAILS WHERE rls_run_cycle in('1665,'1666') and customer_account_number IN
--(select acctnbr from PNP.pre_go_live_headers where rls_run_cycle =0);

DELETE FROM CUST_DEP_REDEMPTION_DETAILS WHERE customer_account_number IN
('1',
'100901958',
'220025142',
'230729402',
'290123678',
'296210925',
'301180717',
'303152037',
'320317449',
'320390859',
'335766903',
'357187723',
'421914219',
'422426882',
'423590934',
'425442951',
'518396056',
'521336719',
'528160641',
'536915796',
'564420040',
'569538630',
'569998065',
'656052818',
'656113404',
'666774260',
'666890223',
'670217108',
'672267358',
'672330438',
'675699151',
'675714463',
'676983190',
'676987605',
'915709257');

DELETE FROM CUST_DEP_CREDIT_DETAILS WHERE customer_account_number IN
('1',
'100901958',
'220025142',
'230729402',
'290123678',
'296210925',
'301180717',
'303152037',
'320317449',
'320390859',
'335766903',
'357187723',
'421914219',
'422426882',
'423590934',
'425442951',
'518396056',
'521336719',
'528160641',
'536915796',
'564420040',
'569538630',
'569998065',
'656052818',
'656113404',
'666774260',
'666890223',
'670217108',
'672267358',
'672330438',
'675699151',
'675714463',
'676983190',
'676987605',
'915709257');

DELETE FROM CUSTOMER_DEPOSIT_DETAILS WHERE customer_account_number IN
('1',
'100901958',
'220025142',
'230729402',
'290123678',
'296210925',
'301180717',
'303152037',
'320317449',
'320390859',
'335766903',
'357187723',
'421914219',
'422426882',
'423590934',
'425442951',
'518396056',
'521336719',
'528160641',
'536915796',
'564420040',
'569538630',
'569998065',
'656052818',
'656113404',
'666774260',
'666890223',
'670217108',
'672267358',
'672330438',
'675699151',
'675714463',
'676983190',
'676987605',
'915709257');

DELETE FROM CUSTOMER_DEPOSIT_HEADER WHERE customer_account_number IN
('1',
'100901958',
'220025142',
'230729402',
'290123678',
'296210925',
'301180717',
'303152037',
'320317449',
'320390859',
'335766903',
'357187723',
'421914219',
'422426882',
'423590934',
'425442951',
'518396056',
'521336719',
'528160641',
'536915796',
'564420040',
'569538630',
'569998065',
'656052818',
'656113404',
'666774260',
'666890223',
'670217108',
'672267358',
'672330438',
'675699151',
'675714463',
'676983190',
'676987605',
'915709257');

COMMIT;


/*
block to rerun only accounts that have rls_run_cycle =0
sxh487 08/30/2018
*/

DECLARE

CURSOR ALL_ACCNTS IS
    select DISTINCT ACCTNBR, RLS_RUN_CYCLE  
      FROM CCN_HEADERS_T
     WHERE ACCTNBR IN
 ('1',
'100901958',
'220025142',
'230729402',
'290123678',
'296210925',
'301180717',
'303152037',
'320317449',
'320390859',
'335766903',
'357187723',
'421914219',
'422426882',
'423590934',
'425442951',
'518396056',
'521336719',
'528160641',
'536915796',
'564420040',
'569538630',
'569998065',
'656052818',
'656113404',
'666774260',
'666890223',
'670217108',
'672267358',
'672330438',
'675699151',
'675714463',
'676983190',
'676987605',
'915709257')
ORDER BY ACCTNBR, RLS_RUN_CYCLE;

PROCEDURE LOAD_CUST_DEP_HDR_0_SP(
/*****************************************************************************
LOAD_CUST_DEP_HDR_0_SP

This procedure will load the customer_deposit_header table from pnp legacy idms database.

created : 08/30/2018 sxh487 ccn project....
******************************************************************************/
IN_RLS_RUN_CYCLE POS_CSTMR_DEP_LOAD_STATUS.RLS_RUN_CYCLE%TYPE,
IN_ACCTNBR       CCN_HEADERS_T.ACCTNBR%TYPE)
IS

--variable declaration
V_DATE                       DATE := TRUNC(SYSDATE);

   CURSOR TEMP_CUR IS
      SELECT DISTINCT 
             ACCTNBR AS CUSTOMER_ACCOUNT_NUMBER,
             CUSTOMER_NAME,
             BILLNM,
             BILLCONTACT,
             BILLADDR1,
             BILLADDR2,
             BILLCITY,
             BILLZIP,
             BILLPHONE,
             RLS_RUN_CYCLE
        FROM CCN_HEADERS_T H
       WHERE H.RLS_RUN_CYCLE = IN_RLS_RUN_CYCLE
         AND ACCTNBR =IN_ACCTNBR
         AND EXISTS (SELECT 1
                       FROM CCN_SALES_LINES_T S
                      WHERE H.TRAN_GUID = S.TRAN_GUID
                        AND S.NON_MERCH_CODE = COMMON_TOOLS.G_NON_MERCH_CODE);

   --variable declaration
   V_COMMIT         NUMBER := 0;
   V_TEMP_ROW       CUSTOMER_DEPOSIT_HEADER%ROWTYPE;
   V_HDR_REC        CUSTOMER_DEPOSIT_HEADER%ROWTYPE;
BEGIN
   FOR REC IN TEMP_CUR LOOP
        V_TEMP_ROW.CUSTOMER_ACCOUNT_NUMBER  := REC.CUSTOMER_ACCOUNT_NUMBER;
        V_TEMP_ROW.CUSTOMER_NAME            := REC.CUSTOMER_NAME; 
        V_TEMP_ROW.BILLCONTACT              := REC.BILLCONTACT;
        V_TEMP_ROW.BILLNM                   := REC.BILLNM;
        V_TEMP_ROW.BILLADDR1                := REC.BILLADDR1;
        V_TEMP_ROW.BILLADDR2                := REC.BILLADDR2;
        V_TEMP_ROW.BILLCITY                 := REC.BILLCITY;
        V_TEMP_ROW.BILLZIP                  := REC.BILLZIP;
        V_TEMP_ROW.BILLPHONE                := REC.BILLPHONE;
        V_TEMP_ROW.RLS_RUN_CYCLE            := REC.RLS_RUN_CYCLE;
        V_TEMP_ROW.LOAD_DATE                := V_DATE;
        
        TABLE_IU_PKG.CUST_DEPOSIT_HEADER_I_SP(V_TEMP_ROW);    
        V_TEMP_ROW := NULL;
        V_COMMIT := V_COMMIT + 1;
        IF V_COMMIT > 500 THEN
           COMMIT;
           V_COMMIT := 0;
        END IF;
   END LOOP;
   COMMIT;

EXCEPTION
   WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP( SQLCODE,
                                    'LOAD_CUST_DEP_HDR_0_SP',
                                    SQLERRM,
                                    '000000',
                                    '000000000',
                                    '000000000');
END LOAD_CUST_DEP_HDR_0_SP;

PROCEDURE LOAD_CUST_DEP_DTLS_0_SP
(
IN_RLS_RUN_CYCLE NUMBER,
IN_ACCTNBR       CCN_HEADERS_T.ACCTNBR%TYPE)
IS
--variable declaration
   CURSOR TEMP_CUR IS
      SELECT STORE_NO  AS COST_CENTER_CODE,
             TRAN_DATE AS TRANSACTION_DATE,
             TERMNBR   AS TERMINAL_NUMBER,
             TRANNBR   AS TRANSACTION_NUMBER,
             TRAN_GUID AS TRANSACTION_GUID,
             ACCTNBR   AS CUSTOMER_ACCOUNT_NUMBER,
             TRANID    AS POS_TRANSACTION_CODE,
             TRAN_TIMESTAMP,
             RLS_RUN_CYCLE,
             ROW_NUMBER() OVER (PARTITION BY ACCTNBR ORDER BY  TRAN_TIMESTAMP, TERMNBR) AS RNUM
        FROM CCN_HEADERS_T H
       WHERE H.RLS_RUN_CYCLE = IN_RLS_RUN_CYCLE
         AND ACCTNBR  =IN_ACCTNBR 
         AND EXISTS (SELECT 1
                       FROM CCN_SALES_LINES_T S
                      WHERE H.TRAN_GUID = S.TRAN_GUID
                        AND S.NON_MERCH_CODE = COMMON_TOOLS.G_NON_MERCH_CODE);
       
   --variable declaration
   V_TEMP_ROW       CUSTOMER_DEPOSIT_DETAILS%ROWTYPE;
   V_CREDIT_ROW     CUST_DEP_CREDIT_DETAILS%ROWTYPE;
   V_REDEMPTION_ROW CUST_DEP_REDEMPTION_DETAILS%ROWTYPE;
   V_COMMIT         NUMBER := 0;
   V_CUM_AMT        NUMBER := 0;
   V_ORIG_DEP_NBR   CUSTOMER_DEPOSIT_DETAILS.TRANSACTION_NUMBER%TYPE;
   V_ORIG_TERM_NBR  CUSTOMER_DEPOSIT_DETAILS.TERMINAL_NUMBER%TYPE;
   V_ORIG_TRAN_DATE CUSTOMER_DEPOSIT_DETAILS.TRANSACTION_DATE%TYPE;
   V_LOAD_DATE      DATE := SYSDATE;
BEGIN
   FOR REC IN TEMP_CUR LOOP
      BEGIN
         V_TEMP_ROW.CSTMR_DPST_SALES_LN_ITM_AMT :=   COMMON_TOOLS.GET_SALES_LINE_AMOUNT(REC.TRANSACTION_GUID);
         V_TEMP_ROW.COST_CENTER_CODE            :=   COMMON_TOOLS.COST_CENTER_LOOK_UP_FNC(REC.COST_CENTER_CODE);
         V_TEMP_ROW.TRANSACTION_DATE            :=   REC.TRANSACTION_DATE;
         V_TEMP_ROW.TERMINAL_NUMBER             :=   REC.TERMINAL_NUMBER;
         V_TEMP_ROW.TRANSACTION_NUMBER          :=   REC.TRANSACTION_NUMBER;
         V_TEMP_ROW.TRANSACTION_GUID            :=   REC.TRANSACTION_GUID;
         V_TEMP_ROW.CUSTOMER_ACCOUNT_NUMBER     :=   REC.CUSTOMER_ACCOUNT_NUMBER;
         V_TEMP_ROW.POS_TRANSACTION_CODE        :=   REC.POS_TRANSACTION_CODE;
         V_TEMP_ROW.TRAN_TIMESTAMP              :=   REC.TRAN_TIMESTAMP;
         V_TEMP_ROW.TRANSACTION_TYPE            :=   CASE WHEN V_TEMP_ROW.CSTMR_DPST_SALES_LN_ITM_AMT > 0 THEN 
                                                            'DEPOSIT'
                                                       WHEN V_TEMP_ROW.CSTMR_DPST_SALES_LN_ITM_AMT < 0 THEN 
                                                            'REDEMPTION'
                                                       ELSE 'NA'
                                                  END;
         V_CUM_AMT                             :=  (CASE WHEN REC.RNUM = 1 THEN
                                                       COMMON_TOOLS.FNC_GET_LATEST_CUM_AMT(REC.CUSTOMER_ACCOUNT_NUMBER)
                                                    ELSE
                                                        V_CUM_AMT
                                                    END)  + V_TEMP_ROW.CSTMR_DPST_SALES_LN_ITM_AMT;
         V_TEMP_ROW.CUSTOMER_NET_BALANCE        :=  V_CUM_AMT;
         V_TEMP_ROW.GL_DIVISION                 :=  COMMON_TOOLS.GET_GL_DIVISION(V_TEMP_ROW.COST_CENTER_CODE);
         V_TEMP_ROW.RLS_RUN_CYCLE               :=  REC.RLS_RUN_CYCLE;
         V_TEMP_ROW.LOAD_DATE                   :=  V_LOAD_DATE;

         TABLE_IU_PKG.CUST_DEP_DET_I_SP(V_TEMP_ROW);
         IF V_TEMP_ROW.TRANSACTION_TYPE = 'DEPOSIT' THEN
            V_CREDIT_ROW.CREDIT_ID                := SEQ_CREDIT_ID.nextval;
            V_CREDIT_ROW.COST_CENTER_CODE         := V_TEMP_ROW.COST_CENTER_CODE;
            V_CREDIT_ROW.CUSTOMER_ACCOUNT_NUMBER  := V_TEMP_ROW.CUSTOMER_ACCOUNT_NUMBER;
            V_CREDIT_ROW.TRANSACTION_NUMBER       := V_TEMP_ROW.TRANSACTION_NUMBER;
            V_CREDIT_ROW.TRANSACTION_DATE         := V_TEMP_ROW.TRANSACTION_DATE;
            V_CREDIT_ROW.TERMINAL_NUMBER          := V_TEMP_ROW.TERMINAL_NUMBER;           
            V_CREDIT_ROW.DEPOSIT_REMAINING_BAL    := V_TEMP_ROW.CSTMR_DPST_SALES_LN_ITM_AMT;
            V_CREDIT_ROW.TRAN_TIMESTAMP           := V_TEMP_ROW.TRAN_TIMESTAMP;
            V_CREDIT_ROW.LOAD_DATE                := V_LOAD_DATE;
            
            TABLE_IU_PKG.CUST_DEPOSIT_CREDIT_I_SP(V_CREDIT_ROW);
         ELSIF V_TEMP_ROW.TRANSACTION_TYPE = 'REDEMPTION' THEN
               CUSTOMER_DEPOSIT_MAINT_PKG.ORIG_DEP_REM_BAL_UPD( V_TEMP_ROW.CSTMR_DPST_SALES_LN_ITM_AMT, REC.CUSTOMER_ACCOUNT_NUMBER, REC.TRANSACTION_DATE, V_ORIG_DEP_NBR, V_ORIG_TERM_NBR, V_ORIG_TRAN_DATE);
               V_REDEMPTION_ROW.REDEMPTION_ID            := SEQ_REDEMPTION_ID.nextval;
               V_REDEMPTION_ROW.COST_CENTER_CODE         := V_TEMP_ROW.COST_CENTER_CODE;
               V_REDEMPTION_ROW.CUSTOMER_ACCOUNT_NUMBER  := V_TEMP_ROW.CUSTOMER_ACCOUNT_NUMBER;
               V_REDEMPTION_ROW.TRANSACTION_NUMBER       := V_TEMP_ROW.TRANSACTION_NUMBER;
               V_REDEMPTION_ROW.TRANSACTION_DATE         := V_TEMP_ROW.TRANSACTION_DATE;
               V_REDEMPTION_ROW.TERMINAL_NUMBER          := V_TEMP_ROW.TERMINAL_NUMBER;           
               V_REDEMPTION_ROW.ORIGINAL_DEP_TRANS_NBR   := V_ORIG_DEP_NBR;  
               V_REDEMPTION_ROW.ORIGINAL_DEP_TERM_NBR    := V_ORIG_TERM_NBR;
               V_REDEMPTION_ROW.ORIGINAL_DEP_TRAN_DATE   := V_ORIG_TRAN_DATE;
               V_REDEMPTION_ROW.TRAN_TIMESTAMP           := V_TEMP_ROW.TRAN_TIMESTAMP;
               V_REDEMPTION_ROW.LOAD_DATE                := V_LOAD_DATE;
               
               TABLE_IU_PKG.CUST_DEPOSIT_REDEMPTION_I_SP(V_REDEMPTION_ROW);
         ELSE
           NULL;
         END IF; 
         
         V_TEMP_ROW := NULL;
         V_COMMIT := V_COMMIT + 1;
         IF V_COMMIT > 500 THEN
            COMMIT;
            V_COMMIT := 0;
         END IF;
      EXCEPTION
         WHEN OTHERS THEN
              ERRPKG.INSERT_ERROR_LOG_SP( SQLCODE,
                                          'LOAD_CUST_DEP_DTLS_0_SP',
                                          SQLERRM,
                                          V_TEMP_ROW.COST_CENTER_CODE,
                                          V_TEMP_ROW.CUSTOMER_ACCOUNT_NUMBER,
                                          'LOAD_CUST_DEP_DTLS_0_SP');
      END;
   END LOOP;
   COMMIT;

EXCEPTION
   WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP( SQLCODE,
                                    'LOAD_CUST_DEP_DTLS_0_SP',
                                    SQLERRM,
                                    '000000',
                                    '000000000',
                                    '000000000');
END LOAD_CUST_DEP_DTLS_0_SP;

BEGIN 
    FOR each_acct IN ALL_ACCNTS LOOP
         LOAD_CUST_DEP_HDR_0_SP( each_acct.RLS_RUN_CYCLE, each_acct.ACCTNBR);
         LOAD_CUST_DEP_DTLS_0_SP(each_acct.RLS_RUN_CYCLE, each_acct.ACCTNBR);
    END LOOP;
END;
/