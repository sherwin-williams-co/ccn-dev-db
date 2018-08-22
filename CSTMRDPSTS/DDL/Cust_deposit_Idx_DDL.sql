/*
     Created: 08/22/2018 sxh487 CCN Project Team..
     This script creates Index for CUSTOMER_DEPOSIT_DETAILS
     and NOT NULL enable for customer deposit tables
*/

ALTER TABLE 
   CUSTOMER_DEPOSIT_HEADER 
MODIFY 
   ( 
   CUSTOMER_ACCOUNT_NUMBER VARCHAR2(9) NOT NULL ENABLE
   );

ALTER TABLE    
  CUST_DEP_CREDIT_DETAILS 
MODIFY  
   ( CREDIT_ID NUMBER NOT NULL ENABLE,
	COST_CENTER_CODE VARCHAR2(6) NOT NULL ENABLE,
	CUSTOMER_ACCOUNT_NUMBER VARCHAR2(9) NOT NULL ENABLE,
	TRANSACTION_NUMBER VARCHAR2(5) NOT NULL ENABLE,
	TRANSACTION_DATE DATE NOT NULL ENABLE,
	TERMINAL_NUMBER VARCHAR2(5) NOT NULL ENABLE
    );

ALTER TABLE
   CUST_DEP_REDEMPTION_DETAILS
MODIFY
   ( REDEMPTION_ID NUMBER NOT NULL ENABLE,
	 COST_CENTER_CODE VARCHAR2(6) NOT NULL ENABLE,
	 CUSTOMER_ACCOUNT_NUMBER VARCHAR2(9) NOT NULL ENABLE,
	 TRANSACTION_NUMBER VARCHAR2(5) NOT NULL ENABLE,
	 TRANSACTION_DATE DATE NOT NULL ENABLE,
	 TERMINAL_NUMBER VARCHAR2(5) NOT NULL ENABLE
   );
   
CREATE INDEX CUSTOMER_DEPOSIT_DETAILS_INDE ON CUSTOMER_DEPOSIT_DETAILS (CUSTOMER_ACCOUNT_NUMBER,TRAN_TIMESTAMP);