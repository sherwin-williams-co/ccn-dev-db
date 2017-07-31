/*
Script Name: DELETE_COST_CENTER_VIRTUAL_FUTURES.sql
Purpose    : For deleting the virtual Futures from BANK_DEP_BAG_TICKORD_FUTURE, BANK_DEP_TICKORD_FUTURE, BANK_DEP_BAG_TICK_FUTURE, BANK_DEP_TICK_FUTURE, and STORE_MICR_FORMAT_DTLS_FUTURE tables-- REF ASP-825

Created    : 07/26/2017 rxa457 CCN Project....
*/
/*Backup Virtual Future Records*/
CREATE TABLE BANK_DEP_BAG_TKORD_FUTURE_825 AS SELECT * FROM BANK_DEP_BAG_TICKORD_FUTURE WHERE TRUNC(EFFECTIVE_DATE) <= TRUNC(SYSDATE);
CREATE TABLE BANK_DEP_TKORD_FUTURE_825 AS SELECT * FROM BANK_DEP_BAG_TICKORD_FUTURE WHERE TRUNC(EFFECTIVE_DATE) <= TRUNC(SYSDATE);
CREATE TABLE BANK_DEP_BAG_TK_FUTURE_825 AS SELECT * FROM BANK_DEP_BAG_TICKORD_FUTURE WHERE TRUNC(EFFECTIVE_DATE) <= TRUNC(SYSDATE);
CREATE TABLE BANK_DEP_TK_FUTURE_825 AS SELECT * FROM BANK_DEP_BAG_TICKORD_FUTURE WHERE TRUNC(EFFECTIVE_DATE) <= TRUNC(SYSDATE);
CREATE TABLE STORE_MICR_FORMAT_DTLS_FT_825 AS SELECT * FROM BANK_DEP_BAG_TICKORD_FUTURE WHERE TRUNC(EFFECTIVE_DATE) <= TRUNC(SYSDATE);

DELETE FROM BANK_DEP_BAG_TICKORD_FUTURE WHERE TRUNC(EFFECTIVE_DATE) <= TRUNC(SYSDATE);
DELETE FROM BANK_DEP_TICKORD_FUTURE WHERE TRUNC(EFFECTIVE_DATE) <= TRUNC(SYSDATE);
DELETE FROM BANK_DEP_BAG_TICK_FUTURE WHERE TRUNC(EFFECTIVE_DATE) <= TRUNC(SYSDATE);
DELETE FROM BANK_DEP_TICK_FUTURE WHERE TRUNC(EFFECTIVE_DATE) <= TRUNC(SYSDATE);
DELETE FROM STORE_MICR_FORMAT_DTLS_FUTURE WHERE TRUNC(EFFECTIVE_DATE) <= TRUNC(SYSDATE);

COMMIT;

