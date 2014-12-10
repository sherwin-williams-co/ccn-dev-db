--update the column size to null
--update the column size to null
UPDATE CCN_ADDITIONAL_AUDIT_FIELDS
   SET DATA_LENGTH = NULL
 WHERE COLUMN_NAME = 'EMPLOYEE_NAME'
 and TABLE_NAME ='HIERARCHY_DETAIL';