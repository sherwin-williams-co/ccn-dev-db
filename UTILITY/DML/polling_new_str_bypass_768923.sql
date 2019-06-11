/**********************************************************************************
Below script is created to insert data into POS_NEW_STORES_VALIDATION_BYPASS table
to Bypass polling new store downloads validation for 768923 with status P
Created : 06/11/2019 sxh487 CCN Project 
**********************************************************************************/

INSERT INTO POS_NEW_STORES_VALIDATION_BYPASS
( COST_CENTER_CODE,CREATE_DATE,CREATED_BY,CREATED_REASON) VALUES ( '768923', '11-JUN-2019','ejw66r', 'Store restoration after fire event');

COMMIT;