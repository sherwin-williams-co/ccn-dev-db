/*********************************************************************************
This script is to create manual deposit entries to make the customer net balance zero for the records sent by Marissa.
The below accounts are deleted from the file (Deposit Transactions that Need Closed (Negatives).xlsx) sent by Marissa as the customer net balance is zero.
676313521
240186841
250749314
258694066
997922190
591091202

Creating only Manual deposits and remaining balance is set to zero for these manual entries.
As there are no manual redemptions, no updates on originals.

Created : 02/27/2019  pxa852 CCN Project Team...
Changed :
*********************************************************************************/
DECLARE
--variable declaration
   CURSOR TEMP_CUR IS
      SELECT *
        FROM CD_MARISAA_27FEB2019 b;

   --variable declaration
   V_TEMP_ROW       CUSTOMER_DEPOSIT_DETAILS%ROWTYPE;
   V_CREDIT_ROW     CUST_DEP_CREDIT_DETAILS%ROWTYPE;
   V_COMMIT         NUMBER := 0;
   V_CUM_AMT        NUMBER := 0;
   V_LOAD_DATE      DATE := SYSDATE;
   
FUNCTION FNC_GET_LATEST_CUM_AMT(
/**********************************************************
This function will return the net balance remaining
as of the day before the current load

Created : 01/25/2018 sxh487
        : 02/01/2018 sxh487 Changed the default amount to 0
        : 08/22/2018 sxh487 Removed the closed_date condition
          as it is not needed
        : 01/23/2019 sxg151 Added the closed_date condition  
**********************************************************/
IN_CUST_ACCOUNT_NBR IN CUSTOMER_DEPOSIT_DETAILS.CUSTOMER_ACCOUNT_NUMBER%TYPE)
    RETURN NUMBER
IS
  V_CUSTOMER_NET_BALANCE     CUSTOMER_DEPOSIT_DETAILS.CUSTOMER_NET_BALANCE%TYPE := 0;
BEGIN
    SELECT CUSTOMER_NET_BALANCE
      INTO V_CUSTOMER_NET_BALANCE
      FROM CUSTOMER_DEPOSIT_DETAILS
     WHERE CUSTOMER_ACCOUNT_NUMBER = IN_CUST_ACCOUNT_NBR
       AND TRAN_TIMESTAMP = (SELECT MAX(TRAN_TIMESTAMP)
                               FROM CUSTOMER_DEPOSIT_DETAILS
                              WHERE CUSTOMER_ACCOUNT_NUMBER = IN_CUST_ACCOUNT_NBR
                                );

     RETURN V_CUSTOMER_NET_BALANCE;
EXCEPTION
    WHEN OTHERS THEN
          RETURN V_CUSTOMER_NET_BALANCE;
END FNC_GET_LATEST_CUM_AMT;

PROCEDURE CUST_DEPOSIT_CREDIT_I_SP(
/*******************************************************************************
CUST_DEPOSIT_CREDIT_I_SP

This procedure is intended to insert into  CUST_DEP_CREDIT_DETAILS
created : 02/27/2018 SXH487 -- ccn project
changed : 01/16/2019 pxa852 CCN Project team...
          Modified code to include the update process when duplicate value on index occurs
*******************************************************************************/
IN_CUST_DEP_CREDIT_rec   IN     CUST_DEP_CREDIT_DETAILS%ROWTYPE
)
IS
BEGIN
   INSERT INTO CUST_DEP_CREDIT_DETAILS VALUES IN_CUST_DEP_CREDIT_rec;
EXCEPTION
    WHEN OTHERS THEN
        ERRPKG.RAISE_ERR(SQLCODE, 'CUST_DEPOSIT_CREDIT_I_SP', SUBSTR(SQLERRM,1,500));
END CUST_DEPOSIT_CREDIT_I_SP;

PROCEDURE CUST_DEP_DET_I_SP(
/*******************************************************************************
CUST_DEP_DET_I_SP

This procedure is intended to insert new customer_deposit_details records
created : 02/27/2018 SXH487 -- ccn project
changed :

*******************************************************************************/
IN_CUST_DEPOSIT_DETAILS_rec   IN     CUSTOMER_DEPOSIT_DETAILS%ROWTYPE)
IS
BEGIN
   INSERT INTO CUSTOMER_DEPOSIT_DETAILS VALUES IN_CUST_DEPOSIT_DETAILS_rec;
EXCEPTION
    WHEN OTHERS THEN
        ERRPKG.RAISE_ERR(SQLCODE, 'CUST_DEP_DET_I_SP', SUBSTR(SQLERRM,1,500));
END CUST_DEP_DET_I_SP;

BEGIN
   FOR REC IN TEMP_CUR LOOP
       BEGIN
            V_TEMP_ROW.CSTMR_DPST_SALES_LN_ITM_AMT :=   REC.CSTMR_DPST_SALES_LN_ITM_AMT;
            V_TEMP_ROW.COST_CENTER_CODE            :=   REC.COST_CENTER_CODE;
            V_TEMP_ROW.TRANSACTION_DATE            :=   TRUNC(SYSDATE);
            V_TEMP_ROW.TERMINAL_NUMBER             :=   '99999';
            V_TEMP_ROW.TRANSACTION_NUMBER          :=   '99999';
            V_TEMP_ROW.CUSTOMER_ACCOUNT_NUMBER     :=   REC.CUSTOMER_ACCOUNT_NUMBER;
            V_TEMP_ROW.TRAN_TIMESTAMP              :=   SYSTIMESTAMP;
            V_TEMP_ROW.TRANSACTION_TYPE            :=   'MANUAL';
            V_CUM_AMT                              :=   FNC_GET_LATEST_CUM_AMT(REC.CUSTOMER_ACCOUNT_NUMBER)  + V_TEMP_ROW.CSTMR_DPST_SALES_LN_ITM_AMT;
            V_TEMP_ROW.CUSTOMER_NET_BALANCE        :=   V_CUM_AMT;
            V_TEMP_ROW.LOAD_DATE                   :=   V_LOAD_DATE;
            V_TEMP_ROW.NOTES                       :=   REC.NOTES;

            CUST_DEP_DET_I_SP(V_TEMP_ROW);
         
            V_CREDIT_ROW.CREDIT_ID                := SEQ_CREDIT_ID.nextval;
            V_CREDIT_ROW.COST_CENTER_CODE         := V_TEMP_ROW.COST_CENTER_CODE;
            V_CREDIT_ROW.CUSTOMER_ACCOUNT_NUMBER  := V_TEMP_ROW.CUSTOMER_ACCOUNT_NUMBER;
            V_CREDIT_ROW.TRANSACTION_NUMBER       := V_TEMP_ROW.TRANSACTION_NUMBER;
            V_CREDIT_ROW.TRANSACTION_DATE         := V_TEMP_ROW.TRANSACTION_DATE;
            V_CREDIT_ROW.TERMINAL_NUMBER          := V_TEMP_ROW.TERMINAL_NUMBER;
            V_CREDIT_ROW.DEPOSIT_REMAINING_BAL    := 0;
            V_CREDIT_ROW.TRAN_TIMESTAMP           := V_TEMP_ROW.TRAN_TIMESTAMP;
            V_CREDIT_ROW.LOAD_DATE                := V_LOAD_DATE;

            CUST_DEPOSIT_CREDIT_I_SP(V_CREDIT_ROW);

         V_TEMP_ROW := NULL;
         V_COMMIT := V_COMMIT + 1;
         IF V_COMMIT > 500 THEN
            COMMIT;
            V_COMMIT := 0;
         END IF;
      EXCEPTION
         WHEN OTHERS THEN
              ERRPKG.INSERT_ERROR_LOG_SP( SQLCODE, 'Manual Correction - ' || TRUNC(SYSDATE), SQLERRM, '000000', '000000000', '000000000');
      END;
   END LOOP;
   COMMIT;

EXCEPTION
   WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP( SQLCODE, 'Manual Correction - ' || TRUNC(SYSDATE), SQLERRM, '000000', '000000000', '000000000');
END;