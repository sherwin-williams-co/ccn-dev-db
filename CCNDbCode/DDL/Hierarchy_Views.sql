
  CREATE OR REPLACE FORCE VIEW "COSTCNTR"."HIERARCHY_DETAIL_DESC_VIEW" ("HRCHY_HDR_NAME", "HRCHY_DTL_LEVEL", "HRCHY_DTL_DESC", "HRCHY_DTL_CURR_LVL_VAL") AS 
  SELECT DISTINCT hr.HRCHY_HDR_NAME,
                  hr.HRCHY_DTL_LEVEL,
                  hr.HRCHY_DTL_DESC,
                  hr.HRCHY_DTL_CURR_LVL_VAL
    FROM HIERARCHY_DETAIL hr
   WHERE HRCHY_HDR_NAME         = 'GLOBAL_HIERARCHY';
/


  CREATE OR REPLACE FORCE VIEW "COSTCNTR"."HIERARCHY_DETAIL_VIEW" ("STATEMENT_TYPE", "HRCHY_HDR_NAME", "COST_CENTER_CODE", "HRCHY_DTL_EFF_DATE", "HRCHY_DTL_EXP_DATE", "DOMAIN", "GROUP", "DIVISION", "LEGACY_DIVISION", "AREA", "DISTRICT", "CITY_SALES_MANAGER", "ZONE", "SPECIAL_ROLES", "COST_CENTER", "DOMAIN_NAME", "GROUP_NAME", "DIVISION_NAME", "LEGACY_DIVISION_NAME", "AREA_NAME", "DISTRICT_NAME", "CITY_SALES_MANAGER_NAME", "ZONE_NAME", "SPECIAL_ROLES_NAME", "COST_CENTER_NAME") AS 
  select statement_type,
       HRCHY_HDR_NAME,
       HRCHY_DTL_CURR_ROW_VAL COST_CENTER_CODE,
       HRCHY_DTL_EFF_DATE,
       HRCHY_DTL_EXP_DATE,
       --HRCHY_HDR_LVL_NBR,
         MAX(DECODE(HRCHY_HDR_LVL_NBR,1,val)) AS Domain,
         MAX(DECODE(HRCHY_HDR_LVL_NBR,2,val)) AS "GROUP",
         MAX(DECODE(HRCHY_HDR_LVL_NBR,3,val)) AS Division,
         MAX(DECODE(HRCHY_HDR_LVL_NBR,CASE HRCHY_HDR_NAME
                                      WHEN 'LEGACY_GL_DIVISION' THEN 4
                                      ELSE NULL
                                      END,val)) AS Legacy_Division,
         MAX(DECODE(HRCHY_HDR_LVL_NBR,CASE HRCHY_HDR_NAME
                                      WHEN 'ADMIN_TO_SALES_DISTRICT' THEN 4
                                      WHEN 'ADMIN_TO_SALES_AREA' THEN 4
                                      WHEN 'ALTERNATE_DAD' THEN 4
                                      WHEN 'GLOBAL_HIERARCHY' THEN 4
                                      ELSE NULL
                                      END,val)) AS Area,
         MAX(DECODE(HRCHY_HDR_LVL_NBR,CASE HRCHY_HDR_NAME
                                      WHEN 'ADMIN_TO_SALES_DISTRICT' THEN 5
                                      WHEN 'ALTERNATE_DAD' THEN 5
                                      WHEN 'GLOBAL_HIERARCHY' THEN 5
                                      ELSE NULL
                                      END,val)) AS District,
         MAX(DECODE(HRCHY_HDR_LVL_NBR,CASE HRCHY_HDR_NAME
                                      WHEN 'ADMIN_TO_SALES_DISTRICT' THEN 6
                                      WHEN 'ALTERNATE_DAD' THEN 6
                                      WHEN 'GLOBAL_HIERARCHY' THEN 6
                                      ELSE NULL
                                      END,val)) AS City_Sales_Manager,
         MAX(DECODE(HRCHY_HDR_LVL_NBR,CASE HRCHY_HDR_NAME
                                      WHEN 'ADMIN_TO_SALES_DISTRICT' THEN 7
                                      WHEN 'ALTERNATE_DAD' THEN 7
                                      WHEN 'GLOBAL_HIERARCHY' THEN 7
                                      ELSE NULL
                                      END,val)) AS "ZONE",
         MAX(DECODE(HRCHY_HDR_LVL_NBR,CASE HRCHY_HDR_NAME
                                      WHEN 'ADMIN_TO_SALES_DISTRICT' THEN 8
                                      WHEN 'ALTERNATE_DAD' THEN 8
                                      WHEN 'GLOBAL_HIERARCHY' THEN 8
                                      ELSE NULL
                                      END,val)) AS Special_Roles,
         MAX(DECODE(HRCHY_HDR_LVL_NBR,CASE HRCHY_HDR_NAME
                                      WHEN 'ADMIN_TO_SALES_DISTRICT' THEN 9
                                      WHEN 'ALTERNATE_DAD' THEN 9
                                      WHEN 'GLOBAL_HIERARCHY' THEN 9
                                      WHEN 'LEGACY_GL_DIVISION' THEN 5
                                      WHEN 'ADMIN_TO_SALES_AREA' THEN 5
                                      WHEN 'FACTS_DIVISION' THEN 4
                                      WHEN 'ADMIN_TO_SALES_DIVISION' THEN 4
                                      ELSE NULL
                                      END,val)) AS Cost_Center,
         MAX(DECODE(HRCHY_HDR_LVL_NBR,1,description)) AS Domain_Name,
         MAX(DECODE(HRCHY_HDR_LVL_NBR,2,description)) AS Group_Name,
         MAX(DECODE(HRCHY_HDR_LVL_NBR,3,description)) AS Division_Name,
         MAX(DECODE(HRCHY_HDR_LVL_NBR,CASE HRCHY_HDR_NAME
                                      WHEN 'LEGACY_GL_DIVISION' THEN 4
                                      ELSE NULL
                                      END,description)) AS Legacy_Division_Name,
         MAX(DECODE(HRCHY_HDR_LVL_NBR,CASE HRCHY_HDR_NAME
                                      WHEN 'ADMIN_TO_SALES_DISTRICT' THEN 4
                                      WHEN 'ADMIN_TO_SALES_AREA' THEN 4
                                      WHEN 'ALTERNATE_DAD' THEN 4
                                      WHEN 'GLOBAL_HIERARCHY' THEN 4
                                      ELSE NULL
                                      END,description)) AS Area_Name,
         MAX(DECODE(HRCHY_HDR_LVL_NBR,CASE HRCHY_HDR_NAME
                                      WHEN 'ADMIN_TO_SALES_DISTRICT' THEN 5
                                      WHEN 'ALTERNATE_DAD' THEN 5
                                      WHEN 'GLOBAL_HIERARCHY' THEN 5
                                      ELSE NULL
                                      END,description)) AS District_Name,
         MAX(DECODE(HRCHY_HDR_LVL_NBR,CASE HRCHY_HDR_NAME
                                      WHEN 'ADMIN_TO_SALES_DISTRICT' THEN 6
                                      WHEN 'ALTERNATE_DAD' THEN 6
                                      WHEN 'GLOBAL_HIERARCHY' THEN 6
                                      ELSE NULL
                                      END,description)) AS City_Sales_Manager_Name,
         MAX(DECODE(HRCHY_HDR_LVL_NBR,CASE HRCHY_HDR_NAME
                                      WHEN 'ADMIN_TO_SALES_DISTRICT' THEN 7
                                      WHEN 'ALTERNATE_DAD' THEN 7
                                      WHEN 'GLOBAL_HIERARCHY' THEN 7
                                      ELSE NULL
                                      END,description)) AS Zone_Name,
         MAX(DECODE(HRCHY_HDR_LVL_NBR,CASE HRCHY_HDR_NAME
                                      WHEN 'ADMIN_TO_SALES_DISTRICT' THEN 8
                                      WHEN 'ALTERNATE_DAD' THEN 8
                                      WHEN 'GLOBAL_HIERARCHY' THEN 8
                                      ELSE NULL
                                      END,description)) AS Special_Roles_Name,
         MAX(DECODE(HRCHY_HDR_LVL_NBR,CASE HRCHY_HDR_NAME
                                      WHEN 'ADMIN_TO_SALES_DISTRICT' THEN 9
                                      WHEN 'ALTERNATE_DAD' THEN 9
                                      WHEN 'GLOBAL_HIERARCHY' THEN 9
                                      WHEN 'LEGACY_GL_DIVISION' THEN 5
                                      WHEN 'ADMIN_TO_SALES_AREA' THEN 5
                                      WHEN 'FACTS_DIVISION' THEN 4
                                      WHEN 'ADMIN_TO_SALES_DIVISION' THEN 4
                                      ELSE NULL
                                      END,description)) AS Cost_Center_Name
 from (
select --hd.hrchy_dtl_curr_lvl_val,
       substr(hd.hrchy_dtl_curr_lvl_val,1 + (select NVL(sum(LVL_VALUE_SIZE),0)
                                               from hierarchy_description
                                              where HRCHY_HDR_LVL_NBR < hdesc.HRCHY_HDR_LVL_NBR
                                                and HRCHY_HDR_NAME = hd.HRCHY_HDR_NAME),hdesc.lvl_value_size) val,
       (select HRCHY_DTL_DESC
          from hierarchy_detail
         where HRCHY_DTL_CURR_LVL_VAL||'' = substr(hd.hrchy_dtl_curr_lvl_val,1,(select sum(LVL_VALUE_SIZE)
                                                                             from hierarchy_description
                                                                            where HRCHY_HDR_LVL_NBR <= hdesc.HRCHY_HDR_LVL_NBR
                                                                              and HRCHY_HDR_NAME = hd.HRCHY_HDR_NAME))
           and HRCHY_HDR_NAME = hd.HRCHY_HDR_NAME
           and HRCHY_DTL_LEVEL = hdesc.HRCHY_HDR_LVL_NBR
           and rownum < 2) description,
       cc.statement_type,
       hd.HRCHY_HDR_NAME,
       hdesc.HRCHY_HDR_LVL_NBR,
       hd.HRCHY_DTL_CURR_ROW_VAL,
       hd.HRCHY_DTL_EFF_DATE,
       hd.HRCHY_DTL_EXP_DATE
  from hierarchy_description hdesc,
       hierarchy_detail hd,
       cost_center cc
 where cc.cost_center_code = hd.HRCHY_DTL_CURR_ROW_VAL
   and hd.HRCHY_HDR_NAME = hdesc.HRCHY_HDR_NAME
   and nvl(hd.hrchy_dtl_next_lvl_val,'~~~') = '~~~'
   --and cc.cost_center_code = '708090'
   )
   --where HRCHY_DTL_CURR_ROW_VAL = '708092'
 group by statement_type,HRCHY_HDR_NAME,HRCHY_DTL_CURR_ROW_VAL,HRCHY_DTL_EFF_DATE, HRCHY_DTL_EXP_DATE;
/
