/*
     Created: 03/30/2017 axt754 CCN Project Team..
     This script will Delete Cost Center '83W006'
*/
BEGIN
   COMMON_TOOLS.DELETE_COST_CENTER('83W006'); 
   COMMIT;
END; 
/