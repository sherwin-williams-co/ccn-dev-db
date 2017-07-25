/**********************************************************

Script Name: HIERARCHY_DETAIL_FLDPRRPT_V.sql
Description: Script to create a view HIERARCHY_DETAIL_FLDPRRPT_V
             This view will be used in Field payroll system

Created  :
Modified : gxg192 06/01/2017 CCN Project....
           Changes to remove COST_CENTER field as it containing
           the same data as it is in COST_CENTER_CODE field.
         : 07/21/2017 gxg192 Reverted the previous changes. Added the COST_CENTER field back.
**********************************************************/

CREATE OR REPLACE VIEW HIERARCHY_DETAIL_FLDPRRPT_V AS
  SELECT STATEMENT_TYPE,
          HRCHY_HDR_NAME,
          COST_CENTER_CODE,
          HRCHY_DTL_EFF_DATE,
          HRCHY_DTL_EXP_DATE,
          DOMAIN,
          "GROUP",
          DIVISION,
          LEGACY_DIVISION,
          AREA,
          DISTRICT,
          CITY_SALES_MANAGER,
          "ZONE",
          SPECIAL_ROLES,
          COST_CENTER,
          DOMAIN_NAME,
          GROUP_NAME,
          DIVISION_NAME,
          LEGACY_DIVISION_NAME,
          AREA_NAME,
          DISTRICT_NAME,
          CITY_SALES_MANAGER_NAME,
          ZONE_NAME,
          SPECIAL_ROLES_NAME,
          COST_CENTER_NAME
     FROM HIERARCHY_DETAIL_VIEW;