/*
Created : 01/18/2017 nxk927 CCN Project Team....
          This script will UPDATE all the concertration from the
          banking which are ARCHIVED and deleted from current cost center table

*/

ALTER TRIGGER TR_MEMBER_BANK_CC_UPD DISABLE;

UPDATE MEMBER_BANK_CC
   SET MEMBER_STORE_NBR = '768945'
   where MEMBER_STORE_NBR ='8945';

UPDATE MEMBER_BANK_CC_HIST
   SET MEMBER_STORE_NBR = '768945'
   where MEMBER_STORE_NBR ='8945';

COMMIT;
ALTER TRIGGER TR_MEMBER_BANK_CC_UPD ENABLE;
/
SET SERVEROUTPUT ON;
DECLARE
BEGIN
   FOR REC IN (SELECT *
                 FROM COSTCNTR.CC_DELETION_GUIDS
                WHERE ARCHIVE_COST_CENTER_CODE IN (SELECT MEMBER_STORE_NBR FROM MEMBER_BANK_CC_HIST)) LOOP
       UPDATE STORE_MICR_FORMAT_DTLS_HIST
          SET COST_CENTER_CODE = REC.COST_CENTER_CODE
        WHERE COST_CENTER_CODE = REC.ARCHIVE_COST_CENTER_CODE;
       
       UPDATE BANK_DEP_TICKORD_HIST
          SET COST_CENTER_CODE = REC.COST_CENTER_CODE
        WHERE COST_CENTER_CODE = REC.ARCHIVE_COST_CENTER_CODE;
        
       UPDATE BANK_DEP_BAG_TICKORD_HIST
          SET COST_CENTER_CODE = REC.COST_CENTER_CODE
        WHERE COST_CENTER_CODE = REC.ARCHIVE_COST_CENTER_CODE;
        
       UPDATE BANK_DEP_TICK_HIST
          SET COST_CENTER_CODE = REC.COST_CENTER_CODE
        WHERE COST_CENTER_CODE = REC.ARCHIVE_COST_CENTER_CODE;        
       
       UPDATE BANK_DEP_BAG_TICK_HIST
          SET COST_CENTER_CODE = REC.COST_CENTER_CODE
        WHERE COST_CENTER_CODE = REC.ARCHIVE_COST_CENTER_CODE;
       
       UPDATE MEMBER_BANK_CC_HIST
          SET MEMBER_STORE_NBR = REC.COST_CENTER_CODE
        WHERE MEMBER_STORE_NBR = REC.ARCHIVE_COST_CENTER_CODE;
       
   END LOOP;
END;
/
 --validate data before executing below commit command
 --If any issues, rollback
COMMIT;
/
