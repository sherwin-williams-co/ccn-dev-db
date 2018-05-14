/*
created : 05/14/2018 jxc517/nxk927
         updating the upper level value as the value tag for employee name is missing
*/

--Development
SELECT * FROM HIERARCHY_DETAIL WHERE HRCHY_HDR_NAME = 'ADMINORG_HIERARCHY'
AND REPLACE(REPLACE(EXTRACT(UPPER_LVL_VER_VALUE,'/attributes').GETSTRINGVAL(), CHR(10)),' ') LIKE '%<Description>pkListValue</Description></upper_lvl_ver_desc>%';

UPDATE HIERARCHY_DETAIL
   SET UPPER_LVL_VER_VALUE = REPLACE(REPLACE(REPLACE(EXTRACT(UPPER_LVL_VER_VALUE,'/attributes').GETSTRINGVAL(), CHR(10)),' '),
                                     '<Description>pkListValue</Description></upper_lvl_ver_desc>',
                                     '<Description>pkListValue</Description><Value></Value></upper_lvl_ver_desc>')
 WHERE HRCHY_HDR_NAME = 'ADMINORG_HIERARCHY'
   AND REPLACE(REPLACE(EXTRACT(UPPER_LVL_VER_VALUE,'/attributes').GETSTRINGVAL(), CHR(10)),' ') LIKE '%<Description>pkListValue</Description></upper_lvl_ver_desc>%';


--Test
SELECT * FROM HIERARCHY_DETAIL WHERE HRCHY_HDR_NAME = 'ADMINORG_HIERARCHY'
AND REPLACE(REPLACE(EXTRACT(UPPER_LVL_VER_VALUE,'/attributes').GETSTRINGVAL(), CHR(10)),' ') LIKE '%<Description>Picklist Value</Description></upper_lvl_ver_desc>%';

UPDATE HIERARCHY_DETAIL
   SET UPPER_LVL_VER_VALUE = REPLACE(REPLACE(REPLACE(EXTRACT(UPPER_LVL_VER_VALUE,'/attributes').GETSTRINGVAL(), CHR(10)),' '),
                                     '<Description>Picklist Value</Description></upper_lvl_ver_desc>',
                                     '<Description>Picklist Value</Description><Value></Value></upper_lvl_ver_desc>')
 WHERE HRCHY_HDR_NAME = 'ADMINORG_HIERARCHY'
   AND REPLACE(REPLACE(EXTRACT(UPPER_LVL_VER_VALUE,'/attributes').GETSTRINGVAL(), CHR(10)),' ') LIKE '%<Description>Picklist Value</Description></upper_lvl_ver_desc>%';


SELECT * FROM HIERARCHY_DETAIL WHERE HRCHY_HDR_NAME = 'ADMINORG_HIERARCHY'
AND REPLACE(EXTRACT(UPPER_LVL_VER_VALUE,'/attributes').GETSTRINGVAL(), CHR(10)) LIKE '%<Description>Picklist Value</Description></upper_lvl_ver_desc>%';

UPDATE HIERARCHY_DETAIL
   SET UPPER_LVL_VER_VALUE = REPLACE(REPLACE(EXTRACT(UPPER_LVL_VER_VALUE,'/attributes').GETSTRINGVAL(), CHR(10)),
                                             '<Description>Picklist Value</Description></upper_lvl_ver_desc>',
                                             '<Description>Picklist Value</Description><Value></Value></upper_lvl_ver_desc>')
 WHERE HRCHY_HDR_NAME = 'ADMINORG_HIERARCHY'
   AND REPLACE(EXTRACT(UPPER_LVL_VER_VALUE,'/attributes').GETSTRINGVAL(), CHR(10)) LIKE '%<Description>Picklist Value</Description></upper_lvl_ver_desc>%';
 -- AND HRCHY_DTL_CURR_LVL_VAL = '0000200020002010800949';
COMMIT;