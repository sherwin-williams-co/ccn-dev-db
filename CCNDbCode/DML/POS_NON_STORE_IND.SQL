SET DEFINE OFF;
Insert into CODE_HEADER values ('POS_NON_STORE_IND','COD','POS_NON_STORE_IND','N',null,null,1,null,'nxk927',TRUNC(SYSDATE));

Insert into CODE_DETAIL values ('POS_NON_STORE_IND','COD','N','POS-STORE','N',null,null,'1','nxk927',TRUNC(SYSDATE));
Insert into CODE_DETAIL values ('POS_NON_STORE_IND','COD','Y','NON POS COST CENTER','N',null,null,'2','nxk927',TRUNC(SYSDATE));

COMMIT;