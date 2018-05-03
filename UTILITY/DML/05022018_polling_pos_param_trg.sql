/*
Created : nxk927 05/02/2018
          Below script will trigger a record in the Pos download table to get this record picked up.
          Previously picked the wrong data due to code issue with Virtual record

*/
EXECUTE POS_DATA_GENERATION.POS_TRG_EVENT_LOG('701927', 'MEMBER_BANK_CC', 'ADD', 'POS_PARAM_UPDATE');

COMMIT;