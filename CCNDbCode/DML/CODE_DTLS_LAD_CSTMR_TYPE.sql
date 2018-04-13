/*******************************************************************************
  Insert script for code detail and header table script for LAD_CUSTOMER_TYPE
  CREATED : 03/12/2018 nxk927783 CCN Project...
*******************************************************************************/
REM INSERTING into CODE_HEADER
SET DEFINE OFF;
INSERT INTOCODE_HEADER VALUES ('LAD_CUSTOMER_TYPE','COD','LAD_CUSTOMER COST CENTER TYPE','N',null,null,2,null,null,null,null);


REM INSERTING into CODE_DETAIL
INSERT INTO CODE_DETAIL VALUES ('LAD_CUSTOMER_TYPE','COD','HC', 'HOME CENTER', 'N',null, null, '186',null, null);
INSERT INTO CODE_DETAIL VALUES ('LAD_CUSTOMER_TYPE','COD','DC', 'DIRECT CUSTOMER', 'N',null, null, '187',null, null);
INSERT INTO CODE_DETAIL VALUES ('LAD_CUSTOMER_TYPE','COD','DD', 'DIRECT DEALER', 'N',null, null, '188',null, null);

COMMIT;