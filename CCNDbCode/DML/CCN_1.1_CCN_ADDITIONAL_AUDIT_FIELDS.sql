--Updating the length of this virtual column from 97 to 9 characters
UPDATE CCN_ADDITIONAL_AUDIT_FIELDS SET DATA_LENGTH = 9 WHERE TABLE_NAME = 'HIERARCHY_DETAIL' AND COLUMN_NAME = 'EMPLOYEE_NAME';