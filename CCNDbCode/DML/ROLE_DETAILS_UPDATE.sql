/********************************************************************
03/03/2016 sxh487  CCN Project Team. 
Updating ROLE_DETAILS table for ROLE_CODE 'HWD', 'HWA' and 'HWB' to add Credit Hierarchy
*********************************************************************/
UPDATE ROLE_DETAILS 
   SET USER_RULES_DESCRIPTION = '<USER_RULES_DESCRIPTION>
   <HIERARCHY_WINDOW>
      <HIERARCHY_NAME>
         <VALUE>GLOBAL_HIERARCHY</VALUE>
         <VALUE>ADMIN_TO_SALES_AREA</VALUE>
         <VALUE>SALES_MANAGER_HIERARCHY</VALUE>
         <VALUE>ADMIN_TO_SALES_DISTRICT</VALUE>
         <VALUE>ADMIN_TO_SALES_DIVISION</VALUE>
         <VALUE>ALTERNATE_DAD</VALUE>
         <VALUE>LEGACY_GL_DIVISION</VALUE>
         <VALUE>FACTS_DIVISION</VALUE>
         <VALUE>PRICE_DISTRICT</VALUE>
         <VALUE>CREDIT_HIERARCHY</VALUE>
      </HIERARCHY_NAME>
   </HIERARCHY_WINDOW>
</USER_RULES_DESCRIPTION>'
WHERE ROLE_CODE IN  ('HWA', 'HWB', 'HWD') ;

COMMIT;
