/*******************************************************************************
This script will insert data from customer_deposit_details table into CUSTOMER_DEPOSIT_TRANSACTION_HDR

CREATED : 02/12/2019 pxa852 CCN Project...
*******************************************************************************/
INSERT INTO CUSTOMER_DEPOSIT_TRANSACTION_HDR
(SELECT DISTINCT COST_CENTER_CODE,
        TERMINAL_NUMBER,
        CUSTOMER_ACCOUNT_NUMBER
   FROM CUSTOMER_DEPOSIT_DETAILS);

COMMIT;