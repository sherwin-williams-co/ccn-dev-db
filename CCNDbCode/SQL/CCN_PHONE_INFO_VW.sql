CREATE OR REPLACE FORCE VIEW COSTCNTR.CCN_PHONE_INFO_VW
(COST_CENTER_CODE, COST_CENTER_DESCRIPTION, PRIMARY_PHONE_NUMBER, SECONDARY_PHONE_NUMBER, FAX_PHONE_NUMBER)
AS 
SELECT DISTINCT cc.cost_center_code   cost_center_code,
                cc.cost_center_name   cost_center_description,
       (SELECT P.PHONE_AREA_CODE  P.phone_number
        FROM   costcntr.phone P
        WHERE  P.phone_number_type = 'PRI'
               AND P.cost_center_code = cc.cost_center_code)
       primary_phone_number,
       (SELECT P.PHONE_AREA_CODE P.phone_number
        FROM   costcntr.phone P
        WHERE  P.phone_number_type = 'SCD'
               AND P.cost_center_code = cc.cost_center_code)
       secondary_phone_number,
       (SELECT P.PHONE_AREA_CODE P.phone_number
        FROM   costcntr.phone P
        WHERE  P.phone_number_type = 'FAX'
               AND P.cost_center_code = cc.cost_center_code) 
               fax_phone_number
FROM   costcntr.cost_center cc;