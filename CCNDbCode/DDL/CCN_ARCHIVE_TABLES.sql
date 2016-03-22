/*
first script will generate the DDL's required to create archive tables of Cost Center Tables
second scirpt creates the archive table for AUDIT_LOG

Created : 03/16/2016 jxc517 CCN Project Team....
*/
SELECT 'CREATE TABLE ARC_' || TABLE_NAME || ' AS SELECT A.*, SYSDATE AS ARCHIVE_DATE FROM ' || TABLE_NAME || ' A WHERE 1 = 2;'
                    FROM INSERTORDER
                WHERE TABLE_NAME NOT IN ('SALES_REP','CODE_HEADER','CODE_DETAIL','HIERARCHY_HEADER','HIERARCHY_DESCRIPTION');
--Execute the scripts that were generated using above sql

CREATE TABLE ARC_AUDIT_LOG AS SELECT A.*, SYSDATE AS ARCHIVE_DATE FROM AUDIT_LOG A WHERE 1 = 2;
