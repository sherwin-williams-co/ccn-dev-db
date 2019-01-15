/********************************************************************************** 
This script is used to drop tables created for credit and redemption transactions.
Also dropping credit details history table as we no longer maintain the history of deposit details.
Created : 01/15/2019 pxa852 CCN Project Team....
Modified:
**********************************************************************************/
DROP TABLE CUST_DEP_CREDIT_DETAILS;
DROP TABLE CUST_DEP_REDEMPTION_DETAILS;
DROP TABLE CUSTOMER_DEPOSIT_DETAILS_HIST;