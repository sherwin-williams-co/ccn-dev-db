/****************************************************************************** 
This sql is used to remove all the dependencies
  
created : 12/17/2014 CCN Project....
changed :
******************************************************************************/
-- Synonym run it in CCN_USER
DROP SYNONYM TERRITORY_SALES_MGR;;
COMMIT;

-- Triggers
DROP TRIGGER TR_TERRITORY_SALES_MGR_DEL;
DROP TRIGGER TR_TERRITORY_SALES_MGR_UPD;
COMMIT;
