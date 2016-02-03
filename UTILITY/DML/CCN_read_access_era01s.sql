---giving read only acces to era01s
---cost center window and the global hierarchy window
---nxk927 02/03/2016

SET SCAN OFF;
--INSERTING into ROLE_DETAILS 
Insert into ROLE_DETAILS values ('HWGUS','Global Hierarchy Window User','N','N','N','Y',
'<USER_RULES>
   <HIERARCHY_WINDOW>
      <VALUE>HIERARCHY_NAME</VALUE>
   </HIERARCHY_WINDOW>
</USER_RULES>',
'<USER_RULES_DESCRIPTION>
   <HIERARCHY_WINDOW>
      <HIERARCHY_NAME>
         <VALUE>GLOBAL_HIERARCHY</VALUE>
      </HIERARCHY_NAME>
   </HIERARCHY_WINDOW>
</USER_RULES_DESCRIPTION>');

--INSERTING into SECURITY_MATRIX
Insert into SECURITY_MATRIX values ('era01s','era01s','HWGUS');
Insert into SECURITY_MATRIX values ('era01s','era01s','CCNUS1');
COMMIT;

