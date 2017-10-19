/**********************************************************
Script to add EMPLOYEE_EMAIL_ADDRESS column to the EMPLOYEE_DETAILS_TABLE
Created : 10/05/2017 rxa457 CCN project team...
          10/19/2017 nxk927 CCN project team...
          added new field work_mobile
************************************************************/

ALTER TABLE EMPLOYEE_DETAILS 
 ADD (EMPLOYEE_EMAIL_ADDRESS VARCHAR2(720),
      USER_ID                VARCHAR2(100),
      WORK_MOBILE            VARCHAR2(150));
 