/********************************************************************************
Below script will insert into ROLE_DETAILS for Credit Hierarchy in PRODUCTION

Created : 11/02/2016 vxv336 CCN Project Team
Modified: 

NOTE: This script is for PRODUCTION only. Do not execute this on any of the lower environments. 
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

Insert into ROLE_DETAILS (ROLE_CODE,ROLE_DESCRIPTION,ADMIN_FLAG,INSERT_FLAG,UPDATE_FLAG,SELECT_FLAG,USER_RULES,USER_RULES_DESCRIPTION) values ('HWCU','Hierarchy Window Credit Hierarchy User','Y','Y','Y','Y','<USER_RULES>
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

--INSERTING into SECURITY_MATRIX - credit users select
Insert into SECURITY_MATRIX values ('alwser','alwser','HWCUS');
Insert into SECURITY_MATRIX values ('bar99r','bar99r','HWCUS');
Insert into SECURITY_MATRIX values ('cll316','cll316','HWCUS');
Insert into SECURITY_MATRIX values ('gxm577','gxm577','HWCUS');
Insert into SECURITY_MATRIX values ('hij565','hij565','HWCUS');
Insert into SECURITY_MATRIX values ('jxd347','jxd347','HWCUS');
Insert into SECURITY_MATRIX values ('jxm474','jxm474','HWCUS');
Insert into SECURITY_MATRIX values ('jxx183','jxx183','HWCUS');
Insert into SECURITY_MATRIX values ('kaftzr','kaftzr','HWCUS');
Insert into SECURITY_MATRIX values ('kxb659','kxb659','HWCUS');
Insert into SECURITY_MATRIX values ('kxt175','kxt175','HWCUS');
Insert into SECURITY_MATRIX values ('kxt851','kxt851','HWCUS');
Insert into SECURITY_MATRIX values ('mxm309','mxm309','HWCUS');
Insert into SECURITY_MATRIX values ('mxv771','mxv771','HWCUS');
Insert into SECURITY_MATRIX values ('nxk96r','nxk96r','HWCUS');
Insert into SECURITY_MATRIX values ('nxs290','nxs290','HWCUS');
Insert into SECURITY_MATRIX values ('ras46r','ras46r','HWCUS');
Insert into SECURITY_MATRIX values ('rbdarr','rbdarr','HWCUS');
Insert into SECURITY_MATRIX values ('rdsw6r','rdsw6r','HWCUS');
Insert into SECURITY_MATRIX values ('rxk163','rxk163','HWCUS');
Insert into SECURITY_MATRIX values ('rxm383','rxm383','HWCUS');
Insert into SECURITY_MATRIX values ('sxk419','sxk419','HWCUS');
Insert into SECURITY_MATRIX values ('tadarr','tadarr','HWCUS');
Insert into SECURITY_MATRIX values ('wxn683','wxn683','HWCUS');
Insert into SECURITY_MATRIX values ('ydrpur','ydrpur','HWCUS');
Insert into SECURITY_MATRIX values ('yxz430','yxz430','HWCUS');

Insert into SECURITY_MATRIX values ('jxc517','jxc517','HWCUS');
Insert into SECURITY_MATRIX values ('sxh487','sxh487','HWCUS');
Insert into SECURITY_MATRIX values ('nxk927','nxk927','HWCUS');
Insert into SECURITY_MATRIX values ('axk326','axk326','HWCUS');
Insert into SECURITY_MATRIX values ('dxv848','dxv848','HWCUS');
Insert into SECURITY_MATRIX values ('axd783','axd783','HWCUS');
Insert into SECURITY_MATRIX values ('mxr916','mxr916','HWCUS');

Insert into SECURITY_MATRIX values ('sxk696','sxk696','HWCUS');
Insert into SECURITY_MATRIX values ('axc415','what','HWCUS');
Insert into SECURITY_MATRIX values ('axc539','mdh000','HWCUS');
Insert into SECURITY_MATRIX values ('sxd392','sxd392','HWCUS');
Insert into SECURITY_MATRIX values ('sxr128','sxr128','HWCUS');
Insert into SECURITY_MATRIX values ('mxa875','mxa875','HWCUS');

--INSERTING into SECURITY_MATRIX - HWCU - Credit User
Insert into SECURITY_MATRIX values ('kdp465','kdppswrd','HWCU');
Insert into SECURITY_MATRIX values ('cmaarr','cmaarr','HWCU');
Insert into SECURITY_MATRIX values ('pmm4br','pmm4br','HWCU');
Insert into SECURITY_MATRIX values ('jep01r','jep01r','HWCU');


COMMIT;
