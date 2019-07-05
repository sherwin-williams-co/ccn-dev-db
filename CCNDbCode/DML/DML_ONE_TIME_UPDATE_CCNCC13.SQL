/***************************************************************************************
This script will be used for on etime update of DISPATCH_SERVICES_TYPE_CODE in STORE table 
to default value 1.

Created : 07/05/2019 akj899 CCNCC-13 CCN Project...
***************************************************************************************/

UPDATE STORE
   SET DISPATCH_SERVICES_TYPE_CODE = 1;
   
COMMIT;