/*******************************************************************
DML script to make entry in Role_Details and Security_Matrix for 
accessing Descartes New Window.
Created : 10/11/2019 akj899 CCNA2-55 CCN project...

********************************************************************/
INSERT INTO ROLE_DETAILS(ROLE_CODE, ROLE_DESCRIPTION, ADMIN_FLAG, INSERT_FLAG, UPDATE_FLAG, SELECT_FLAG, USER_RULES, USER_RULES_DESCRIPTION)
                  VALUES('CCNDWU', 'CCN Descartes Window User', 'N', 'Y', 'Y','Y',NULL, NULL); 

--Insert records with correct userid  who are only alloweed to access this window
INSERT INTO SECURITY_MATRIX(USER_ID, PASSWORD, ROLE_CODE) VALUES ('USERID', 'USERID', 'CCNDWU');

COMMIT;