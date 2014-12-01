/*********************************************************** 
This block will Update the amount fields with negative values

created : 12/01/2014 axk326 CCN Project....
changed :

************************************************************/
DECLARE
BEGIN
    FOR rec IN (SELECT *
                  FROM (SELECT ROW_NUMBER( ) OVER (PARTITION BY COST_CENTER_CODE,TRANSACTION_DATE,TERM_NUMBER,TRANSACTION_NUMBER ORDER BY TRANSACTION_DATE) SRLNO,A.*
                          FROM CUSTOMER_DETAILS_T A)
                 WHERE ITEM_PRICE_SGN    = '-'
                    OR ITEM_EXT_AMT_SGN  = '-'
                    OR ITEM_DISC_AMT_SGN = '-') LOOP
        UPDATE CUSTOMER_DETAILS CD
           SET CD.ITEM_PRICE           				   = rec.Item_Price_Sgn||CCN_COMMON_TOOLS.RETURN_NUMBER(rec.Item_Price,7,2) , 
		       CD.Item_EXT_AMOUNT      				   = rec.Item_EXT_AMT_SGN||CCN_COMMON_TOOLS.RETURN_NUMBER(rec.Item_EXT_AMOUNT,7,2), 
			   CD.ITEM_DISCOUNT_AMOUNT 				   = rec.ITEM_DISC_AMT_SGN||CCN_COMMON_TOOLS.RETURN_NUMBER(rec.ITEM_DISC_AMOUNT,7,2)
           WHERE CUSTOMER_DETAIL_ID    				   = TRIM(rec.SRLNO)
             AND COST_CENTER_CODE      				   = TRIM(rec.COST_CENTER_CODE)
             AND TO_CHAR(CD.TRANSACTION_DATE,'YYMMDD') = TO_CHAR(TO_DATE(rec.TRANSACTION_DATE,'YYMMDD'),'YYMMDD')
             AND TERMINAL_NUMBER       				   = TRIM(rec.TERM_NUMBER)
             AND TRANSACTION_NUMBER    				   = TRIM(rec.TRANSACTION_NUMBER);
END LOOP;
END;