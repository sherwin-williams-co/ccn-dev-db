/*******************************************************************************
This script is intended to create a CUSTOMER_DEPOSIT_TRANSACTION_HDR table which
holds the distinct cost center code, customer account number and terminal number from
POS.
CREATED : 02/12/2019 pxa852 CCN Project...
*******************************************************************************/
CREATE TABLE CUSTOMER_DEPOSIT_TRANSACTION_HDR
   (COST_CENTER_CODE        VARCHAR2(6) NOT NULL,
    TERMINAL_NUMBER         VARCHAR2(5) NOT NULL,
    CUSTOMER_ACCOUNT_NUMBER VARCHAR2(9) NOT NULL
    CONSTRAINT CD_H_PK PRIMARY KEY (COST_CENTER_CODE, TERMINAL_NUMBER, CUSTOMER_ACCOUNT_NUMBER);