/**********************************************************************************
This script is created to create a role in ROLE_DETAILS table for providing access to Hierarchy Report button.

Created : 07/13/2018 pxa852 CCN Project ASP-1068....
Modified:
**********************************************************************************/
-- INSERTING into ROLE_DETAILS

SET DEFINE OFF;

INSERT INTO ROLE_DETAILS VALUES ('HWRU', 'HWRU - Cost center hierarchies report user', 'N','N','N','Y',
'<USER_RULES>
   <HIERARCHY_WINDOW>
      <VALUE>HIERARCHY_ACTIONS</VALUE>
   </HIERARCHY_WINDOW>
</USER_RULES>', 
'<USER_RULES_DESCRIPTION>
   <HIERARCHY_WINDOW>
      <HIERARCHY_ACTIONS>
         <VALUE>HIERARCHY_REPORT</VALUE>
      </HIERARCHY_ACTIONS>
   </HIERARCHY_WINDOW>
</USER_RULES_DESCRIPTION>');

commit;