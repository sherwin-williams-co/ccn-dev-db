--SXH487 08/24/2015
--Below scripts will remove the paid dates for the following Drafts

SELECT * FROM STORE_DRAFTS
 WHERE DRAFT_NUMBER IN('4789', '4793', '4796', '4797')
   AND COST_CENTER_CODE ='705342';

UPDATE STORE_DRAFTS 
   SET PAY_INDICATOR = 'N', 
       PAID_DATE = NULL 
 WHERE DRAFT_NUMBER IN('4789', '4793', '4796', '4797')
   AND COST_CENTER_CODE ='705342';

COMMIT;