/************************************************************************************** 
Created : gxg192 11/09/2016           
Adding new user 'CXT945' to CCN Store drafts 
with same access credentials of Christopher T Greeve i.e. 'ctg355' 
**************************************************************************************/ 

SET DEFINE OFF; 

Insert into SECURITY_MATRIX (USER_ID,PASSWORD,ROLE_CODE) 
values ('CXT945','CXT945','CCNUS1'); 

Insert into SECURITY_MATRIX (USER_ID,PASSWORD,ROLE_CODE) 
values ('CXT945','CXT945','SDU'); 

COMMIT;

