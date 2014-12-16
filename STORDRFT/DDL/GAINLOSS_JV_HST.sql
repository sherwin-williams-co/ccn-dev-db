
/* Creating GAINLOSS_JV_HST as same as GAINLOSS_JV table */
CREATE TABLE GAINLOSS_JV_HST AS SELECT * FROM GAINLOSS_JV WHERE 1=2;

/* COMMENT for GAINLOSS_JV_HST table */
COMMENT ON TABLE GAINLOSS_JV_HST IS 'This table stores all the data of Gainloss_jv table for historical purpose';