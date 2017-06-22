CREATE OR REPLACE PACKAGE BNK_RECONCILE_DIFF_REPORT_PKG
/**************************************************************** 
This package is for creating reconcile difference report for
Banking Gift Card and deposit ticket/bags.

Created : 06/15/2017 gxg192 CCN Project....
Changed :
*****************************************************************/
AS

PROCEDURE BANKING_MF_FF_DATA_LOAD_SP(
/**************************************************************** 
This Procedure is used to build the data required for the
reconciliation of data for the Banking gift card and ticket/bag feed.

Created : 06/21/2017 gxg192 CCN Project....
Changed : 
*****************************************************************/
    IN_LOAD_DATE IN DATE);
    
PROCEDURE GEN_DELTA_FILES_SP(
/*********************************************************************** 
This Procedure is Wrapper procedure, which is used to generate
all difference files in server.

Created : 06/21/2017 gxg192 CCN Project....
Changed : 
************************************************************************/
IN_LOAD_DATE IN DATE);

END BNK_RECONCILE_DIFF_REPORT_PKG;