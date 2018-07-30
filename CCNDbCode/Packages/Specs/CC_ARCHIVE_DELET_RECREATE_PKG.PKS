create or replace PACKAGE CC_ARCHIVE_DELET_RECREATE_PKG AUTHID CURRENT_USER AS
/**********************************************************
This Package contains all the procedures used to deal with
removing/archiving a cost center from CCN database

Created : 03/16/2016 jxc517 CCN Project....
Changed :
**********************************************************/

TYPE REF_CURSOR IS REF CURSOR;

PROCEDURE PROCESS
/**********************************************************
  This procedure is the core procedure that gets invoked
	for bulk cost center deletions from CCN application
  
  We need to archive the existing cost center details
  Delete the exisitng cost center details
  Reinsert the cost center details with new cost center mapped by business
  store the deleted cost center/new cost center with mapping to a GUID


created : 03/15/2016 jxc517 CCN Project Team...
modified: 
**********************************************************/;

PROCEDURE RECREATE_MISMTCH_ARCHV_TBL_SP
/*******************************************************************************
This procedure is intended to create a backup table and recreate archive table with new fields.
Load the backup table data into archive table.

Created :  07/24/2018 pxa852 Address Object....
Changed :
*******************************************************************************/
;


END CC_ARCHIVE_DELET_RECREATE_PKG;