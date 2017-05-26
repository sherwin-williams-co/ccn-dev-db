/*
Below script will allow access to batch window for price district users
to allow bulk hierarchy inserts

Created : 05/26/2017 jxc517 CCN Project Team....
Changed :
*/
INSERT
  INTO ROLE_DETAILS 
VALUES ('CCNUPB',
        'CCN User - Price District Batch Window',
        'Y',
        'Y',
        'Y',
        'Y',
'<USER_RULES>
   <COST_CENTER_WINDOW>
      <VALUE>BATCH_PROCESS_WINDOW</VALUE>
   </COST_CENTER_WINDOW>
</USER_RULES>',
'<USER_RULES_DESCRIPTION>
   <COST_CENTER_WINDOW>
      <BATCH_PROCESS_WINDOW>
         <VALUE>BULK_HIERARCHY_INSERT_SECTION</VALUE>
      </BATCH_PROCESS_WINDOW>
   </COST_CENTER_WINDOW>
</USER_RULES_DESCRIPTION>');

INSERT INTO SECURITY_MATRIX VALUES ('jmk01r','jmk01r','CCNUPB');

COMMIT;
