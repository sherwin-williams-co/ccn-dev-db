create or replace PACKAGE POS_GIFT_CARD_DIFF_pkg
/**************************************************************** 
      This package is used to Compare the Legacy GIFT CARD Transaction file to the 
      POS table driven GIFT CARD Transaction data load
      and get the Differance files created.
          
created : 11/04/2016 AXK326 CCN Team...
changed :
*****************************************************************/
AS

PROCEDURE POS_GIFT_CARD_DIFF_sp
/*********************************************************************** 
        This Procedure is used compare the legacy GIFT CARD Transaction file 
        and the POS GIFT CARD Transaction data and creats a Difference file.
        
created : 11/04/2016 AXK326 CCN Team...
changed :
************************************************************************/
;

END POS_GIFT_CARD_DIFF_pkg;