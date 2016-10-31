/**************************************************************************************
Created : AXK326 10/31/2016
          Adding new user 'axi416' to CCN Store drafts with same access credentials of
          Christopher T Greeve 'ctg355'
**************************************************************************************/
SET DEFINE OFF;
Insert into SECURITY_MATRIX (USER_ID,PASSWORD,ROLE_CODE) values ('axi416','axi416','CCNUS1');
Insert into SECURITY_MATRIX (USER_ID,PASSWORD,ROLE_CODE) values ('axi416','axi416','SDU');

COMMIT;