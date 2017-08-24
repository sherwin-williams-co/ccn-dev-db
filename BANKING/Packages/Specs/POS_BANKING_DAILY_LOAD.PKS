CREATE OR REPLACE PACKAGE POS_BANKING_DAILY_LOAD AS
/**************************************************************************************
This package is for loading data from POS to CCN for
Banking Gift Card and deposit ticket/bags.

Created : 06/15/2017 gxg192 CCN Project....
Changed : 06/21/2016 gxg192 Changes to use single procedure for loading pos data
                            for gift cards and ticket/bags
***************************************************************************************/

FUNCTION GET_UAR_TRANS_CODE(
/**************************************************************************************
GET_UAR_TRANS_CODE

Created : 05/19/2017 gxg192 CCN Project....
Changed : 06/26/2017 gxg192 Changes in logic for finding uar tran code.
        : 08/24/2017 gxg192 Added IN_GIFT_CARD_NBR as in parameter.
**************************************************************************************/
            IN_TRANID        IN POS_GIFT_CARD_POS_TRANS.TRANSACTION_TYPE%TYPE,
            IN_RLS_RUN_CYCLE IN PNP_CCN_HEADERS.RLS_RUN_CYCLE%TYPE,
            IN_TRAN_GUID     IN PNP_CCN_HEADERS.TRAN_GUID%TYPE,
            IN_GIFT_CARD_NBR IN PNP_CCN_HEADERS.TRAN_GUID%TYPE)
RETURN POS_GIFT_CARD_POS_TRANS.UAR_TRAN_CODE%TYPE;

PROCEDURE GENERATE_GIFT_CARD_TRANS_FILE (
/******************************************************************************
This procedure will generate UAR GIFT CARD TRANSACTION FILE [SRA30060] file

Created : 10/28/2016 vxv336/gxg192 CCN Project
Changed : 06/14/2017 gxg192 Changes to add header, trailor and summary record
*******************************************************************************/
IN_DATE            IN         DATE);

PROCEDURE POS_BANKING_DAILY_LOAD_SP(
/***********************************************************************
This Procedure is a wrapper for loading gift card and ticket/bags related data
from POS Interface tables to Banking tables.

Created : 06/21/2016 gxg192 CCN Project....
Changed :

***********************************************************************/
IN_DATE DATE
);

END POS_BANKING_DAILY_LOAD;