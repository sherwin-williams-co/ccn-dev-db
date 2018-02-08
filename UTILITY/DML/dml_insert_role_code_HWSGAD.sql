/*
     dml_insert_role_code_HWSGAD.sql
     Created : 02/08/2018 CCN Project Team....
     This Script Inserts the role_code HWSGAD, and assigns this role code for tls01d
*/
 -- Insert Role code
INSERT INTO ROLE_DETAILS VALUES ('HWSGAD','Hierarchy Window User - Select Global and ADMIN TO SALES','N','N','N','Y',
'<USER_RULES>
   <HIERARCHY_WINDOW>
      <VALUE>HIERARCHY_NAME</VALUE>
   </HIERARCHY_WINDOW>
</USER_RULES>',
'<USER_RULES_DESCRIPTION>
   <HIERARCHY_WINDOW>
      <HIERARCHY_NAME>
         <VALUE>GLOBAL_HIERARCHY</VALUE>
         <VALUE>ADMIN_TO_SALES_AREA</VALUE>
         <VALUE>ADMIN_TO_SALES_DISTRICT</VALUE>
         <VALUE>ADMIN_TO_SALES_DIVISION</VALUE>
      </HIERARCHY_NAME>
   </HIERARCHY_WINDOW>
</USER_RULES_DESCRIPTION>
');

-- Check if the Role code is inserted properly. 
SELECT * FROM ROLE_DETAILS WHERE ROLE_CODE = 'HWSGAD';

-- Check the roles for 'tls01d'
SELECT * FROM SECURITY_MATRIX WHERE UPPER(USER_ID) = 'TLS01D';

-- assign newly created role code to 'tls01d'
INSERT INTO SECURITY_MATRIX VALUES ('tls01d','tls01d','HWSGAD');

-- Check the roles for 'tls01d'
SELECT * FROM SECURITY_MATRIX WHERE UPPER(USER_ID) = 'TLS01D';

-- Commit The Transaction
COMMIT;
