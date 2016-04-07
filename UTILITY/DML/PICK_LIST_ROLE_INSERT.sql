/********************************************************************************
Below script will CCNPUS role code into ROLE_DETAILS for Credit Hierarchy Picklist

Created : 04/07/2016 sxh487 CCN Project Team....
Modified:
********************************************************************************/
SET DEFINE OFF;
Insert into ROLE_DETAILS (ROLE_CODE,ROLE_DESCRIPTION,ADMIN_FLAG,INSERT_FLAG,UPDATE_FLAG,SELECT_FLAG,USER_RULES,USER_RULES_DESCRIPTION) values ('CCNPUS','CCN Credit Hierarchy Picklist User Select','N','N','N','Y','<USER_RULES>
   <COST_CENTER_WINDOW>
      <VALUE>PICKLIST_WINDOW</VALUE>
   </COST_CENTER_WINDOW>
</USER_RULES>','<USER_RULES_DESCRIPTION>
   <COST_CENTER_WINDOW>
      <PICKLIST_WINDOW>
         <VALUE>CCNUS3</VALUE>
         <VALUE>CCNPUS</VALUE>
         <VALUE>HWCUS</VALUE>
      </PICKLIST_WINDOW>
   </COST_CENTER_WINDOW>
</USER_RULES_DESCRIPTION>');