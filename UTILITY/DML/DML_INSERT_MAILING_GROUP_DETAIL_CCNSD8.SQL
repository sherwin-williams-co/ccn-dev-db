/***************************************************************************************
This script insert record into MAILING_GROUP and MAILING_DETAILS for sending mail for 
store draft check print failure records through batch process.

Created : 08/07/2019 akj899 CCNSD-8 CCN Project...
***************************************************************************************/
DECLARE
V_DBNAME VARCHAR2(100);

BEGIN
   SELECT sys_context('USERENV','DB_NAME') 
     INTO V_DBNAME
     FROM DUAL;

   IF V_DBNAME = 'STCCNP' THEN
--Production
      INSERT INTO MAILING_GROUP VALUES(140, 'ccnsupport.team@sherwin.com');
      INSERT INTO MAILING_DETAILS VALUES('SD_CHECK_PRINT_BATCH_PROC_FAIL',140,'Storedraft batch process check printing failure records','ccnsupport.team@sherwin.com', 'Attached the list of batch process store draft check printing failure records.',
                                         'Thanks,'||CHR(10)||'Keith D. Parker'|| CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
   ELSE
--Non Production
      INSERT INTO MAILING_GROUP VALUES(140, 'ccndevelopment.team@sherwin.com');
      INSERT INTO MAILING_DETAILS VALUES('SD_CHECK_PRINT_BATCH_PROC_FAIL',140,'Storedraft batch process check printing failure records','ccndevelopment.team@sherwin.com', 'Attached the list of batch process store draft check printing failure records.',
                                         'Thanks,'||CHR(10)||'Keith D. Parker'|| CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
   END IF;   
   COMMIT;
END;
 