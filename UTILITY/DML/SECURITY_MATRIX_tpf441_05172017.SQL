/************************************************************************************** 
Created : gxg192 05/17/2017
Adding new user 'tpf441' to CCN Store drafts 
with same access credentials of Christopher T Greeve i.e. 'ctg355' 
**************************************************************************************/ 

SET DEFINE OFF; 

INSERT INTO SECURITY_MATRIX (USER_ID,PASSWORD,ROLE_CODE) 
VALUES ('tpf441','tpf441','CCNUS1'); 

INSERT INTO SECURITY_MATRIX (USER_ID,PASSWORD,ROLE_CODE) 
VALUES ('tpf441','tpf441','SDU'); 

COMMIT;