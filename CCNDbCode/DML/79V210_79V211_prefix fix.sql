/*
Created : nxk927 04/28/2016 
          Fixing prefix for cost centers 79V210 and 79V211. These should have been 70V210 and 70V211.
          This will copy 79V210 to 70V210 as it is and will delete 79V210
          This will copy 79V211 to 70V211 as it is and will delete 79V211
*/
DECLARE
BEGIN
COMMON_TOOLS.COPY_COST_CENTER('79V210', '70V210');
COMMON_TOOLS.DELETE_COST_CENTER('79V210');
COMMON_TOOLS.COPY_COST_CENTER('79V211', '70V211');
COMMON_TOOLS.DELETE_COST_CENTER('79V211');
END;
/
