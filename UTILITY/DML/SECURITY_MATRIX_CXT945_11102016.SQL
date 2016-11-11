/************************************************************************************** 
Created : gxg192 11/09/2016           
Adding new user 'CXT945' to CCN Store drafts 
with same access credentials of Christopher T Greeve i.e. 'ctg355' 
**************************************************************************************/ 

SET DEFINE OFF; 

INSERT INTO SECURITY_MATRIX (USER_ID,PASSWORD,ROLE_CODE) 
VALUES ('cxt945','cxt945','CCNUS1'); 

INSERT INTO SECURITY_MATRIX (USER_ID,PASSWORD,ROLE_CODE) 
VALUES ('cxt945','cxt945','SDU'); 

COMMIT;