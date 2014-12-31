
/* COMMENT UPDATE for STOREDRFT_JV table */
COMMENT ON TABLE STOREDRFT_JV  IS 'This table stores data for Paid_jv which populate once a month with current JV data';

/* Creating STOREDRFT_JV_HST as same as STOREDRFT_JV table */
CREATE TABLE STOREDRFT_JV_HST AS SELECT * FROM STOREDRFT_JV WHERE 1=2;

/* COMMENT for STOREDRFT_JV_HST table */
COMMENT ON TABLE STOREDRFT_JV_HST  IS 'This table stores all the data of Storedrft_jv table for historical purpose';

/* ADDING RUN_IND COLUMN TO STOREDRFT_JV_HST*/
ALTER TABLE STOREDRFT_JV_HST
ADD RUN_IND NUMBER;