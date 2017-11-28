/*##############################################################################################################
     Created: 11/14/2017 sxg151 CCN Project Team..
     This script creates a new role 'CCNMU' and assign to Marketing user 
     'GAP54C'(Greg A. Passov),'TLC82C'(Todd Clark) 'BEO162'( Brian Otonicar )
--#############################################################################################################	 
*/

Insert into ROLE_DETAILS values ('CCNMU','CCN Marketing User','Y','Y','Y','Y',
'<USER_RULES>
   <COST_CENTER_WINDOW>
      <VALUE>MARKETING_FIELDS</VALUE>
   </COST_CENTER_WINDOW>
</USER_RULES>',
'<USER_RULES_DESCRIPTION>
   <COST_CENTER_WINDOW>
      <MARKETING_FIELDS>
         <VALUE>MARKETING_TYPE</VALUE>
         <VALUE>EFFECTIVE_DATE</VALUE>
         <VALUE>CATEGORY</VALUE>
	 <VALUE>MKT_BRAND</VALUE>
	 <VALUE>MKT_MISSION</VALUE>
	 <VALUE>MKT_REAL_ESTATE_SETTING</VALUE>
	 <VALUE>MKT_SALES_FLOOR_SIZE</VALUE>
	 <VALUE>MKT_WAREHOUSE_SIZE</VALUE>
      </MARKETING_FIELDS>
   </COST_CENTER_WINDOW>
</USER_RULES_DESCRIPTION>');

Insert into SECURITY_MATRIX values ('gap54c','gap54c','CCNMU');
Insert into SECURITY_MATRIX values ('tlc82c','tlc82c','CCNMU');
Insert into SECURITY_MATRIX values ('beo162','beo162','CCNMU');

COMMIT;
	 
	 







