create or replace PACKAGE INITLOAD_PCI_ID AS
/****************************************************************************** 
This package is intended to load PCI DISCOVER ID and PCI MERCHANT ID  columns in bank card table

created : 03/03/2016 nxk927 CCN Project
changed : 
******************************************************************************/

PROCEDURE INITLOAD_SP
/******************************************************************
This Procedure is a wrapper for the Initial Load of the 
BANK TABLE COLUMNS:  PCI MERCHANT ID and PCI DISCOVER ID
TERMINAL TABLE COLUMNS : PCI_TERMINAL_ID ,PCI_VALUE_LINK_MID and PCI_VAL_LINK_ALT_MID
   
   This process will load data in the new columns mentioned above

Created : 03/03/2016 nxk927 CCN Project....
Changed :
******************************************************************/
;

END INITLOAD_PCI_ID;