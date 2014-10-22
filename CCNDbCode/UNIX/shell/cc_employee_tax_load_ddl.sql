
SET DEFINE OFF;

TRUNCATE TABLE CUSTOMER_TAXID_VW;
SELECT 'INSERT INTO CUSTOMER_TAXID_VW VALUES ('''||CUSTNUM||''','''||TAXID||''','''||PARENT_STORE||''','''||REPLACE(CUSTNAME,'''','''''')||''','''||DCO_NUMBER||''');' FROM CUSTOMER_TAXID_VW
                                                                                                                                                                            *
ERROR at line 1:
ORA-00942: table or view does not exist



COMMIT;
