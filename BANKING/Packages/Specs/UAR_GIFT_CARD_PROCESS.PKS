CREATE OR REPLACE PACKAGE UAR_GIFT_CARD_PROCESS AS

FUNCTION GET_UAR_TRANS_CODE(
            IN_TRANID        IN UAR_GIFT_CARD_POS_TRANS.TRANSACTION_TYPE%TYPE,
            IN_RLS_RUN_CYCLE IN PNP_CCN_HEADERS.RLS_RUN_CYCLE%TYPE,
            IN_TRAN_GUID     IN PNP_CCN_HEADERS.TRAN_GUID%TYPE)
RETURN UAR_GIFT_CARD_POS_TRANS.UAR_TRAN_CODE%TYPE;

PROCEDURE POS_GC_DATA_LOAD_SP(
/***********************************************************************
This Procedure is a wrapper for the gift card related data to be loaded
from POS Interface tables

created : 10/26/2016 AXK326 CCN Project....
changed :
***********************************************************************/
IN_DATE DATE
);

END UAR_GIFT_CARD_PROCESS;