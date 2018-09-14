create or replace PACKAGE   BODY       CCN_DERIVED_VALUES AS 
/*********************************************************** 
This package BODY is intended to derive values for CCN user   

created : 09/13/2018 kxm302 CCN Proeject Team.....
        : Derives Cost Center Manager Name ASP - 1128
************************************************************/

FUNCTION GET_CC_MANAGER_NAME(
/***********************************************************
This function will return Manager Name for given Cost Center Code

Created : 03/28/2018 sxg151 CCN Project ASP-1048
modified: 
************************************************************/
    IN_COST_CENTER_CODE     IN EMPLOYEE_DETAILS.COST_CENTER_CODE%TYPE)
RETURN VARCHAR2
IS 
    V_MGR_NAME EMPLOYEE_DETAILS.EMPLOYEE_NAME%TYPE;    
    V_CATEGORY COST_CENTER.CATEGORY%TYPE;
BEGIN
    BEGIN
        SELECT CATEGORY
          INTO V_CATEGORY
          FROM COST_CENTER
         WHERE COST_CENTER_CODE = IN_COST_CENTER_CODE;
    EXCEPTION
        WHEN OTHERS THEN 
            NULL;
    END;

    IF V_CATEGORY = 'T' THEN
        SELECT EMPLOYEE_NAME
          INTO V_MGR_NAME
          FROM EMPLOYEE_DETAILS EMP
         WHERE UPPER(COST_CENTER_CODE)   = IN_COST_CENTER_CODE
           AND UPPER(EMP_PAYROLL_STATUS) = 'ACTIVE'
           AND HIRE_DATE = (SELECT MAX(HIRE_DATE)
                              FROM EMPLOYEE_DETAILS
                             WHERE UPPER(COST_CENTER_CODE)  = IN_COST_CENTER_CODE
                               AND UPPER(EMP_PAYROLL_STATUS)= 'ACTIVE');
    ELSE
        SELECT EMPLOYEE_NAME
          INTO V_MGR_NAME
          FROM (SELECT EMP.*
                  FROM EMPLOYEE_DETAILS EMP
                 WHERE UPPER(COST_CENTER_CODE)   = IN_COST_CENTER_CODE
                   AND  UPPER(EMP_PAYROLL_STATUS) = 'ACTIVE'
                   AND UPPER(JOB_TITLE) IN (SELECT DISTINCT UPPER(JOB_TITLE) FROM JOB_TITLE_GROUP
                                             WHERE NONMGR_IND = 'Y'
                                               AND UPPER(JOB_GROUP) NOT IN ('OPS MANAGER', 'ASSISTANT MANGER')
                                               AND UPPER(JOB_TITLE) <> 'MTP'
                                               )
                 ORDER BY DECODE(UPPER(JOB_TITLE),'TRAINEE MGR',2,1), HIRE_DATE
                 -- This is to make sure TRAINEE MGR is not at the top of the list when other managers are available
                 -- "MTP" is a valid management trainee program from field payroll but not applicable for polling process per kdp
             )
       WHERE ROWNUM < 2;
    END IF;
    RETURN V_MGR_NAME;
EXCEPTION
    WHEN OTHERS THEN
        RETURN V_MGR_NAME;      
END GET_CC_MANAGER_NAME;

END CCN_DERIVED_VALUES;