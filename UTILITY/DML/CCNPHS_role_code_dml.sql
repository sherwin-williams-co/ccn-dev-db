/*
     Created: 06/01/2017 axt754 CCN Project Team..
     This script creates a new role 'CCNPHS' and assign to credit user 
     'jmk01r'
*/
-- Insert New role Code make sure SELECT_FLAG only should set to 'Y'
INSERT INTO ROLE_DETAILS 
     VALUES ('CCNPHS','CCN Price District User - History window select','N','N','N','Y',
'<USER_RULES>
   <COST_CENTER_WINDOW>
      <HISTORY_WINDOW>
         <VALUE>HISTORY_NAME</VALUE>
      </HISTORY_WINDOW>
   </COST_CENTER_WINDOW>
</USER_RULES>
',
'<USER_RULES_DESCRIPTION>
   <COST_CENTER_WINDOW>
      <HISTORY_WINDOW>
         <HISTORY_NAME>
            <VALUE>HIERARCHY</VALUE>
         </HISTORY_NAME>
      </HISTORY_WINDOW>
   </COST_CENTER_WINDOW>
</USER_RULES_DESCRIPTION>
');

-- Check if the insert into ROLE_DEATILS is valid
SELECT * 
  FROM ROLE_DETAILS
 WHERE ROLE_CODE = 'CCNPHS';

-- check the roles assigned to 'jmk01r'
SELECT *
  FROM SECURITY_MATRIX
 WHERE user_id = 'jmk01r'
 ORDER BY 3;
 
-- Give access to jmk01r for CCNPHS
INSERT INTO SECURITY_MATRIX
     VALUES ('jmk01r','jmk01r','CCNPHS');
     

     
-- Commit the transaction     
COMMIT;

-- Check if inserted role code for 'jmk01r' is valid 
SELECT *
  FROM SECURITY_MATRIX
 WHERE user_id = 'jmk01r'
 ORDER BY 3;