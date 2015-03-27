--Indexes to speed up the query in hierarchy details last level
CREATE INDEX upper_cc_code_indx ON COST_CENTER(UPPER(COST_CENTER_CODE));
CREATE INDEX type_upper_cc_code_indx ON TYPE(UPPER(COST_CENTER_CODE));
CREATE INDEX emp_dtl_upper_indx ON EMPLOYEE_DETAILS(UPPER(COST_CENTER_CODE),UPPER(JOB_TITLE));
