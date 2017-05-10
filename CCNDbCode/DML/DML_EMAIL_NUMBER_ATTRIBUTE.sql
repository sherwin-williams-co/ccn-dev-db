/*
     Created: 05/10/2017 axt754 CCN Project Team..
     DML script for inserting EMAIL_NUMBER attribute into HIERARCHY_DESCRIPTION table
     to CREDIT_HIERARCHY at district level i.e., level 4
*/
-- MANUAL BACKUP before doing transactiion 
/*
 SELECT * 
   FROM HIERARCHY_DESCRIPTION
  WHERE HRCHY_HDR_NAME = 'CREDIT_HIERARCHY' 
    AND HRCHY_HDR_LVL_NBR = 4
*/

-- Delete EMAIL_NUMBER attribute if exists from HIERARCHY_DESCRIPTION table
/*
UPDATE HIERARCHY_DESCRIPTION 
   SET UPPER_LVL_VER_VALUE = deleteXML(UPPER_LVL_VER_VALUE,
                           '//attributes/upper_lvl_ver_desc[5]')
 WHERE HRCHY_HDR_NAME = 'CREDIT_HIERARCHY' 
   AND HRCHY_HDR_LVL_NBR = 4;
*/

-- INSERT EMAIL_NUMBER attribute into HIERARCHY_DESCRIPTION table
UPDATE HIERARCHY_DESCRIPTION
   SET UPPER_LVL_VER_VALUE = XMLTYPE(REPLACE(EXTRACT(UPPER_LVL_VER_VALUE, '/attributes'),
                                             '</attributes>',
                                             '<upper_lvl_ver_desc><Name>EMAIL_NUMBER</Name><Description>pkListValue</Description><ATTRIBUTE_VALUE_SIZE>3</ATTRIBUTE_VALUE_SIZE></upper_lvl_ver_desc>'||'</attributes>'))
 WHERE HRCHY_HDR_NAME = 'CREDIT_HIERARCHY' 
   AND HRCHY_HDR_LVL_NBR = 4;
   
-- COMMIT Trasanction 
--COMMIT;