/*******************************************************
These table holds the audit suppressed fields

Created : 11/14/2016 jxc517 CCN Project Team. . . .
Changed :
*******************************************************/
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE CCN_AUDIT_EXCLUDED_FIELDS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE CCN_AUDIT_EXCLUDED_FIELDS (
TABLE_NAME         VARCHAR2(30),
COLUMN_NAME        VARCHAR2(30),
EXCLUDED_INDICATOR VARCHAR2(1),
CONSTRAINT CCN_AUDIT_EXCLUDED_FIELDS_PK PRIMARY KEY (TABLE_NAME,COLUMN_NAME)
);
/