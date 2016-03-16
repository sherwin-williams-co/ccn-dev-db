/********************************************************************************
Below script will insert into ROLE_DETAILS for Credit Hierarchy

Created : 03/14/2016 sxh487 CCN Project Team....
Modified:
********************************************************************************/
SET DEFINE OFF;
Insert into ROLE_DETAILS (ROLE_CODE,ROLE_DESCRIPTION,ADMIN_FLAG,INSERT_FLAG,UPDATE_FLAG,SELECT_FLAG,USER_RULES,USER_RULES_DESCRIPTION) values ('CCNUS3','CCN User - Main Window Select for Credit User','N','N','N','Y','<USER_RULES>
   <COST_CENTER_WINDOW>
      <VALUE>COST_CENTER_UI_VALUES</VALUE>
   </COST_CENTER_WINDOW>
</USER_RULES>','<USER_RULES_DESCRIPTION>
   <COST_CENTER_WINDOW>
      <CCN_UI_ALLOWED>
         <VALUE>CCN_MAIN</VALUE>
      </CCN_UI_ALLOWED>
   </COST_CENTER_WINDOW>
</USER_RULES_DESCRIPTION>');

Insert into ROLE_DETAILS (ROLE_CODE,ROLE_DESCRIPTION,ADMIN_FLAG,INSERT_FLAG,UPDATE_FLAG,SELECT_FLAG,USER_RULES,USER_RULES_DESCRIPTION) values ('HWCUS','Hierarchy Window User -  Credit Hierarchy Select','N','N','N','Y','<USER_RULES>
   <HIERARCHY_WINDOW>
      <VALUE>HIERARCHY_NAME</VALUE>
   </HIERARCHY_WINDOW>
</USER_RULES>','<USER_RULES_DESCRIPTION>
   <HIERARCHY_WINDOW>
      <HIERARCHY_NAME>
         <VALUE>CREDIT_HIERARCHY</VALUE>
      </HIERARCHY_NAME>
   </HIERARCHY_WINDOW>
</USER_RULES_DESCRIPTION>');

Insert into ROLE_DETAILS (ROLE_CODE,ROLE_DESCRIPTION,ADMIN_FLAG,INSERT_FLAG,UPDATE_FLAG,SELECT_FLAG,USER_RULES,USER_RULES_DESCRIPTION) values ('HWCU','Hierarchy Window Credit Hierarchy Edit User','Y','Y','Y','Y','<USER_RULES>
   <HIERARCHY_WINDOW>
      <VALUE>HIERARCHY_NAME</VALUE>
   </HIERARCHY_WINDOW>
</USER_RULES>','<USER_RULES_DESCRIPTION>
   <HIERARCHY_WINDOW>
      <HIERARCHY_NAME>
         <VALUE>CREDIT_HIERARCHY</VALUE>
      </HIERARCHY_NAME>
   </HIERARCHY_WINDOW>
</USER_RULES_DESCRIPTION>');

--Adding users to the new Role Code - Cost Center Window
--INSERTING into SECURITY_MATRIX - Cost Center - select
Insert into SECURITY_MATRIX values ('alwser','alwser','CCNUS3');
Insert into SECURITY_MATRIX values ('bar99r','bar99r','CCNUS3');
Insert into SECURITY_MATRIX values ('cll316','cll316','CCNUS3');
Insert into SECURITY_MATRIX values ('gxm577','gxm577','CCNUS3');
Insert into SECURITY_MATRIX values ('hij565','hij565','CCNUS3');
Insert into SECURITY_MATRIX values ('jxd347','jxd347','CCNUS3');
Insert into SECURITY_MATRIX values ('jxm474','jxm474','CCNUS3');
Insert into SECURITY_MATRIX values ('jxx183','jxx183','CCNUS3');
Insert into SECURITY_MATRIX values ('kaftzr','kaftzr','CCNUS3');
Insert into SECURITY_MATRIX values ('kxb659','kxb659','CCNUS3');
Insert into SECURITY_MATRIX values ('kxt175','kxt175','CCNUS3');
Insert into SECURITY_MATRIX values ('kxt851','kxt851','CCNUS3');
Insert into SECURITY_MATRIX values ('mxm309','mxm309','CCNUS3');
Insert into SECURITY_MATRIX values ('mxv771','mxv771','CCNUS3');
Insert into SECURITY_MATRIX values ('nxk96r','nxk96r','CCNUS3');
Insert into SECURITY_MATRIX values ('nxs290','nxs290','CCNUS3');
Insert into SECURITY_MATRIX values ('ras46r','ras46r','CCNUS3');
Insert into SECURITY_MATRIX values ('rbdarr','rbdarr','CCNUS3');
Insert into SECURITY_MATRIX values ('rdsw6r','rdsw6r','CCNUS3');
Insert into SECURITY_MATRIX values ('rxk163','rxk163','CCNUS3');
Insert into SECURITY_MATRIX values ('rxm383','rxm383','CCNUS3');
Insert into SECURITY_MATRIX values ('sxk419','sxk419','CCNUS3');
Insert into SECURITY_MATRIX values ('tadarr','tadarr','CCNUS3');
Insert into SECURITY_MATRIX values ('wxn683','wxn683','CCNUS3');
Insert into SECURITY_MATRIX values ('ydrpur','ydrpur','CCNUS3');
Insert into SECURITY_MATRIX values ('yxz430','yxz430','CCNUS3');
Insert into SECURITY_MATRIX values ('cmaarr','cmaarr','CCNUS3');
Insert into SECURITY_MATRIX values ('pmm4br','pmm4br','CCNUS3');
Insert into SECURITY_MATRIX values ('jep01r','jep01r','CCNUS3');

--INSERTING into SECURITY_MATRIX - credit users select
Insert into SECURITY_MATRIX values ('alwser','alwser','HWCUS1');
Insert into SECURITY_MATRIX values ('bar99r','bar99r','HWCUS1');
Insert into SECURITY_MATRIX values ('cll316','cll316','HWCUS1');
Insert into SECURITY_MATRIX values ('gxm577','gxm577','HWCUS1');
Insert into SECURITY_MATRIX values ('hij565','hij565','HWCUS1');
Insert into SECURITY_MATRIX values ('jxd347','jxd347','HWCUS1');
Insert into SECURITY_MATRIX values ('jxm474','jxm474','HWCUS1');
Insert into SECURITY_MATRIX values ('jxx183','jxx183','HWCUS1');
Insert into SECURITY_MATRIX values ('kaftzr','kaftzr','HWCUS1');
Insert into SECURITY_MATRIX values ('kxb659','kxb659','HWCUS1');
Insert into SECURITY_MATRIX values ('kxt175','kxt175','HWCUS1');
Insert into SECURITY_MATRIX values ('kxt851','kxt851','HWCUS1');
Insert into SECURITY_MATRIX values ('mxm309','mxm309','HWCUS1');
Insert into SECURITY_MATRIX values ('mxv771','mxv771','HWCUS1');
Insert into SECURITY_MATRIX values ('nxk96r','nxk96r','HWCUS1');
Insert into SECURITY_MATRIX values ('nxs290','nxs290','HWCUS1');
Insert into SECURITY_MATRIX values ('ras46r','ras46r','HWCUS1');
Insert into SECURITY_MATRIX values ('rbdarr','rbdarr','HWCUS1');
Insert into SECURITY_MATRIX values ('rdsw6r','rdsw6r','HWCUS1');
Insert into SECURITY_MATRIX values ('rxk163','rxk163','HWCUS1');
Insert into SECURITY_MATRIX values ('rxm383','rxm383','HWCUS1');
Insert into SECURITY_MATRIX values ('sxk419','sxk419','HWCUS1');
Insert into SECURITY_MATRIX values ('tadarr','tadarr','HWCUS1');
Insert into SECURITY_MATRIX values ('wxn683','wxn683','HWCUS1');
Insert into SECURITY_MATRIX values ('ydrpur','ydrpur','HWCUS1');
Insert into SECURITY_MATRIX values ('yxz430','yxz430','HWCUS1');

--INSERTING into SECURITY_MATRIX - HWCU - Credit User
Insert into SECURITY_MATRIX values ('kdp465','kdppswrd','CCNCU');
Insert into SECURITY_MATRIX values ('jxc517','jxc517','CCNCU');
Insert into SECURITY_MATRIX values ('sxh487','sxh487','CCNCU');
Insert into SECURITY_MATRIX values ('nxk927','nxk927','CCNCU');
Insert into SECURITY_MATRIX values ('axk326','axk326','CCNCU');
Insert into SECURITY_MATRIX values ('dxv848','dxv848','CCNCU');
Insert into SECURITY_MATRIX values ('axd783','axd783','CCNCU');
Insert into SECURITY_MATRIX values ('mxr916','mxr916','CCNCU');

Insert into SECURITY_MATRIX values ('sxk696','sxk696','CCNCU');
Insert into SECURITY_MATRIX values ('axc415','what','CCNCU');
Insert into SECURITY_MATRIX values ('axc539','mdh000','CCNCU');
Insert into SECURITY_MATRIX values ('sxd392','sxd392','CCNCU');
Insert into SECURITY_MATRIX values ('sxr128','sxr128','CCNCU');
Insert into SECURITY_MATRIX values ('mxa875','mxa875','CCNCU');

--INSERTING into SECURITY_MATRIX - credit users
Insert into SECURITY_MATRIX values ('cmaarr','cmaarr','CCNCU');
Insert into SECURITY_MATRIX values ('pmm4br','pmm4br','CCNCU');
Insert into SECURITY_MATRIX values ('jep01r','jep01r','CCNCU');

COMMIT;
