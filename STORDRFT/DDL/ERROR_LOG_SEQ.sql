DROP SEQUENCE STORDRFT.ERROR_LOG_SEQ;

CREATE SEQUENCE STORDRFT.ERROR_LOG_SEQ
  START WITH 1
  MAXVALUE 999999999
  MINVALUE 0
  NOCYCLE
  CACHE 20
  NOORDER;