CREATE OR REPLACE VIEW CCN_PHONE_INFO_VW
AS 
SELECT 
/*********************************************************** 
  This view will have all the phone numbers, secondary numbers and the 
  fax number for all the cost centers
  created  : 
  modified : 09/24/2015 nxk927 
             added the comment 
	************************************************************/
       DISTINCT CC.COST_CENTER_CODE   COST_CENTER_CODE,
                CC.COST_CENTER_NAME   COST_CENTER_DESCRIPTION,
                COMMON_TOOLS.GET_PHONE_NUMBER ( CC.COST_CENTER_CODE, 'PRI')  PRIMARY_PHONE_NUMBER,
                COMMON_TOOLS.GET_PHONE_NUMBER ( CC.COST_CENTER_CODE, 'SCD')  SECONDARY_PHONE_NUMBER,
                COMMON_TOOLS.GET_PHONE_NUMBER ( CC.COST_CENTER_CODE, 'FAX')  FAX_PHONE_NUMBER                
                FROM COST_CENTER CC;

CREATE OR REPLACE SYNONYM CCN_PHONE_INFO FOR CCN_PHONE_INFO_VW;