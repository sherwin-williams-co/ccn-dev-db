/***************************************************************************** 
Below script is created to insert data into CCN_AUDIT_EXCLUDED_FIELDS table.
This table holds the table names and fields that are not part of the CCN audit.

Created : 04/04/2018 bxa919 CCN Project....ASP 867
*****************************************************************************/



--Insert script to add the column for STORE in CCN_AUDIT_EXCLUDED_FIELDS. 
Insert into CCN_AUDIT_EXCLUDED_FIELDS (TABLE_NAME,COLUMN_NAME,EXCLUDED_INDICATOR) 
values ('STORE','POTENTIAL_OPEN_DATE','Y');

COMMIT;