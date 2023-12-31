create or replace PACKAGE POS_BANKING_DAILY_LOAD AS
/**************************************************************************************
This package is for loading data from POS to CCN for
Banking Gift Card and deposit ticket/bags.

Created : 06/15/2017 gxg192 CCN Project....
Changed : 06/21/2016 gxg192 Changes to use single procedure for loading pos data
                            for gift cards and ticket/bags
Changed : 09/27/2017 rxa457 CCN project....
           Added new function GET_LATEST_POS_RUN_CYCLE to return the
           oldest run cycle that's pending to be loaded into POS tables
***************************************************************************************/

FUNCTION GET_UAR_TRANS_CODE(
/**************************************************************************************
GET_UAR_TRANS_CODE

Created : 05/19/2017 gxg192 CCN Project....
Changed : 06/26/2017 gxg192 Changes in logic for finding uar tran code.
        : 08/24/2017 gxg192 Added IN_GIFT_CARD_NBR as in parameter.
        : 10/30/2017 nxk927 CCN Project team....
          Signature changed. Added IN_SEQNBR
**************************************************************************************/
            IN_TRANID        IN POS_GIFT_CARD_POS_TRANS.TRANSACTION_TYPE%TYPE,
            IN_RLS_RUN_CYCLE IN PNP_CCN_HEADERS.RLS_RUN_CYCLE%TYPE,
            IN_TRAN_GUID     IN PNP_CCN_HEADERS.TRAN_GUID%TYPE,
            IN_GIFT_CARD_NBR IN PNP_CCN_HEADERS.TRAN_GUID%TYPE,
            IN_SEQNBR        IN PNP_CCN_GIFT_CARD_LOG.SEQNBR%TYPE)
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

FUNCTION GET_POS_RUN_CYCLE
/**************************************************************************************
Function returns the oldest run cycle from PNP 
that is pending to be loaded into local POS tables
Created : 09/27/2017 RXA457 CCN Project....
Changed : 
**************************************************************************************/
RETURN POS_CCN_LOAD_STATUS.RLS_RUN_CYCLE%TYPE;

END POS_BANKING_DAILY_LOAD;