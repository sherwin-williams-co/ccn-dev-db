/*
Below script created to correct the FIPS codes in address_usa table. 
Need to correct CCN FIPS code based on the data from EHRS.V_AOM_PL_FIPS view.

Created : 03/09/2017 gxg192 CCN Project Team....
Changed :
*/
SET SERVEROUTPUT ON
DECLARE
    CURSOR FIPSCODE_CLNUP_CUR
    IS
    SELECT *
      FROM
       (
        SELECT rowid rid,
               COST_CENTER_CODE,
               NVL(FIPS_CODE,'N') ccn_fips_code,
               COMMON_TOOLS.GET_FIPS_CODE(STATE_CODE, 
                                          COUNTY, 
                                          CITY, 
                                          ZIP_CODE) hrs_fips_code
          FROM ADDRESS_USA
         WHERE NVL(EXPIRATION_DATE,SYSDATE+1) > SYSDATE
       )
     WHERE ccn_fips_code <> hrs_fips_code
       AND hrs_fips_code IS NOT NULL;

    rec_cnt      NUMBER := 0;
    rec_clnd_cnt NUMBER := 0;

BEGIN

    FOR rec IN FIPSCODE_CLNUP_CUR LOOP

        rec_cnt := rec_cnt + 1;

        BEGIN

            UPDATE ADDRESS_USA
               SET FIPS_CODE = rec.hrs_fips_code
             WHERE ROWID     = rec.rid;

            rec_clnd_cnt := rec_clnd_cnt + 1;
            
            IF MOD(rec_clnd_cnt,500) = 0 THEN
                COMMIT;
            END IF;

        EXCEPTION
            WHEN OTHERS THEN
                ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                           'CCN_FIPS_CODE_CLEANUP',
                                           SQLERRM,
                                           rec.COST_CENTER_CODE);
        END;
    END LOOP;
    
    COMMIT;

    dbms_output.put_line('Total number of records to be cleaned up = ' ||rec_cnt);
    dbms_output.put_line('Number of records successfully cleaned up = '||rec_clnd_cnt);
    
EXCEPTION
    WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                   'CCN_FIPS_CODE_CLEANUP',
                                   SQLERRM,
                                   '000000');
END;