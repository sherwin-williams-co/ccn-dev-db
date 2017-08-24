CREATE OR REPLACE PACKAGE POS_BANKING_DAILY_LOAD AS
/**************************************************************************************
This package is for loading data from POS to CCN for
Banking Gift Card and deposit ticket/bags.

Created : 06/15/2017 gxg192 CCN Project....
Changed : 06/21/2016 gxg192 Changes to use single procedure for loading pos data
                            for gift cards and ticket/bags
        : 08/24/2016 gxg192 Removed function GET_UAR_TRANS_CODE as it is not executed from
                            any other package/procedure.
***************************************************************************************/

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