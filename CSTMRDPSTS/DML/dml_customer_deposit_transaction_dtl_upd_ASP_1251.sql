/*
This script will  rounded to two number decimal places for the manual correction account numbers and update the GL_DIVISION with 'A222'

Created  : 05/07/2019 CCN Team...
         : ASP-1251 : There was a rounding issue with the previous update. Showing more than 2 decimal points in "CSTMR_DPST_SALES_LN_ITM_AMT, CUSTOMER_NET_BALANCE fields,
           It should show only two decimal points.intial update was made on '29-APR-19' since then Net Balance and Sales line item amount showing more than two decimal points for the updated accounts
*/
UPDATE CUSTOMER_DEPOSIT_TRANSACTION_DTL
   SET CSTMR_DPST_SALES_LN_ITM_AMT = round(CSTMR_DPST_SALES_LN_ITM_AMT,2),
       CUSTOMER_NET_BALANCE        = round(CUSTOMER_NET_BALANCE,2) 
 WHERE trunc(LOAD_DATE) >= '29-APR-19'
   AND (round(CSTMR_DPST_SALES_LN_ITM_AMT,2) <> CSTMR_DPST_SALES_LN_ITM_AMT OR round(CUSTOMER_NET_BALANCE,2) <> CUSTOMER_NET_BALANCE);
   


SELECT CSTMR_DPST_SALES_LN_ITM_AMT,round(CSTMR_DPST_SALES_LN_ITM_AMT,2),CUSTOMER_NET_BALANCE,round(CUSTOMER_NET_BALANCE,2) 
  FROM CUSTOMER_DEPOSIT_TRANSACTION_DTL 
 WHERE trunc(LOAD_DATE) >= '29-APR-19'
   
   COMMIT;