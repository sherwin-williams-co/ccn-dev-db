--Adding new user kbg893 for CCN
Insert into SECURITY_MATRIX (USER_ID,PASSWORD,ROLE_CODE) values ('kbg893','kbg893','CCNUS1');
Insert into SECURITY_MATRIX (USER_ID,PASSWORD,ROLE_CODE) values ('kbg893','kbg893','SDU');

-- Updating user jek74s
UPDATE SECURITY_MATRIX
   SET ROLE_CODE = 'SDU'
 WHERE USER_ID = 'jek74s'
   AND ROLE_CODE = 'SDU1';

-- Updating user ctg355
UPDATE SECURITY_MATRIX
   SET ROLE_CODE = 'SDU'
 WHERE USER_ID = 'ctg355'
   AND ROLE_CODE = 'SDU1';  
   
COMMIT;