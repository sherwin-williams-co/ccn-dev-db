/********************************************************************************** 
This script is used to delete data from MAILING_GROUP and MAILING_DETAILS tables.

Created : 08/06/2019 axm868 CCN Project CCNBN-12....
          Run this script in CCN_UTILITY
		  GROUP_ID = 48 is not deleted from MAILING_GROUP, as this GROUP_ID is used
		  for other mail categories in MAILING_DETAILS
Modified: 08/12/2019 axm868 CCN Project CCNBN-12....
          CCN team still needs to send “Deposit Bags Ordered Report” email to gpolsen@sherwin.com;brian.p.kusnic@sherwin.com and remove PrintCenter_Mac@Sherwin.com
          Also, they no longer need “Deposit Tickets Ordered Report” email.
**********************************************************************************/
SET DEFINE OFF;

SELECT * FROM MAILING_GROUP WHERE GROUP_ID IN(48,49,55,69,70,105);

SELECT * FROM MAILING_DETAILS WHERE MAIL_CATEGORY IN ('DEP_TICKORD_EXC_RPT','DEP_BAG_TICKORD_EXC_RPT','DEP_TICKORD_ERROR_RPT','DEP_BAGORD_ERROR_RPT','DEP_TICK_ONHAND_QTY_RPT','DEP_BAG_TICK_ONHAND_QTY_RPT','CC_TCKTS_NOT_EXISTS','CC_TCKT_BAG_NOT_EXISTS');

UPDATE MAILING_GROUP SET MAIL_ID = 'ccnsupport.team@sherwin.com;gpolsen@sherwin.com;brian.p.kusnic@sherwin.com' WHERE GROUP_ID = 55;
--Remove PrintCenter_Mac@Sherwin.com from this group

DELETE FROM MAILING_DETAILS WHERE MAIL_CATEGORY IN ('DEP_TICKORD_EXC_RPT','DEP_TICKORD_ERROR_RPT','DEP_BAGORD_ERROR_RPT','DEP_TICK_ONHAND_QTY_RPT','DEP_BAG_TICK_ONHAND_QTY_RPT','CC_TCKTS_NOT_EXISTS','CC_TCKT_BAG_NOT_EXISTS');
--DEP_BAG_TICKORD_EXC_RPT still need this email going

DELETE FROM MAILING_GROUP WHERE GROUP_ID IN(48,49,69,70,105);

SELECT * FROM MAILING_GROUP WHERE GROUP_ID IN(48,49,55,69,70,105);

SELECT * FROM MAILING_DETAILS WHERE MAIL_CATEGORY IN ('DEP_TICKORD_EXC_RPT','DEP_BAG_TICKORD_EXC_RPT','DEP_TICKORD_ERROR_RPT','DEP_BAGORD_ERROR_RPT','DEP_TICK_ONHAND_QTY_RPT','DEP_BAG_TICK_ONHAND_QTY_RPT','CC_TCKTS_NOT_EXISTS','CC_TCKT_BAG_NOT_EXISTS');

COMMIT;