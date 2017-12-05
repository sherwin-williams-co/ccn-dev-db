/***************************************************************
Index on OYAL_BANK_HIST added 
Created: 12/05/2017 sxh487 CCN Project Team...
****************************************************************/
CREATE INDEX LOAD_DATE_IDX ON ROYAL_BANK_HIST (trunc(LOAD_DATE), RUN_NBR);