create or replace PACKAGE UAR_GIFT_CARD_PROCESS AS 

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