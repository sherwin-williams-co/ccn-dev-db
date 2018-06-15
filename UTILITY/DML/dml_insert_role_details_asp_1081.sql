/*##############################################################################################################
Created : 06/15/2018 sxg151 CCN Project Team..
          This script creates a new role 'HWUAOS' and assign to Andrew's Team
          'jam01s'(Jamie Mertz),'jap203'(Jeffrey Pietrasz),'ajl964'(Andrew Lombardo)

--#############################################################################################################*/


Insert into ROLE_DETAILS values ('HWUAGS','Hierarchy Window User - AdminOrg and Global Hierarchy Select','N','N','N','Y',
'<USER_RULES>
   <HIERARCHY_WINDOW>
      <VALUE>HIERARCHY_NAME</VALUE>
   </HIERARCHY_WINDOW>
</USER_RULES>',
'<USER_RULES_DESCRIPTION>
   <HIERARCHY_WINDOW>
      <HIERARCHY_NAME>
         <VALUE>ADMINORG_HIERARCHY</VALUE>
         <VALUE>GLOBAL_HIERARCHY</VALUE>
      </HIERARCHY_NAME>
   </HIERARCHY_WINDOW>
</USER_RULES_DESCRIPTION>');



insert into SECURITY_MATRIX values ('jam01s','jam01s','HWUAGS');
insert into SECURITY_MATRIX values ('jap203','jap203','HWUAGS');
insert into SECURITY_MATRIX values ('ajl964','ajl964','HWUAGS');

COMMIT;


select * from security_matrix where user_id in ('jam01s','jap203','ajl964');