/*

This script will delete cost center 7AU091 from CCN.
Executed this as emergency fix in production

Created : 11/03/2018 jxc517 CCN Project Team
Changed :
*/

BEGIN
   COMMON_TOOLS.DELETE_COST_CENTER('7AU091'); 
   COMMIT;
END;
/
