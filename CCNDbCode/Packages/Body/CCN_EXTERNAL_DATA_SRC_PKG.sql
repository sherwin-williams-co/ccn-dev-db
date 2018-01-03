create or replace PACKAGE BODY    CCN_EXTERNAL_DATA_SRC_PKG
    AS
-- PACKAGE BODY
   
PROCEDURE DSC_CODES_SP(
/******************************************************************************
This procedure is intended to return a ref cursor with data from
from COST_CENTER_DSC_CODES table

Created : 12/13/2017 SXG151 CCN Project....
Modified:
*******************************************************************************/
    IN_COST_CENTER_CODE IN     COST_CENTER.COST_CENTER_CODE%TYPE,
    OUT_DSC_CODES          OUT REF_CURSOR)
IS     
BEGIN
    OPEN OUT_DSC_CODES FOR
        SELECT IN_COST_CENTER_CODE,PRIMARY_DSC,SECONDARY_DSC
          FROM COST_CENTER_DSC_CODES
         WHERE COST_CENTER_CODE = UPPER(SUBSTR(IN_COST_CENTER_CODE, 3));
END  DSC_CODES_SP;             

END CCN_EXTERNAL_DATA_SRC_PKG;