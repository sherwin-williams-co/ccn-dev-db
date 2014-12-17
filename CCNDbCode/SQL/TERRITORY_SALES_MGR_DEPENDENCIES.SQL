/****************************************************************************** 
This sql is used to remove all the dependencies
  
created : 12/17/2014 CCN Project....
changed :
******************************************************************************/
-- Synonym
DROP SYNONYM "CCNUSER"."TERRITORY_SALES_MGR" FOR "COSTCNTR"."TERRITORY_SALES_MGR";
COMMIT;

-- Triggers
DROP TRIGGER TR_TERRITORY_SALES_MGR_DEL;
DROP TRIGGER TR_TERRITORY_SALES_MGR_UPD;
COMMIT;
