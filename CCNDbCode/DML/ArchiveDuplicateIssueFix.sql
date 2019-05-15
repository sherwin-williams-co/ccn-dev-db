/*
Name        : ArchiveDuplicateIssueFix.sql
Modified On : 14-May-2019
Purpose     : Archive cost centers cleanup process - duplicates issue fix.
              Generate  new cost center number using archived/original cost center number and then copy data
              from old issue cost center and delete the old issue cost center data from current tables
*/
SET SERVER OUTPUT ON;
DECLARE
    V_ARCHIVE_COST_CENTER_CODE VARCHAR2(6);
BEGIN
    FOR rec IN (SELECT SUBSTR(COST_CENTER_CODE, 3) CC_CODE
                  FROM CC_DELETION_GUIDS
              GROUP BY SUBSTR(COST_CENTER_CODE, 3)
                HAVING COUNT(*) > 1
              ORDER BY SUBSTR(COST_CENTER_CODE, 3)) LOOP
        BEGIN
            FOR rec1 IN (SELECT *
                           FROM (SELECT A.*, ROWNUM AS RN
                                   FROM CC_DELETION_GUIDS A
                                  WHERE SUBSTR(COST_CENTER_CODE, 3) = rec.CC_CODE)
                          WHERE RN > 1) LOOP
                BEGIN
                    SAVEPOINT ARCHIVE_DUP_ISSUE_FIX;
 
                    --Generate new cost center number using archived/original cost center number
                    V_ARCHIVE_COST_CENTER_CODE := CC_ARCHIVE_DELET_RECREATE_PKG.GET_ARCHIVE_COST_CENTER(rec1.ARCHIVE_COST_CENTER_CODE);

                    --Use newly generated cost center and copy data from old issue cost center
                    COMMON_TOOLS.COPY_COST_CENTER(rec1.COST_CENTER_CODE, V_ARCHIVE_COST_CENTER_CODE);

                    --Update the tables with the newly created cost center number to override issue cost center number
                    UPDATE CC_DELETION_GUIDS SET COST_CENTER_CODE = V_ARCHIVE_COST_CENTER_CODE WHERE ARCHIVE_COST_CENTER_CODE = rec1.ARCHIVE_COST_CENTER_CODE;

                    --Delete the old issue cost center data from current tables
                    COMMON_TOOLS.DELETE_COST_CENTER(rec1.COST_CENTER_CODE);

                    COMMIT;
                EXCEPTION
                    WHEN OTHERS THEN
                        COMMON_TOOLS.LOG_ERROR(rec1.ARCHIVE_COST_CENTER_CODE, 'Manual Correction - ASP-****', SQLERRM, SQLCODE);
                        ROLLBACK TO ARCHIVE_DUP_ISSUE_FIX;
                END;
            END LOOP;
        EXCEPTION
            WHEN OTHERS THEN
                COMMON_TOOLS.LOG_ERROR(rec.CC_CODE, 'Manual Correction - ASP-****', SQLERRM, SQLCODE);
                ROLLBACK TO ARCHIVE_DUP_ISSUE_FIX;
        END;
    END LOOP;
END;
