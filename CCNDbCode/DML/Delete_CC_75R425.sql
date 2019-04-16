/*
Below script will delete cost center '75R425' from CCN

Created : 04/16/2019 jxc517 CCN Project Team....
*/
BEGIN
   COMMON_TOOLS.DELETE_COST_CENTER('75R425'); 
   COMMIT;
END;
