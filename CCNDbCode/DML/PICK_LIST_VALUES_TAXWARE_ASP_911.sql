/*
Below DMLs will insert the pick list values for new fields added in COST_CENTER Table
    TWJ_STATE,TWJ_COUNTRY,TWJ_COMPANY fields

Created : 11/20/2017 sxg151 CCN Project Team....
*/
REM INSERTING into CODE_HEADER
SET DEFINE OFF;
INSERT INTO CODE_HEADER (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_HEADER_DESCRIPTION,CODE_HEADER_EXPIRE_FLAG,CODE_HEADER_EXPIRE_USER,CODE_HEADER_EXPIRE_EFF_DATE,CODE_HEADER_DTL_VAL_SIZE,CODE_HEADER_DTL_VAL_DEFAULT,CODE_HEADER_CREATE_USER,CODE_HEADER_EFF_DATE,CODE_HEADER_IDENTIFIER) values ('TWJ_STATE','COD','TAXWARE STATE CODE','N',null,null,1,null,'sxg151',TRUNC(SYSDATE),null);

REM INSERTING INTO CODE_DETAIL
SET DEFINE OFF;
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','01','ALABAMA',null,null,null,1,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','02','ALASKA',null,null,null,2,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','03','ARIZONA',null,null,null,3,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','04','ARKANSAS',null,null,null,4,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','05','CALIFORNIA',null,null,null,5,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','06','COLORADO',null,null,null,6,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','07','CONNECTICUT',null,null,null,7,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','08','DELAWARE',null,null,null,8,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','09','DISTRICT OF COLUMBIA',null,null,null,9,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','10','FLORIDA',null,null,null,10,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','11','GEORGIA',null,null,null,11,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','12','HAWAII',null,null,null,12,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','13','IDAHO',null,null,null,13,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','14','ILLINOIS',null,null,null,14,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','15','INDIANA',null,null,null,15,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','16','IOWA',null,null,null,16,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','17','KANSAS',null,null,null,17,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','18','KENTUCKY',null,null,null,18,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','19','LOUISIANA',null,null,null,19,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','20','MAINE',null,null,null,20,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','21','MARYLAND',null,null,null,21,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','22','MASSACHUSETTS',null,null,null,22,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','23','MICHIGAN',null,null,null,23,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','24','MINNESOTA',null,null,null,24,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','25','MISSISSIPPI',null,null,null,25,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','26','MISSOURI',null,null,null,26,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','27','MONTANA',null,null,null,27,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','28','NEBRASKA',null,null,null,28,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','29','NEVADA',null,null,null,29,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','30','NEW HAMPSHIRE',null,null,null,30,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','31','NEW JERSEY',null,null,null,31,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','32','NEW MEXICO',null,null,null,32,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','33','NEW YORK',null,null,null,33,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','34','NORTH CAROLINA',null,null,null,34,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','35','NORTH DAKOTA',null,null,null,35,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','36','OHIO',null,null,null,36,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','37','OKLAHOMA',null,null,null,37,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','38','OREGON',null,null,null,38,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','39','PENNSYLVANIA',null,null,null,39,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','40','RHODE ISLAND',null,null,null,40,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','41','SOUTH CAROLINA',null,null,null,41,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','42','SOUTH DAKOTA',null,null,null,42,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','43','TENNESSEE',null,null,null,43,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','44','TEXAS',null,null,null,44,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','45','UTAH',null,null,null,45,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','46','VERMONT',null,null,null,46,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','47','VIRGINIA',null,null,null,47,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','48','WASHINGTON',null,null,null,48,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','49','WEST VIRGINIA',null,null,null,49,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','50','WISCONSIN',null,null,null,55,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','51','WYOMING',null,null,null,51,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','54','PUERTO RICO',null,null,null,52,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_STATE','COD','55','VIRGIN ISLANDS',null,null,null,54,'sxg151',TRUNC(SYSDATE));

SET DEFINE OFF;
INSERT INTO CODE_HEADER (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_HEADER_DESCRIPTION,CODE_HEADER_EXPIRE_FLAG,CODE_HEADER_EXPIRE_USER,CODE_HEADER_EXPIRE_EFF_DATE,CODE_HEADER_DTL_VAL_SIZE,CODE_HEADER_DTL_VAL_DEFAULT,CODE_HEADER_CREATE_USER,CODE_HEADER_EFF_DATE,CODE_HEADER_IDENTIFIER) values ('TWJ_COUNTRY','COD','TAXWARE COUNTRY CODE','N',null,null,1,null,'sxg151',TRUNC(SYSDATE),null);

REM INSERTING INTO CODE_DETAIL
SET DEFINE OFF;
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_COUNTRY','COD','US','UNITED STATES OF AMERICA',null,null,null,1,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_COUNTRY','COD','CA','CANADA',null,null,null,2,'sxg151',TRUNC(SYSDATE));

SET DEFINE OFF;
INSERT INTO CODE_HEADER (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_HEADER_DESCRIPTION,CODE_HEADER_EXPIRE_FLAG,CODE_HEADER_EXPIRE_USER,CODE_HEADER_EXPIRE_EFF_DATE,CODE_HEADER_DTL_VAL_SIZE,CODE_HEADER_DTL_VAL_DEFAULT,CODE_HEADER_CREATE_USER,CODE_HEADER_EFF_DATE,CODE_HEADER_IDENTIFIER) values ('TWJ_COMPANY','COD','TAXWARE COMPANY CODE','N',null,null,1,null,'sxg151',TRUNC(SYSDATE),null);
REM INSERTING INTO CODE_DETAIL

SET DEFINE OFF;
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_COMPANY','COD','AF','AUTOMOTIVE FINISHES',null,null,null,1,'sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('TWJ_COMPANY','COD','SW','SHERWIN-WILLIAMS',null,null,null,2,'sxg151',TRUNC(SYSDATE));

COMMIT;