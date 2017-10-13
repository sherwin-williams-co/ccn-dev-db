/**********************************************************
Script to add EMPLOYEE_EMAIL_ADDRESS column to the EMPLOYEE_DETAILS_TABLE
Created : 10/05/2017 rxa457 CCN project team...
************************************************************/

ALTER TABLE EMPLOYEE_DETAILS 
 ADD (EMPLOYEE_EMAIL_ADDRESS VARCHAR2(720),
      USER_ID                VARCHAR2(100));
 