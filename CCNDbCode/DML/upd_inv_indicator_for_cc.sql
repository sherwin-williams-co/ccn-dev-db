/*
     Created: 05/16/2017 axt754 CCN Project Team..
     DML script for updating INVENTORY_INDICATOR field to 'N'
     and perp_inv_start_date to NULL in STORE table
     for COST_CENTER_CODE '778802','779025','768700'
*/
-- MANUAL BACKUP before doing updates 
SELECT * 
  FROM STORE
 WHERE COST_CENTER_CODE 
    IN ('778802','779025','768700');
    
-- UPDATE INVENTORY_INDICATOR Field to 'N' and prep_inv_start_date to NULL
UPDATE STORE
   SET INVENTORY_INDICATOR = 'N'
       ,PERP_INV_START_DATE = NULL
 WHERE COST_CENTER_CODE IN ('778802','779025','768700');
 
-- COMMIT Trasanction 
COMMIT;

