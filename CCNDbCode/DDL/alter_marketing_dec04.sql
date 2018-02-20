/*
This script is used to alter marketing table to add TOTAL_SQ_FT, SALES_SQ_FT, WAREHOUSE_SQ_FT

Created : 12/04/2017 axt754 CCN Project Team....
Changed :
*/
ALTER TABLE MARKETING
  ADD (TOTAL_SQ_FT      NUMBER
       ,SALES_SQ_FT     NUMBER
       ,WAREHOUSE_SQ_FT NUMBER);