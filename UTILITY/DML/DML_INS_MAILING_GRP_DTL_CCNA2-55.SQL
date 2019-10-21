/***************************************************************************************
This script inserts record into MAILING_GROUP for sending mail for CCN Store
dispatch service related field value update failure records.

Created : 10/18/2019 akj899 CCNSD-8 CCN Project...

***************************************************************************************/
DECLARE
V_DBNAME VARCHAR2(100);

BEGIN
   SELECT sys_context('USERENV','DB_NAME') 
     INTO V_DBNAME
     FROM DUAL;

   IF V_DBNAME = 'STCCNP' THEN
--Production
      INSERT INTO MAILING_GROUP VALUES(144, 'ccnsupport.team@sherwin.com');
      INSERT INTO MAILING_DETAILS VALUES('STORE_DSPTH_SRVC_BULK_UPD_PROC_FAIL',144,'CCN Store dispatch service related fields update failure records','ccnsupport.team@sherwin.com', 'Attached the list of stores for which the dispatch service related field values are not updated.',
                                         'Thanks,'||CHR(10)||'Keith D. Parker'|| CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
   ELSE
--Non Production
      INSERT INTO MAILING_GROUP VALUES(144, 'ccndevelopment.team@sherwin.com');
      INSERT INTO MAILING_DETAILS VALUES('STORE_DSPTH_SRVC_BULK_UPD_PROC_FAIL',144,'CCN Store dispatch service related fields update failure records','ccndevelopment.team@sherwin.com', 'Attached the list of stores for which the dispatch service related field values are not updated.',
                                         'Thanks,'||CHR(10)||'Keith D. Parker'|| CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
   END IF;   
   COMMIT;
END;