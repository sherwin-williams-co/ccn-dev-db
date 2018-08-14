/*
Below script will delete cost center '71R157 '
Created : 08/14/2018 sxg151 CCN Project Team....
        : ASP-1119 
*/
BEGIN
   COMMON_TOOLS.DELETE_COST_CENTER('71R157'); 
   COMMIT;
END;
