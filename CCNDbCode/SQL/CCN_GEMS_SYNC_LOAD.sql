/*********************************************************************************
   This script is for deleting and inserting into EMP_GEMS_SYNC_TB 
   from the SWC_HR_GENERIC_V
   
   created : 10/24/2016  SXH487
           : 11/10/2016  sxh487 Removed the two columns EMRG_CONTACT_NAME and EMRG_CONTACT_PHONE
             as they have been dropped from swc_hr_generic_v
           : 03/19/2018 sxh487 Changed the source from swc_hr_generic_v to SWC_HR_TAG_CCN_V
             Also, Using SYSTEM_STATUS for EMP_PAYROLL_STATUS and
             SYSTEM_STATUS_DATE for LATEST_HIRE_DATE and TERMINATION_DATE
           : 06/08/2018 sxh487 Changed logic to populate TERMINATION_DATE only
             if the employee is terminated
*********************************************************************************/
declare

V_COUNT     INTEGER := 0 ;

cursor EMP_GEMS_SYNC_TB_cur is 
SELECT * FROM SWC_HR_TAG_CCN_V
 WHERE EMPLOYEE_NUMBER IS NOT NULL;

V_BATCH_NUMBER      BATCH_JOB.BATCH_JOB_NUMBER%TYPE;
V_TRANS_STATUS      BATCH_JOB.TRANS_STATUS%TYPE := 'SUCCESSFUL';
v_Row_Data          EMP_GEMS_SYNC_TB%ROWTYPE;

BEGIN
    CCN_BATCH_PKG.INSERT_BATCH_JOB('EMP_GEMS_SYNC_LOAD', V_BATCH_NUMBER);
    CCN_BATCH_PKG.LOCK_DATABASE_SP();
    --Deleting the data from EMP_GEMS_SYNC_TB table before inserting
    DELETE FROM EMP_GEMS_SYNC_TB;
    
    FOR EMP_GEMS_SYNC_TB_rec IN EMP_GEMS_SYNC_TB_cur LOOP
        BEGIN
             v_Row_Data.PERSON_ID                   := EMP_GEMS_SYNC_TB_rec.PERSON_ID;
             v_Row_Data.EMPLOYEE_NUMBER             := EMP_GEMS_SYNC_TB_rec.EMPLOYEE_NUMBER;
             v_Row_Data.NATIONAL_IDENTIFIER         := EMP_GEMS_SYNC_TB_rec.NATIONAL_IDENTIFIER;
             v_Row_Data.FULL_NAME                   := EMP_GEMS_SYNC_TB_rec.FULL_NAME;
             v_Row_Data.NICK_NAME                   := EMP_GEMS_SYNC_TB_rec.NICK_NAME;
             v_Row_Data.LAST_NAME                   := EMP_GEMS_SYNC_TB_rec.LAST_NAME;
             v_Row_Data.FIRST_NAME                  := EMP_GEMS_SYNC_TB_rec.FIRST_NAME;
             v_Row_Data.MIDDLE_NAME                 := EMP_GEMS_SYNC_TB_rec.MIDDLE_NAME;
             v_Row_Data.BUSINESS_GROUP_NAME         := EMP_GEMS_SYNC_TB_rec.BUSINESS_GROUP_NAME;
             v_Row_Data.CURRENT_EMPLOYEE_FLAG       := EMP_GEMS_SYNC_TB_rec.CURRENT_EMPLOYEE_FLAG;
             v_Row_Data.USER_ID                     := EMP_GEMS_SYNC_TB_rec.USER_ID;
             v_Row_Data.EFFECTIVE_START_DATE        := EMP_GEMS_SYNC_TB_rec.EFFECTIVE_START_DATE;
             v_Row_Data.EFFECTIVE_END_DATE          := EMP_GEMS_SYNC_TB_rec.EFFECTIVE_END_DATE;
             v_Row_Data.PERSON_TYPE                 := EMP_GEMS_SYNC_TB_rec.PERSON_TYPE;
             v_Row_Data.EMPLOYMENT_CATEGORY         := EMP_GEMS_SYNC_TB_rec.EMPLOYMENT_CATEGORY;
             v_Row_Data.EMPLOYMENT_CATEGORY_HYP     := EMP_GEMS_SYNC_TB_rec.EMPLOYMENT_CATEGORY_HYP;
             v_Row_Data.ASSIGNMENT_STATUS           := EMP_GEMS_SYNC_TB_rec.ASSIGNMENT_STATUS;
             v_Row_Data.ASSIG_STATS                 := EMP_GEMS_SYNC_TB_rec.ASSIG_STATS;
             v_Row_Data.ASSIG_STATUS                := EMP_GEMS_SYNC_TB_rec.SYSTEM_STATUS;
             v_Row_Data.HOME_EMAIL_ADDRESS          := EMP_GEMS_SYNC_TB_rec.HOME_EMAIL_ADDRESS;
             v_Row_Data.EMPLOYEE_EMAIL_ADDRESS      := EMP_GEMS_SYNC_TB_rec.EMPLOYEE_EMAIL_ADDRESS;
             v_Row_Data.ORIGINAL_DATE_OF_HIRE       := EMP_GEMS_SYNC_TB_rec.ORIGINAL_DATE_OF_HIRE;
             v_Row_Data.LATEST_HIRE_DATE            := EMP_GEMS_SYNC_TB_rec.SYSTEM_STATUS_DATE;
             v_Row_Data.ADJUSTED_SERVICE_DATE       := EMP_GEMS_SYNC_TB_rec.ADJUSTED_SERVICE_DATE;
             v_Row_Data.FLSA_CODE                   := EMP_GEMS_SYNC_TB_rec.FLSA_CODE;
             v_Row_Data.SALARY_BASIS                := EMP_GEMS_SYNC_TB_rec.SALARY_BASIS;
             v_Row_Data.BONUS_PLAN                  := EMP_GEMS_SYNC_TB_rec.BONUS_PLAN;
             v_Row_Data.WORK_STATE                  := EMP_GEMS_SYNC_TB_rec.WORK_STATE;
             v_Row_Data.PERF_REVIEW_DATE            := EMP_GEMS_SYNC_TB_rec.PERF_REVIEW_DATE;
             v_Row_Data.WORK_AT_HOME                := EMP_GEMS_SYNC_TB_rec.WORK_AT_HOME;
             v_Row_Data.ORG_UNIT                    := EMP_GEMS_SYNC_TB_rec.ORG_UNIT;
             v_Row_Data.ORG_UNIT_NAME               := EMP_GEMS_SYNC_TB_rec.ORG_UNIT_NAME;
             v_Row_Data.DAD_RAD_CODE                := EMP_GEMS_SYNC_TB_rec.DAD_RAD_CODE;
             v_Row_Data.DAD_DIVISION                := EMP_GEMS_SYNC_TB_rec.DAD_DIVISION;
             v_Row_Data.DAD_AREA                    := EMP_GEMS_SYNC_TB_rec.DAD_AREA;
             v_Row_Data.DAD_DISTRICT                := EMP_GEMS_SYNC_TB_rec.DAD_DISTRICT;
             v_Row_Data.DIVISION                    := EMP_GEMS_SYNC_TB_rec.DIVISION;
             v_Row_Data.COST_CENTER                 := EMP_GEMS_SYNC_TB_rec.COST_CENTER;
             v_Row_Data.CC_CHANGE_DATE              := EMP_GEMS_SYNC_TB_rec.CC_CHANGE_DATE;
             v_Row_Data.DIVISION_CC                 := EMP_GEMS_SYNC_TB_rec.DIVISION_CC;
             v_Row_Data.PRIME                       := EMP_GEMS_SYNC_TB_rec.PRIME;
             v_Row_Data.SUB                         := EMP_GEMS_SYNC_TB_rec.SUB;
             v_Row_Data.PRIME_SUB                   := EMP_GEMS_SYNC_TB_rec.PRIME_SUB;
             v_Row_Data.JOB_NAME                    := EMP_GEMS_SYNC_TB_rec.JOB_NAME;
             v_Row_Data.JOB_TITLE                   := EMP_GEMS_SYNC_TB_rec.JOB_TITLE;
             v_Row_Data.JOB_FAMILY                  := EMP_GEMS_SYNC_TB_rec.JOB_FAMILY;
             v_Row_Data.JOB_TYPE                    := EMP_GEMS_SYNC_TB_rec.JOB_TYPE;
             v_Row_Data.JOB_LEVEL                   := EMP_GEMS_SYNC_TB_rec.JOB_LEVEL;
             v_Row_Data.JOB_FUNCTION                := EMP_GEMS_SYNC_TB_rec.JOB_FUNCTION;
             v_Row_Data.JOB_CHANGE_DATE             := EMP_GEMS_SYNC_TB_rec.JOB_CHANGE_DATE;
             v_Row_Data.ORGANIZATION                := EMP_GEMS_SYNC_TB_rec.ORGANIZATION;
             v_Row_Data.LOCATION                    := EMP_GEMS_SYNC_TB_rec.LOCATION;
             v_Row_Data.LOCATION_CHANGE_DATE        := EMP_GEMS_SYNC_TB_rec.LOCATION_CHANGE_DATE;
             v_Row_Data.LOCATION_CODE               := EMP_GEMS_SYNC_TB_rec.LOCATION_CODE;
             v_Row_Data.BROADCAST_DAD               := EMP_GEMS_SYNC_TB_rec.BROADCAST_DAD;
             v_Row_Data.ADDRESS_LINE1               := EMP_GEMS_SYNC_TB_rec.ADDRESS_LINE1;
             v_Row_Data.ADDRESS_LINE2               := EMP_GEMS_SYNC_TB_rec.ADDRESS_LINE2;
             v_Row_Data.ADDRESS_LINE3               := EMP_GEMS_SYNC_TB_rec.ADDRESS_LINE3;
             v_Row_Data.CITY                        := EMP_GEMS_SYNC_TB_rec.CITY;
             v_Row_Data.STATE_OR_PROVINCE           := EMP_GEMS_SYNC_TB_rec.STATE_OR_PROVINCE;
             v_Row_Data.COUNTY                      := EMP_GEMS_SYNC_TB_rec.COUNTY;
             v_Row_Data.POSTAL_CODE                 := EMP_GEMS_SYNC_TB_rec.POSTAL_CODE;
             v_Row_Data.COUNTRY                     := EMP_GEMS_SYNC_TB_rec.COUNTRY;
             v_Row_Data.WORK_ADDRESS_LINE1          := EMP_GEMS_SYNC_TB_rec.WORK_ADDRESS_LINE1;
             v_Row_Data.WORK_ADDRESS_LINE2          := EMP_GEMS_SYNC_TB_rec.WORK_ADDRESS_LINE2;
             v_Row_Data.WORK_TOWN_CITY              := EMP_GEMS_SYNC_TB_rec.WORK_TOWN_CITY;
             v_Row_Data.WORK_POSTAL_CODE            := EMP_GEMS_SYNC_TB_rec.WORK_POSTAL_CODE;
             v_Row_Data.WORK_COUNTRY                := EMP_GEMS_SYNC_TB_rec.WORK_COUNTRY;
             v_Row_Data.ADDRESS_START_DATE          := EMP_GEMS_SYNC_TB_rec.ADDRESS_START_DATE;
             v_Row_Data.ADDRESS_END_DATE            := EMP_GEMS_SYNC_TB_rec.ADDRESS_END_DATE;
             v_Row_Data.HOME_PHONE                  := EMP_GEMS_SYNC_TB_rec.HOME_PHONE;
             v_Row_Data.WORK_PHONE                  := EMP_GEMS_SYNC_TB_rec.WORK_PHONE;
             v_Row_Data.WORK_MOBILE                 := EMP_GEMS_SYNC_TB_rec.WORK_MOBILE;
             v_Row_Data.CELL_PHONE                  := EMP_GEMS_SYNC_TB_rec.CELL_PHONE;
             v_Row_Data.WORK_FAX                    := EMP_GEMS_SYNC_TB_rec.WORK_FAX;
             v_Row_Data.SALARY_CHANGE_REASON        := EMP_GEMS_SYNC_TB_rec.SALARY_CHANGE_REASON;
             v_Row_Data.SALARY                      := EMP_GEMS_SYNC_TB_rec.SALARY; 
             v_Row_Data.ANNUAL_SALARY               := EMP_GEMS_SYNC_TB_rec.ANNUAL_SALARY;
             v_Row_Data.SALARY_CHANGE_AMOUNT        := EMP_GEMS_SYNC_TB_rec.SALARY_CHANGE_AMOUNT;
             v_Row_Data.SALARY_CHANGE_PCT           := EMP_GEMS_SYNC_TB_rec.SALARY_CHANGE_PCT;
             v_Row_Data.SALARY_START_DATE           := EMP_GEMS_SYNC_TB_rec.SALARY_START_DATE;
             v_Row_Data.SALARY_END_DATE             := EMP_GEMS_SYNC_TB_rec.SALARY_END_DATE;
             v_Row_Data.HR_REP_EMP_NUMBER           := EMP_GEMS_SYNC_TB_rec.HR_REP_EMP_NUMBER;
             v_Row_Data.HR_REP_NAME                 := EMP_GEMS_SYNC_TB_rec.HR_REP_NAME;
             v_Row_Data.SUPERVISOR_EMP_NUMBER       := EMP_GEMS_SYNC_TB_rec.SUPERVISOR_EMP_NUMBER;
             v_Row_Data.SUPERVISOR_NAME             := EMP_GEMS_SYNC_TB_rec.SUPERVISOR_NAME;
             v_Row_Data.SUPERVISOR_FIRST_NAME       := EMP_GEMS_SYNC_TB_rec.SUPERVISOR_FIRST_NAME;
             v_Row_Data.SUPERVISOR_LAST_NAME        := EMP_GEMS_SYNC_TB_rec.SUPERVISOR_LAST_NAME;
             v_Row_Data.SUPERVISOR_USER_ID          := EMP_GEMS_SYNC_TB_rec.SUPERVISOR_USER_ID;
             v_Row_Data.SUPERVISOR_JOB_NAME         := EMP_GEMS_SYNC_TB_rec.SUPERVISOR_JOB_NAME;
             v_Row_Data.SUPERVISOR_JOB_TITLE        := EMP_GEMS_SYNC_TB_rec.SUPERVISOR_JOB_TITLE;
             v_Row_Data.SUPERVISOR_EMAIL_ADDRESS    := EMP_GEMS_SYNC_TB_rec.SUPERVISOR_EMAIL_ADDRESS;
             v_Row_Data.SUPERVISOR_DIVISION         := EMP_GEMS_SYNC_TB_rec.SUPERVISOR_DIVISION;
             v_Row_Data.SUPERVISOR_COST_CENTER      := EMP_GEMS_SYNC_TB_rec.SUPERVISOR_COST_CENTER;
             v_Row_Data.SUPERVISOR_DIVISION_CC      := EMP_GEMS_SYNC_TB_rec.SUPERVISOR_DIVISION_CC;
             v_Row_Data.SUPERVISOR_PRIME_SUB        := EMP_GEMS_SYNC_TB_rec.SUPERVISOR_PRIME_SUB;
             v_Row_Data.PAY_RATE_HOURLY_OR_BIWEEKLY := EMP_GEMS_SYNC_TB_rec.PAY_RATE_HOURLY_OR_BIWEEKLY;
             v_Row_Data.ANNUAL_SALARY_HYP           := EMP_GEMS_SYNC_TB_rec.ANNUAL_SALARY_HYP;
             
             IF v_Row_Data.ASSIG_STATUS = 'Term' THEN
	        v_Row_Data.TERMINATION_DATE    := EMP_GEMS_SYNC_TB_rec.SYSTEM_STATUS_DATE;
	     ELSE
	        v_Row_Data.TERMINATION_DATE    := NULL;
             END IF;
             
             INSERT INTO EMP_GEMS_SYNC_TB VALUES v_Row_Data;
             EXCEPTION
                  WHEN OTHERS THEN
                      COMMON_TOOLS.LOG_ERROR( EMP_GEMS_SYNC_TB_rec.COST_CENTER, 'EMP_GEMS_SYNC_LOAD', SQLERRM, SQLCODE);
             END;
            
            IF V_COUNT > 100 THEN
               COMMIT; 
               V_COUNT := 0;
            END IF; 
            V_COUNT := V_COUNT + 1;
    END LOOP;
    COMMIT;
    CCN_BATCH_PKG.UPDATE_BATCH_JOB('EMP_GEMS_SYNC_LOAD', V_BATCH_NUMBER, V_TRANS_STATUS);
    CCN_BATCH_PKG.UNLOCK_DATABASE_SP();
EXCEPTION
  WHEN OTHERS THEN
      ROLLBACK;
      COMMON_TOOLS.LOG_ERROR('OTHER', 'EMP_GEMS_SYNC_LOAD', SQLERRM, SQLCODE);
      :EXITCODE := 2;
END;
/