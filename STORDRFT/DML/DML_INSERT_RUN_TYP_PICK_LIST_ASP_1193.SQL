/*-------------------------------------------------------------------------------------
Below script will create Run Type Pick List Values in table CODE_HEADER and CODE_DETAIL

Created: 01/18/2019 akj899 ASP-1193 CCNSD-8 CCN Project Team....
--------------------------------------------------------------------------------------*/

INSERT INTO CODE_HEADER VALUES ('STORE_DRAFT_CHECK_RUN_TYPE','COD','Store Drafts Check Order Run Types','N',NULL,NULL,1,NULL,'INITLD',NULL,NULL);

INSERT INTO CODE_DETAIL VALUES ('STORE_DRAFT_CHECK_RUN_TYPE','COD','A','Auto US drafts','N',NULL,TRUNC(SYSDATE),1,NULL,NULL);
INSERT INTO CODE_DETAIL VALUES ('STORE_DRAFT_CHECK_RUN_TYPE','COD','C','TAG Canada drafts','N',NULL,TRUNC(SYSDATE),2,NULL,NULL);
INSERT INTO CODE_DETAIL VALUES ('STORE_DRAFT_CHECK_RUN_TYPE','COD','L','TAG US Floorcovering drafts','N',NULL,TRUNC(SYSDATE),3,NULL,NULL);
INSERT INTO CODE_DETAIL VALUES ('STORE_DRAFT_CHECK_RUN_TYPE','COD','S','TAG US drafts','N',NULL,TRUNC(SYSDATE),4,NULL,NULL);

COMMIT;