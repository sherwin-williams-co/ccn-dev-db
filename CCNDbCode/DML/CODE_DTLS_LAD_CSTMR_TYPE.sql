/*******************************************************************************
  Insert script for code detail and header table script for LAD_CUSTOMER_TYPE
  CREATED : 10/02/2018 sxg151 CCN Project...
*******************************************************************************/
REM INSERTING into CODE_HEADER
SET DEFINE OFF;
INSERT INTO CODE_HEADER VALUES ('LAD_CUSTOMER_TYPE','COD','LAD_CUSTOMER COST CENTER TYPE','N',NULL,NULL,2,'sxg151',TRUNC(SYSDATE),NULL,NULL);


REM INSERTING into CODE_DETAIL
INSERT INTO CODE_DETAIL VALUES ('LAD_CUSTOMER_TYPE','COD','HC', 'HOME CENTER',    'N',NULL,NULL,'1','sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL VALUES ('LAD_CUSTOMER_TYPE','COD','DC', 'DIRECT CUSTOMER','N',NULL,NULL,'2','sxg151',TRUNC(SYSDATE));
INSERT INTO CODE_DETAIL VALUES ('LAD_CUSTOMER_TYPE','COD','DD', 'DIRECT DEALER',  'N',NULL,NULL,'3','sxg151',TRUNC(SYSDATE));

COMMIT;