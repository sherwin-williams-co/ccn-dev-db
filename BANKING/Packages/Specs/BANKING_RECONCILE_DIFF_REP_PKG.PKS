CREATE OR REPLACE PACKAGE BANKING_RECONCILE_DIFF_REP_PKG
/**************************************************************** 
This package is for creating reconcile difference report for
Banking Gift Card and deposit ticket/bags.

Created : 06/15/2017 gxg192 CCN Project....
Changed :
*****************************************************************/
AS

PROCEDURE GENERATE_TCKT_BAG_DELTA_FILES(
/*********************************************************************** 
This Procedure is Wrapper procedure, which is used to generate
all difference files in server.

created : 01/13/2016 NXK927 CCN Project
changed :
************************************************************************/
    IN_LOAD_DATE IN DATE);

PROCEDURE GENERATE_GIFT_CARD_DELTA_FILE(
/*********************************************************************** 
This procedure is used to look for the missing and mismatched data 
in Mainframe files from POS data

Created : 12/16/2016 vxv336 CCN Team
Changed : 06/06/2016 gxg192 Changes to run the process for current date
************************************************************************/
IN_LOAD_DATE DATE);

END BANKING_RECONCILE_DIFF_REP_PKG;