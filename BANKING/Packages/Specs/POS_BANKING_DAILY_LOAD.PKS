CREATE OR REPLACE PACKAGE POS_BANKING_DAILY_LOAD AS
/**************************************************************** 
This package is for loading data from POS to CCN for
Banking Gift Card and deposit ticket/bags.

Created : 06/15/2017 gxg192 CCN Project....
Changed : 
*****************************************************************/

FUNCTION GET_UAR_TRANS_CODE(
/**************************************************************************************
GET_UAR_TRANS_CODE

This FUNCTION will derive the UAT TRANS CODE based on Accum id present in CCN_ACCUMS table
in POS.

Created : 05/19/2017 gxg192 CCN Project....
Changed :
**************************************************************************************/
            IN_TRANID        IN UAR_GIFT_CARD_POS_TRANS.TRANSACTION_TYPE%TYPE,
            IN_RLS_RUN_CYCLE IN PNP_CCN_HEADERS.RLS_RUN_CYCLE%TYPE,
            IN_TRAN_GUID     IN PNP_CCN_HEADERS.TRAN_GUID%TYPE)
RETURN UAR_GIFT_CARD_POS_TRANS.UAR_TRAN_CODE%TYPE;

PROCEDURE GIFT_CARD_DATA_LOAD_SP(
/***********************************************************************
This Procedure is a wrapper for the gift card related data to be loaded
from POS Interface tables

Created : 10/26/2016 AXK326 CCN Project....
Changed : 12/06/2016 vxv336 Removed CONTROL and DETAIL file generation
        : 06/12/2017 gxg192 Added call to procedure load_pos_ccn_load_status
***********************************************************************/
IN_DATE DATE
);

PROCEDURE TICKET_BAG_DATA_LOAD_SP(
/*********************************************************************** 
This Procedure is Wrapper procedure, which is used to load POS data related
to banking deposit ticket and bags.

Created : 06/15/2017 gxg192 CCN Project
Changed :
************************************************************************/
    IN_DATE IN DATE);

END POS_BANKING_DAILY_LOAD;