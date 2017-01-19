/*
Created : 01/18/2017 nxk927 CCN Project Team....
          This script will delete all the concertration from the
          banking HISTORY which are not present in the cost center database or the archive table

*/

SET SERVEROUTPUT ON;
DECLARE
BEGIN
   FOR REC IN (SELECT *
                 FROM MEMBER_BANK_CC_HIST
                WHERE SUBSTR(MEMBER_STORE_NBR,3) NOT IN (SELECT SUBSTR(COST_CENTER_CODE,3)
                                                           FROM COST_CENTER
                                                         UNION 
                                                         SELECT SUBSTR(ARCHIVE_COST_CENTER_CODE,3)
                                                           FROM COSTCNTR.CC_DELETION_GUIDS)) LOOP
       DELETE FROM STORE_MICR_FORMAT_DTLS_HIST WHERE COST_CENTER_CODE = REC.MEMBER_STORE_NBR;
       DELETE FROM BANK_DEP_TICKORD_HIST WHERE COST_CENTER_CODE = REC.MEMBER_STORE_NBR;
       DELETE FROM BANK_DEP_BAG_TICKORD_HIST WHERE COST_CENTER_CODE = REC.MEMBER_STORE_NBR;
       DELETE FROM BANK_DEP_TICK_HIST WHERE COST_CENTER_CODE = REC.MEMBER_STORE_NBR;
       DELETE FROM BANK_DEP_BAG_TICK_HIST WHERE COST_CENTER_CODE = REC.MEMBER_STORE_NBR;
       DELETE FROM MEMBER_BANK_CC_HIST WHERE MEMBER_STORE_NBR = REC.MEMBER_STORE_NBR;
   END LOOP;
COMMIT;
END;