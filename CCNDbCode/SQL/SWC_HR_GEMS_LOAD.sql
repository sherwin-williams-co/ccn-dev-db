/*********************************************************************************
   This script is for deleting and inserting into SWC_HR_GEMS_TB 
   from the SWC_HR_GENERIC_V
   
   created : 10/18/2016  SXH487
           : 11/10/2016  sxh487 Removed the two columns EMRG_CONTACT_NAME and EMRG_CONTACT_PHONE
             as they have been dropped from swc_hr_generic_v
           : 03/19/2018 sxh487 Changed the source from swc_hr_generic_v to SWC_HR_TAG_CCN_V
             Also, Using SYSTEM_STATUS for EMP_PAYROLL_STATUS and
             SYSTEM_STATUS_DATE for LATEST_HIRE_DATE and TERMINATION_DATE
           : 06/08/2018 sxh487 Changed logic to populate TERMINATION_DATE only
             if the employee is terminated
           : 03/21/2019 ASP-1207 mxs216 CCN Project....
             Updated varibale declaration referencing CCN_BATCH_PKG.BATCH_JOB_TYPE
*********************************************************************************/
declare

V_COUNT     INTEGER := 0 ;

cursor SWC_HR_GEMS_INFO_cur is 
SELECT * FROM SWC_HR_TAG_CCN_V
 WHERE EMPLOYEE_NUMBER IS NOT NULL;

V_BATCH_NUMBER      CCN_BATCH_PKG.BATCH_JOB_TYPE.BATCH_JOB_NUMBER%TYPE;
V_TRANS_STATUS      CCN_BATCH_PKG.BATCH_JOB_TYPE.TRANS_STATUS%TYPE := 'SUCCESSFUL';
v_Row_Data          SWC_HR_GEMS_TB%ROWTYPE;

BEGIN
    CCN_BATCH_PKG.INSERT_BATCH_JOB('SWC_HR_GEMS_TB_LOAD', V_BATCH_NUMBER);
    CCN_BATCH_PKG.LOCK_DATABASE_SP();
    --Deleting the data from SWC_HR_GEMS_TB table before inserting
    DELETE FROM SWC_HR_GEMS_TB;
    
    FOR SWC_HR_GEMS_INFO_rec IN SWC_HR_GEMS_INFO_cur LOOP
        BEGIN
             v_Row_Data.PERSON_ID                   := SWC_HR_GEMS_INFO_rec.PERSON_ID;
             v_Row_Data.EMPLOYEE_NUMBER             := SWC_HR_GEMS_INFO_rec.EMPLOYEE_NUMBER;
             v_Row_Data.NATIONAL_IDENTIFIER         := SWC_HR_GEMS_INFO_rec.NATIONAL_IDENTIFIER;
             v_Row_Data.FULL_NAME                   := SWC_HR_GEMS_INFO_rec.FULL_NAME;
             v_Row_Data.NICK_NAME                   := SWC_HR_GEMS_INFO_rec.NICK_NAME;
             v_Row_Data.LAST_NAME                   := SWC_HR_GEMS_INFO_rec.LAST_NAME;
             v_Row_Data.FIRST_NAME                  := SWC_HR_GEMS_INFO_rec.FIRST_NAME;
             v_Row_Data.MIDDLE_NAME                 := SWC_HR_GEMS_INFO_rec.MIDDLE_NAME;
             v_Row_Data.BUSINESS_GROUP_NAME         := SWC_HR_GEMS_INFO_rec.BUSINESS_GROUP_NAME;
             v_Row_Data.CURRENT_EMPLOYEE_FLAG       := SWC_HR_GEMS_INFO_rec.CURRENT_EMPLOYEE_FLAG;
             v_Row_Data.USER_ID                     := SWC_HR_GEMS_INFO_rec.USER_ID;
             v_Row_Data.EFFECTIVE_START_DATE        := SWC_HR_GEMS_INFO_rec.EFFECTIVE_START_DATE;
             v_Row_Data.EFFECTIVE_END_DATE          := SWC_HR_GEMS_INFO_rec.EFFECTIVE_END_DATE;
             v_Row_Data.PERSON_TYPE                 := SWC_HR_GEMS_INFO_rec.PERSON_TYPE;
             v_Row_Data.EMPLOYMENT_CATEGORY         := SWC_HR_GEMS_INFO_rec.EMPLOYMENT_CATEGORY;
             v_Row_Data.EMPLOYMENT_CATEGORY_HYP     := SWC_HR_GEMS_INFO_rec.EMPLOYMENT_CATEGORY_HYP;
             v_Row_Data.ASSIGNMENT_STATUS           := SWC_HR_GEMS_INFO_rec.ASSIGNMENT_STATUS;
             v_Row_Data.ASSIG_STATS                 := SWC_HR_GEMS_INFO_rec.ASSIG_STATS;
             v_Row_Data.ASSIG_STATUS                := SWC_HR_GEMS_INFO_rec.SYSTEM_STATUS;
             v_Row_Data.HOME_EMAIL_ADDRESS          := SWC_HR_GEMS_INFO_rec.HOME_EMAIL_ADDRESS;
             v_Row_Data.EMPLOYEE_EMAIL_ADDRESS      := SWC_HR_GEMS_INFO_rec.EMPLOYEE_EMAIL_ADDRESS;
             v_Row_Data.ORIGINAL_DATE_OF_HIRE       := SWC_HR_GEMS_INFO_rec.ORIGINAL_DATE_OF_HIRE;
             v_Row_Data.LATEST_HIRE_DATE            := SWC_HR_GEMS_INFO_rec.SYSTEM_STATUS_DATE;
             v_Row_Data.ADJUSTED_SERVICE_DATE       := SWC_HR_GEMS_INFO_rec.ADJUSTED_SERVICE_DATE;
             v_Row_Data.FLSA_CODE                   := SWC_HR_GEMS_INFO_rec.FLSA_CODE;
             v_Row_Data.SALARY_BASIS                := SWC_HR_GEMS_INFO_rec.SALARY_BASIS;
             v_Row_Data.BONUS_PLAN                  := SWC_HR_GEMS_INFO_rec.BONUS_PLAN;
             v_Row_Data.WORK_STATE                  := SWC_HR_GEMS_INFO_rec.WORK_STATE;
             v_Row_Data.PERF_REVIEW_DATE            := SWC_HR_GEMS_INFO_rec.PERF_REVIEW_DATE;
             v_Row_Data.WORK_AT_HOME                := SWC_HR_GEMS_INFO_rec.WORK_AT_HOME;
             v_Row_Data.ORG_UNIT                    := SWC_HR_GEMS_INFO_rec.ORG_UNIT;
             v_Row_Data.ORG_UNIT_NAME               := SWC_HR_GEMS_INFO_rec.ORG_UNIT_NAME;
             v_Row_Data.DAD_RAD_CODE                := SWC_HR_GEMS_INFO_rec.DAD_RAD_CODE;
             v_Row_Data.DAD_DIVISION                := SWC_HR_GEMS_INFO_rec.DAD_DIVISION;
             v_Row_Data.DAD_AREA                    := SWC_HR_GEMS_INFO_rec.DAD_AREA;
             v_Row_Data.DAD_DISTRICT                := SWC_HR_GEMS_INFO_rec.DAD_DISTRICT;
             v_Row_Data.DIVISION                    := SWC_HR_GEMS_INFO_rec.DIVISION;
             v_Row_Data.COST_CENTER                 := SWC_HR_GEMS_INFO_rec.COST_CENTER;
             v_Row_Data.CC_CHANGE_DATE              := SWC_HR_GEMS_INFO_rec.CC_CHANGE_DATE;
             v_Row_Data.DIVISION_CC                 := SWC_HR_GEMS_INFO_rec.DIVISION_CC;
             v_Row_Data.PRIME                       := SWC_HR_GEMS_INFO_rec.PRIME;
             v_Row_Data.SUB                         := SWC_HR_GEMS_INFO_rec.SUB;
             v_Row_Data.PRIME_SUB                   := SWC_HR_GEMS_INFO_rec.PRIME_SUB;
             v_Row_Data.JOB_NAME                    := SWC_HR_GEMS_INFO_rec.JOB_NAME;
             v_Row_Data.JOB_TITLE                   := SWC_HR_GEMS_INFO_rec.JOB_TITLE;
             v_Row_Data.JOB_FAMILY                  := SWC_HR_GEMS_INFO_rec.JOB_FAMILY;
             v_Row_Data.JOB_TYPE                    := SWC_HR_GEMS_INFO_rec.JOB_TYPE;
             v_Row_Data.JOB_LEVEL                   := SWC_HR_GEMS_INFO_rec.JOB_LEVEL;
             v_Row_Data.JOB_FUNCTION                := SWC_HR_GEMS_INFO_rec.JOB_FUNCTION;
             v_Row_Data.JOB_CHANGE_DATE             := SWC_HR_GEMS_INFO_rec.JOB_CHANGE_DATE;
             v_Row_Data.ORGANIZATION                := SWC_HR_GEMS_INFO_rec.ORGANIZATION;
             v_Row_Data.LOCATION                    := SWC_HR_GEMS_INFO_rec.LOCATION;
             v_Row_Data.LOCATION_CHANGE_DATE        := SWC_HR_GEMS_INFO_rec.LOCATION_CHANGE_DATE;
             v_Row_Data.LOCATION_CODE               := SWC_HR_GEMS_INFO_rec.LOCATION_CODE;
             v_Row_Data.BROADCAST_DAD               := SWC_HR_GEMS_INFO_rec.BROADCAST_DAD;
             v_Row_Data.ADDRESS_LINE1               := SWC_HR_GEMS_INFO_rec.ADDRESS_LINE1;
             v_Row_Data.ADDRESS_LINE2               := SWC_HR_GEMS_INFO_rec.ADDRESS_LINE2;
             v_Row_Data.ADDRESS_LINE3               := SWC_HR_GEMS_INFO_rec.ADDRESS_LINE3;
             v_Row_Data.CITY                        := SWC_HR_GEMS_INFO_rec.CITY;
             v_Row_Data.STATE_OR_PROVINCE           := SWC_HR_GEMS_INFO_rec.STATE_OR_PROVINCE;
             v_Row_Data.COUNTY                      := SWC_HR_GEMS_INFO_rec.COUNTY;
             v_Row_Data.POSTAL_CODE                 := SWC_HR_GEMS_INFO_rec.POSTAL_CODE;
             v_Row_Data.COUNTRY                     := SWC_HR_GEMS_INFO_rec.COUNTRY;
             v_Row_Data.WORK_ADDRESS_LINE1          := SWC_HR_GEMS_INFO_rec.WORK_ADDRESS_LINE1;
             v_Row_Data.WORK_ADDRESS_LINE2          := SWC_HR_GEMS_INFO_rec.WORK_ADDRESS_LINE2;
             v_Row_Data.WORK_TOWN_CITY              := SWC_HR_GEMS_INFO_rec.WORK_TOWN_CITY;
             v_Row_Data.WORK_POSTAL_CODE            := SWC_HR_GEMS_INFO_rec.WORK_POSTAL_CODE;
             v_Row_Data.WORK_COUNTRY                := SWC_HR_GEMS_INFO_rec.WORK_COUNTRY;
             v_Row_Data.ADDRESS_START_DATE          := SWC_HR_GEMS_INFO_rec.ADDRESS_START_DATE;
             v_Row_Data.ADDRESS_END_DATE            := SWC_HR_GEMS_INFO_rec.ADDRESS_END_DATE;
             v_Row_Data.HOME_PHONE                  := SWC_HR_GEMS_INFO_rec.HOME_PHONE;
             v_Row_Data.WORK_PHONE                  := SWC_HR_GEMS_INFO_rec.WORK_PHONE;
             v_Row_Data.WORK_MOBILE                 := SWC_HR_GEMS_INFO_rec.WORK_MOBILE;
             v_Row_Data.CELL_PHONE                  := SWC_HR_GEMS_INFO_rec.CELL_PHONE;
             v_Row_Data.WORK_FAX                    := SWC_HR_GEMS_INFO_rec.WORK_FAX;
             v_Row_Data.SALARY_CHANGE_REASON        := SWC_HR_GEMS_INFO_rec.SALARY_CHANGE_REASON;
             v_Row_Data.SALARY                      := SWC_HR_GEMS_INFO_rec.SALARY; 
             v_Row_Data.ANNUAL_SALARY               := SWC_HR_GEMS_INFO_rec.ANNUAL_SALARY;
             v_Row_Data.SALARY_CHANGE_AMOUNT        := SWC_HR_GEMS_INFO_rec.SALARY_CHANGE_AMOUNT;
             v_Row_Data.SALARY_CHANGE_PCT           := SWC_HR_GEMS_INFO_rec.SALARY_CHANGE_PCT;
             v_Row_Data.SALARY_START_DATE           := SWC_HR_GEMS_INFO_rec.SALARY_START_DATE;
             v_Row_Data.SALARY_END_DATE             := SWC_HR_GEMS_INFO_rec.SALARY_END_DATE;
             v_Row_Data.HR_REP_EMP_NUMBER           := SWC_HR_GEMS_INFO_rec.HR_REP_EMP_NUMBER;
             v_Row_Data.HR_REP_NAME                 := SWC_HR_GEMS_INFO_rec.HR_REP_NAME;
             v_Row_Data.SUPERVISOR_EMP_NUMBER       := SWC_HR_GEMS_INFO_rec.SUPERVISOR_EMP_NUMBER;
             v_Row_Data.SUPERVISOR_NAME             := SWC_HR_GEMS_INFO_rec.SUPERVISOR_NAME;
             v_Row_Data.SUPERVISOR_FIRST_NAME       := SWC_HR_GEMS_INFO_rec.SUPERVISOR_FIRST_NAME;
             v_Row_Data.SUPERVISOR_LAST_NAME        := SWC_HR_GEMS_INFO_rec.SUPERVISOR_LAST_NAME;
             v_Row_Data.SUPERVISOR_USER_ID          := SWC_HR_GEMS_INFO_rec.SUPERVISOR_USER_ID;
             v_Row_Data.SUPERVISOR_JOB_NAME         := SWC_HR_GEMS_INFO_rec.SUPERVISOR_JOB_NAME;
             v_Row_Data.SUPERVISOR_JOB_TITLE        := SWC_HR_GEMS_INFO_rec.SUPERVISOR_JOB_TITLE;
             v_Row_Data.SUPERVISOR_EMAIL_ADDRESS    := SWC_HR_GEMS_INFO_rec.SUPERVISOR_EMAIL_ADDRESS;
             v_Row_Data.SUPERVISOR_DIVISION         := SWC_HR_GEMS_INFO_rec.SUPERVISOR_DIVISION;
             v_Row_Data.SUPERVISOR_COST_CENTER      := SWC_HR_GEMS_INFO_rec.SUPERVISOR_COST_CENTER;
             v_Row_Data.SUPERVISOR_DIVISION_CC      := SWC_HR_GEMS_INFO_rec.SUPERVISOR_DIVISION_CC;
             v_Row_Data.SUPERVISOR_PRIME_SUB        := SWC_HR_GEMS_INFO_rec.SUPERVISOR_PRIME_SUB;
             v_Row_Data.PAY_RATE_HOURLY_OR_BIWEEKLY := SWC_HR_GEMS_INFO_rec.PAY_RATE_HOURLY_OR_BIWEEKLY;
             v_Row_Data.ANNUAL_SALARY_HYP           := SWC_HR_GEMS_INFO_rec.ANNUAL_SALARY_HYP;
             
             IF v_Row_Data.ASSIG_STATUS = 'Term' THEN
                v_Row_Data.TERMINATION_DATE    := SWC_HR_GEMS_INFO_rec.SYSTEM_STATUS_DATE;
             ELSE
                v_Row_Data.TERMINATION_DATE    := NULL;
             END IF;
             
             INSERT INTO SWC_HR_GEMS_TB VALUES v_Row_Data;
             EXCEPTION
                  WHEN OTHERS THEN
                      COMMON_TOOLS.LOG_ERROR( SWC_HR_GEMS_INFO_rec.COST_CENTER, 'SWC_HR_GEMS_LOAD', SQLERRM, SQLCODE);
             END;
            
            IF V_COUNT > 100 THEN
               COMMIT; 
               V_COUNT := 0;
            END IF; 
            V_COUNT := V_COUNT + 1;
    END LOOP;
    COMMIT;
    CCN_BATCH_PKG.UPDATE_BATCH_JOB('SWC_HR_GEMS_TB_LOAD', V_BATCH_NUMBER, V_TRANS_STATUS);
    CCN_BATCH_PKG.UNLOCK_DATABASE_SP();
EXCEPTION
  WHEN OTHERS THEN
      ROLLBACK;
      COMMON_TOOLS.LOG_ERROR('OTHER', 'SWC_HR_GEMS_LOAD', SQLERRM, SQLCODE);
      :EXITCODE := 2;
END;
/


