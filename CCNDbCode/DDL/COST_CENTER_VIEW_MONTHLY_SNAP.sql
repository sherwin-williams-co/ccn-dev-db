/*
**************************************************************************** 
This script is to rename column names for COST_CENTER_VIEW_MONTHLY_SNAP table
LEASING_SALES_SQ_FT TO MKT_SALES_SQ_FT
LEASING_TOTAL_SQ_FT TO MKT_TOTAL_SQ_FT
created : 2/14/2019 kxm302 CCN Project.... 
changed : 
****************************************************************************
*/
ALTER TABLE COST_CENTER_VIEW_MONTHLY_SNAP
RENAME COLUMN LEASING_SALES_SQ_FT TO MKT_SALES_SQ_FT;

ALTER TABLE COST_CENTER_VIEW_MONTHLY_SNAP
RENAME COLUMN LEASING_TOTAL_SQ_FT TO MKT_TOTAL_SQ_FT;