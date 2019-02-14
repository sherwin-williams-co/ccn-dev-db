/*
Below script will delete cost center '76Q423'
Created : 02/14/2019 sxg151 CCN Project Team....
*/
BEGIN
   COMMON_TOOLS.DELETE_COST_CENTER('76Q423'); 
   COMMIT;
END;
