/*******************************************************
These scripts will insert data into the new table that holds the audit
suppressed fields

Created : 11/14/2016 jxc517 CCN Project Team. . . .
Changed :
*******************************************************/
INSERT INTO CCN_AUDIT_EXCLUDED_FIELDS VALUES ('COST_CENTER', 'GLOBAL_HIERARCHY_IND', 'Y');
INSERT INTO CCN_AUDIT_EXCLUDED_FIELDS VALUES ('COST_CENTER', 'ACQUISITION_CODE', 'Y');
INSERT INTO CCN_AUDIT_EXCLUDED_FIELDS VALUES ('COST_CENTER', 'POS_NON_STORE_IND', 'Y');
INSERT INTO CCN_AUDIT_EXCLUDED_FIELDS VALUES ('COST_CENTER', 'COLOR_CONSULTANT_TYPE', 'Y');
INSERT INTO CCN_AUDIT_EXCLUDED_FIELDS VALUES ('COST_CENTER', 'PCC_PCL_STORE', 'Y');
INSERT INTO CCN_AUDIT_EXCLUDED_FIELDS VALUES ('COST_CENTER', 'STD_COST_IDENTIFIER', 'Y');
INSERT INTO CCN_AUDIT_EXCLUDED_FIELDS VALUES ('COST_CENTER', 'PRIM_COST_IDENTIFIER', 'Y');
INSERT INTO CCN_AUDIT_EXCLUDED_FIELDS VALUES ('COST_CENTER', 'CC_TEMP_CLOSED_CD', 'Y');
INSERT INTO CCN_AUDIT_EXCLUDED_FIELDS VALUES ('STORE', 'SELLING_STORE_FLAG_MARK_DT', 'Y');

COMMIT;
