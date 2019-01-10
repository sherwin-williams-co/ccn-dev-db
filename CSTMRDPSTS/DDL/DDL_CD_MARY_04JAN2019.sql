/*******************************************************************************
Created : 01/04/2019 sxg151 CCN Project Team...
          The script will created tables  CD_MARY_04JAN2019 table.
          ASP-1187 
*******************************************************************************/

CREATE TABLE CD_MARY_04JAN2019 (
CUSTOMER_ACCOUNT_NUMBER	    VARCHAR2(9),
COST_CENTER_CODE            VARCHAR2(6),
TRANSACTION_TYPE            VARCHAR2(50),
TRANSACTION_NUMBER	        VARCHAR2(5),
TERMINAL_NUMBER	            VARCHAR2(5),
POS_TRANSACTION_CODE	    VARCHAR2(2),
TRANSACTION_DATE	        DATE,
MONTH                       NUMBER,
YEAR	                    NUMBER,
TRAN_TIMESTAMP	            TIMESTAMP(6),
CSTMR_DPST_SALES_LN_ITM_AMT	NUMBER,
CUST_REM_BALANCE	        NUMBER,
CLEARED_REASON	            VARCHAR2(1000),
NOTES	                    VARCHAR2(4000),
CLOSED_DATE	                DATE,
GL_DIVISION	                VARCHAR2(20)
);