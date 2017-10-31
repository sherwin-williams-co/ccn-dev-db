/*******************************************************************
  This script will load data in MEMBER_BANK_CONCENTRATION_CC table.
Created : sxg151 10/30/2017

********************************************************************/
DECLARE

   CURSOR member_bank_cc_cur
   IS
   SELECT LEAD_STORE_NBR,MEMBER_STORE_NBR
   FROM MEMBER_BANK_CC;

   V_ERROR_FLAG     VARCHAR2(1) := 'N';

BEGIN

   
   dbms_output.put_line('All records from MEMBER_BANK_CONCENTRATION_CC Table deleted successfully.');

   FOR member_bank_cc_cur_rec IN member_bank_cc_cur
   LOOP
      BEGIN

         INSERT INTO MEMBER_BANK_CONCENTRATION_CC
                                    ( LEAD_STORE_NBR,
                                      MEMBER_STORE_NBR,
                                      LOAD_DATE )
         VALUES( member_bank_cc_cur_rec.LEAD_STORE_NBR,
                 member_bank_cc_cur_rec.MEMBER_STORE_NBR,
                 SYSDATE );
      EXCEPTION
         WHEN OTHERS THEN
            dbms_output.put_line('Inserting data FAILED for LEAD_STORE_NBR: '|| member_bank_cc_cur_rec.LEAD_STORE_NBR||
                                  ' MEMBER_STORE_NBR: '|| member_bank_cc_cur_rec.MEMBER_STORE_NBR||
                                  ' Error: '||SQLCODE || ' ' || SUBSTR(SQLERRM,1,500));
            V_ERROR_FLAG := 'Y';
      END;
   END LOOP;

   IF V_ERROR_FLAG = 'Y' THEN
       dbms_output.put_line('Loading data in MEMBER_BANK_CONCENTRATION_CC Table FAILED.');
       ROLLBACK;
       :exitcode := 2;
   ELSE
       dbms_output.put_line('Data loaded successfully in MEMBER_BANK_CONCENTRATION_CC Table.');
       COMMIT;
   END IF;

EXCEPTION
   WHEN others THEN
      dbms_output.put_line('Error in MEMBER_BANK_CONCENTRATION_CC Data process - '|| SQLCODE || ' ' || SUBSTR(SQLERRM,1,500));
      ROLLBACK;
      :exitcode := 2; 
END;
/