--Updating the JOB_CODE in the table employee_details 
declare

sq NUMBER;
se VARCHAR2(100);

cursor employee_details_cur is 
         SELECT rowid RID, ED.*
          FROM EMPLOYEE_DETAILS ED
         WHERE UPPER(JOB_TITLE) LIKE '%MGR%';

v_count     integer := 0;

begin

  --lock all users out and Disable the triggers
  CCN_BATCH_PKG.LOCK_DATABASE_SP(); -- PRAGMA AUTONOMOUS_TRANSACTION;
  COMMON_TOOLS.ALTER_ALL_TRIGGERS('DISABLE');
    
  FOR employee_details_rec in employee_details_cur LOOP
           
          UPDATE EMPLOYEE_DETAILS A
             SET JOB_CODE = CCN_EMPLOYEE_DETAILS_PKG.GET_JOB_CODE(employee_details_rec.JOB_TITLE, employee_details_rec.JOB_FAMILY, employee_details_rec.JOB_TYPE)
           WHERE ROWID = EMPLOYEE_DETAILS_REC.RID
             AND EMPLOYEE_NUMBER = EMPLOYEE_DETAILS_REC.EMPLOYEE_NUMBER;
          
          IF V_COUNT > 1000 then
             COMMIT; 
             V_COUNT := 0;
          ELSE
             V_COUNT := V_COUNT + 1;
          END IF;

  END LOOP;
  COMMIT;

  --unlock all users and Enable the triggers
  COMMON_TOOLS.ALTER_ALL_TRIGGERS('ENABLE');
  CCN_BATCH_PKG.UNLOCK_DATABASE_SP(); -- PRAGMA AUTONOMOUS_TRANSACTION; 
    
EXCEPTION
       WHEN OTHERS THEN
          sq := SQLCODE;
          se := SQLERRM;

	DBMS_OUTPUT.PUT_LINE('FAILED ' || sq || ' ' || se);
END;
/
