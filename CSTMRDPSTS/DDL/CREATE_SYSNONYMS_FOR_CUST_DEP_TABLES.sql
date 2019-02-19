/*******************************************************************************
This script is intended to create sysnonyms for intermediate tables that are populated with PNP data
CREATED : 02/12/2019 pxa852 CCN Project...
*******************************************************************************/
CREATE OR REPLACE SYNONYM PNP_CCN_HEADERS FOR PNP.CCN_HEADERS; 
CREATE OR REPLACE SYNONYM PNP_CCN_SALES_LINES FOR PNP.CCN_SALES_LINES;
CREATE OR REPLACE SYNONYM PNP_CCN_LOAD_STATUS FOR PNP.CCN_LOAD_STATUS;