REM INSERTING into CODE_HEADER
SET DEFINE OFF;
Insert into CODE_HEADER values ('SALES_VOL_CLASS_CODE','COD','SALES VOLUME CLASS CODE',null,null,null,null,null,'axk326',TRUNC(SYSDATE));


REM INSERTING into CODE_DETAIL
SET DEFINE OFF;
Insert into CODE_DETAIL values ('SALES_VOL_CLASS_CODE','COD','@@','DUMMY SLSVLCLS',null,null,null,'1','axk326',TRUNC(SYSDATE));
Insert into CODE_DETAIL values ('SALES_VOL_CLASS_CODE','COD','00','NON STORE FACILITIES',null,null,null,'2','axk326',TRUNC(SYSDATE));
Insert into CODE_DETAIL values ('SALES_VOL_CLASS_CODE','COD','01','UNDER 400,000',null,null,null,'3','axk326',TRUNC(SYSDATE));
Insert into CODE_DETAIL values ('SALES_VOL_CLASS_CODE','COD','02','400,000 -  699,999',null,null,null,'4','axk326',TRUNC(SYSDATE));
Insert into CODE_DETAIL values ('SALES_VOL_CLASS_CODE','COD','03','700,000 -  999,999',null,null,null,'5','axk326',TRUNC(SYSDATE));
Insert into CODE_DETAIL values ('SALES_VOL_CLASS_CODE','COD','04','1000,000 - 1499,999',null,null,null,'6','axk326',TRUNC(SYSDATE));
Insert into CODE_DETAIL values ('SALES_VOL_CLASS_CODE','COD','05','1500,000 - 1999,999',null,null,null,'7','axk326',TRUNC(SYSDATE));
Insert into CODE_DETAIL values ('SALES_VOL_CLASS_CODE','COD','06','GREATER 2,000,000',null,null,null,'8','axk326',TRUNC(SYSDATE));
Insert into CODE_DETAIL values ('SALES_VOL_CLASS_CODE','COD','07','NO LONGER USED',null,null,null,'9','axk326',TRUNC(SYSDATE));
Insert into CODE_DETAIL values ('SALES_VOL_CLASS_CODE','COD','08','COMMERCIAL SUMMARY',null,null,null,'10','axk326',TRUNC(SYSDATE));
Insert into CODE_DETAIL values ('SALES_VOL_CLASS_CODE','COD','11','UNDER 500,000',null,null,null,'11','axk326',TRUNC(SYSDATE));
Insert into CODE_DETAIL values ('SALES_VOL_CLASS_CODE','COD','12','500,000 -  999,999',null,null,null,'12','axk326',TRUNC(SYSDATE));
Insert into CODE_DETAIL values ('SALES_VOL_CLASS_CODE','COD','13','1000,000 - 1499,999',null,null,null,'13','axk326',TRUNC(SYSDATE));
Insert into CODE_DETAIL values ('SALES_VOL_CLASS_CODE','COD','14','1500,000 - 1999,999',null,null,null,'14','axk326',TRUNC(SYSDATE));
Insert into CODE_DETAIL values ('SALES_VOL_CLASS_CODE','COD','15','2000,000 - 2499,999',null,null,null,'15','axk326',TRUNC(SYSDATE));
Insert into CODE_DETAIL values ('SALES_VOL_CLASS_CODE','COD','16','2500,000 - 2999,999',null,null,null,'16','axk326',TRUNC(SYSDATE));
Insert into CODE_DETAIL values ('SALES_VOL_CLASS_CODE','COD','17','GREATER 3,000,000',null,null,null,'17','axk326',TRUNC(SYSDATE));
Insert into CODE_DETAIL values ('SALES_VOL_CLASS_CODE','COD','21','UNDER 999,999',null,null,null,'18','axk326',TRUNC(SYSDATE));
Insert into CODE_DETAIL values ('SALES_VOL_CLASS_CODE','COD','22','1000,000 - 1999,999',null,null,null,'19','axk326',TRUNC(SYSDATE));
Insert into CODE_DETAIL values ('SALES_VOL_CLASS_CODE','COD','23','2000,000 - 2999,999',null,null,null,'20','axk326',TRUNC(SYSDATE));
Insert into CODE_DETAIL values ('SALES_VOL_CLASS_CODE','COD','24','3000,000 - 3999,999',null,null,null,'21','axk326',TRUNC(SYSDATE));
Insert into CODE_DETAIL values ('SALES_VOL_CLASS_CODE','COD','25','4000,000 - 4999,999',null,null,null,'22','axk326',TRUNC(SYSDATE));
Insert into CODE_DETAIL values ('SALES_VOL_CLASS_CODE','COD','26','5000,000 - 5999,999',null,null,null,'23','axk326',TRUNC(SYSDATE));
Insert into CODE_DETAIL values ('SALES_VOL_CLASS_CODE','COD','27','GREATER 6,000,000',null,null,null,'24','axk326',TRUNC(SYSDATE));

COMMIT;
