CREATE OR REPLACE VIEW STORE_MAIN_VW
AS 
SELECT  
/**********************************************************
This view holds required information about STORE
such as Store number, Zone code, Statement type, Store name,Store open/close date, 
Status, Status description, Cost center Type, Cost center and Mission code.

Created : 12/11/2014 SXT410 CCN project
Modified: 01/23/2014 jxc517 CCN Project....
**********************************************************/ 
      SUBSTR(CC.COST_CENTER_CODE,3) STORE_NUMBER,
       CC.COST_CENTER_CODE,
       CC.COST_CENTER_NAME,
       CC.STATEMENT_TYPE,
       CC.OPEN_DATE,
       CC.CLOSE_DATE,
       S.STATUS_CODE,
       CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('STATUS_CODE','COD',S.STATUS_CODE) STATUS_DESCRIPTION,
       CCN_HIERARCHY.GET_TYPE_FNC(CC.COST_CENTER_CODE) TYPE,
       CC.MISSION_TYPE_CODE,
       (SELECT RURAL_METRO_ZONE_CODE 
          FROM STORE 
         WHERE COST_CENTER_CODE = CC.COST_CENTER_CODE) RURAL_METRO_ZONE_CODE
  FROM COST_CENTER CC,
       STATUS S
 WHERE CC.COST_CENTER_CODE = S.COST_CENTER_CODE
   AND S.EXPIRATION_DATE IS NULL;