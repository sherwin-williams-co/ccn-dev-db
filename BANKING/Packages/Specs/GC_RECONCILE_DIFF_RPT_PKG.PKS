create or replace PACKAGE GC_RECONCILE_DIFF_RPT_PKG
/**************************************************************** 
This package is used to look for the missing data in POS data and 
Mainframe files using the next 2 days of Data loads

created : 12/16/2016 vxv336 CCN Team
changed : 
*****************************************************************/
AS

PROCEDURE DATA_CHECK(
/*********************************************************************** 
This procedure is used to look for the missing and mismatched data 
in Mainframe files from POS data

created : 12/16/2016 vxv336 CCN Team
changed : 
************************************************************************/
IN_LOAD_DATE DATE);

END GC_RECONCILE_DIFF_RPT_PKG;