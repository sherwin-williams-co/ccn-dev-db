-- table created by rxv940 on 09/28/2017
-- This is intended to be a temporary table which will hold a list of 
-- stores that went live in a phased manner

CREATE TABLE POS_INIT_LOAD_LIST
   (
   FILE_TYPE VARCHAR2(100 BYTE), 
   COST_CENTER_CODE VARCHAR2(6 BYTE), 
   CREATE_DT DATE, 
   CONSTRAINT PK_POS_INIT_LOAD_LT PRIMARY KEY (FILE_TYPE, COST_CENTER_CODE)
   );