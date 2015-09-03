SET SCAN OFF;
--INSERTING into ROLE_DETAILS
Insert into ROLE_DETAILS values ('HWD1','Hierarchy Window Developer','N','Y','Y','Y',
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
         <VALUE>SALES_MANAGER_HIERARCHY</VALUE>
         <VALUE>ADMIN_TO_SALES_DISTRICT</VALUE>
         <VALUE>ADMIN_TO_SALES_DIVISION</VALUE>
         <VALUE>ALTERNATE_DAD</VALUE>
         <VALUE>LEGACY_GL_DIVISION</VALUE>
         <VALUE>FACTS_DIVISION</VALUE>
		 <VALUE>PRICE_DISTRICT</VALUE>
      </HIERARCHY_NAME>
   </HIERARCHY_WINDOW>
</USER_RULES_DESCRIPTION>');

--INSERTING into SECURITY_MATRIX
Insert into SECURITY_MATRIX values ('kdp465','kdppswrd','HWD1');
Insert into SECURITY_MATRIX values ('jxc517','jxc517','HWD1');
Insert into SECURITY_MATRIX values ('sxh487','sxh487','HWD1');
Insert into SECURITY_MATRIX values ('nxk927','nxk927','HWD1');
Insert into SECURITY_MATRIX values ('axk326','axk326','HWD1');
Insert into SECURITY_MATRIX values ('dxv848','dxv848','HWD1');
Insert into SECURITY_MATRIX values ('sxt410','sxt410','HWD1');

Insert into SECURITY_MATRIX values ('SXK696','SXK696','HWD1');
Insert into SECURITY_MATRIX values ('axc415','what','HWD1');
Insert into SECURITY_MATRIX values ('axc539','mdh000','HWD1');
Insert into SECURITY_MATRIX values ('sxd392','sxd392','HWD1');
Insert into SECURITY_MATRIX values ('sxr128','sxr128','HWD1');
Insert into SECURITY_MATRIX values ('mxa875','mxa875','HWD1');


COMMIT;