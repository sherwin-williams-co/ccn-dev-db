/*******************************************************************************
This script will insert data from customer_deposit_details table into CUSTOMER_DEPOSIT_TRANSACTION_DTL table
CREATED : 02/12/2019 pxa852 CCN Project...
*******************************************************************************/
INSERT INTO CUSTOMER_DEPOSIT_TRANSACTION_DTL
(SELECT CUST_DEP_DETAIL_ID.NEXTVAL,
        COST_CENTER_CODE,
        TRANSACTION_DATE,
        TERMINAL_NUMBER,
        TRANSACTION_NUMBER,
        TRANSACTION_GUID,
        CUSTOMER_ACCOUNT_NUMBER,
        POS_TRANSACTION_CODE,
        TRAN_TIMESTAMP,
        TRANSACTION_TYPE,
        CSTMR_DPST_SALES_LN_ITM_AMT,
        CUSTOMER_NET_BALANCE,
        NULL DEPOSIT_REMAINING_BAL,
        D.CLOSED_DATE,
        D.REFERENCE_NUMBER,
        D.CLEARED_REASON,
        D.NOTES,
        NULL ORGNL_DEPOSIT_TERMINAL_NBR,
        NULL ORGNL_DEPOSIT_TRANSACTION_NBR,
        NULL ORGNL_DEPOSIT_TRANSACTION_DATE,
        D.LOAD_DATE ,
        D.RLS_RUN_CYCLE,
        D.ADJUSTED_DATE,
        D.GL_DIVISION
   FROM CUSTOMER_DEPOSIT_DETAILS D);

COMMIT;