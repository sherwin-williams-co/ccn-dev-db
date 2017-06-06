-- Inserting record to handle the default values for web address. changes done by rxv940
INSERT INTO TRANSLATION_DETAIL
(
  HEADER_NAME
, DETAIL_VALUE
, DETAIL_SEQ_NUMBER
, DETAIL_TRANSLATION
, DETAIL_EXPIRE_FLAG
)
SELECT 'STATEMENT_WEB_ADDR',	'SW',	'13',	'www.sherwin-williams.com',	'N' FROM DUAL; 		

COMMIT;