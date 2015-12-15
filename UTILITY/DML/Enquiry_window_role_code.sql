--adding new role code for the enquiry window 
--nxk927 12/07/2015
Insert into ROLE_DETAILS values ('SDUES','Store Drafts User - Enquiry Window Select','N','N','N','Y',
'<USER_RULES>
   <STORE_DRAFTS_WINDOW>
      <VALUE>ENQUIRY_WINDOW</VALUE>
   </STORE_DRAFTS_WINDOW>
</USER_RULES>',
'<USER_RULES_DESCRIPTION>
   <STORE_DRAFTS_WINDOW>
      <ENQUIRY_WINDOW>
         <VALUE>ALL_FIELDS</VALUE>
      </ENQUIRY_WINDOW>
   </STORE_DRAFTS_WINDOW>
</USER_RULES_DESCRIPTION>');

--Adding users ama317 for storedraft(SDUES)
insert into security_matrix values('ama317', 'ama317', 'SDUES');

COMMIT;