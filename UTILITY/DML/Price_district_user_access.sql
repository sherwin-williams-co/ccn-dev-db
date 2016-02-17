--new role code for price district hierarchy and giving access to rab54r, rae4gr, jmk01r, ems17r
--nxk927 CCN Project 02/17/2016
SET SCAN OFF;
--INSERTING into ROLE_DETAILS
Insert into ROLE_DETAILS values ('HWU2','Hierarchy Window Price District User','Y','Y','Y','Y',
'<USER_RULES>
   <HIERARCHY_WINDOW>
      <VALUE>HIERARCHY_NAME</VALUE>
   </HIERARCHY_WINDOW>
</USER_RULES>',
'<USER_RULES_DESCRIPTION>
   <HIERARCHY_WINDOW>
      <HIERARCHY_NAME>
         <VALUE>PRICE_DISTRICT</VALUE>
      </HIERARCHY_NAME>
   </HIERARCHY_WINDOW>
</USER_RULES_DESCRIPTION>');

--INSERTING into SECURITY_MATRIX
Insert into SECURITY_MATRIX values ('rab54r','rab54r','HWU2');
Insert into SECURITY_MATRIX values ('rae4gr','rae4gr','HWU2');
Insert into SECURITY_MATRIX values ('jmk01r','jmk01r','HWU2');
Insert into SECURITY_MATRIX values ('ems17r','ems17r','HWU2');

COMMIT;


