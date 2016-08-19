/********************************************************************************
Below script will update code_header table for Credit Hierarchy

Created : 04/07/2016 sxh487 CCN Project Team....
Modified: 08/19/2016 vxv336 Removed SYSOUT
********************************************************************************/
UPDATE CODE_HEADER
  SET CODE_HEADER_IDENTIFIER ='<ROLES>
   <ROLE>
      <VALUE>CCNUS3</VALUE>
   </ROLE>
   <ROLE>
      <VALUE>CCNPUS</VALUE>
   </ROLE>
   <ROLE>
      <VALUE>HWCUS</VALUE>
   </ROLE>
</ROLES>'
where CODE_HEADER_NAME IN ('RCM', 'ACM', 'DCM');

COMMIT;