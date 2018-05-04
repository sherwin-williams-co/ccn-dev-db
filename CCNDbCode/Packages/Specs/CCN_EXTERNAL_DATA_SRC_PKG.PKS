create or replace PACKAGE   CCN_EXTERNAL_DATA_SRC_PKG
	AS
  TYPE REF_CURSOR  IS REF CURSOR;
  
PROCEDURE DSC_CODES_SP(
/******************************************************************************
This procedure is intended to return a ref cursor with data from
from CCN_DSC_CODE_DESC table

Created : 12/13/2017 SXG151 CCN Project....
Modified:
*******************************************************************************/
IN_COST_CENTER_CODE IN           COST_CENTER.COST_CENTER_CODE%TYPE,
OUT_DSC_CODES                     OUT REF_CURSOR); 
    
END CCN_EXTERNAL_DATA_SRC_PKG;