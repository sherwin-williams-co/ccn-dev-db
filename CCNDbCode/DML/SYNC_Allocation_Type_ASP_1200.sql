/***************************************************************************************
This script will sync column PCC_PCL_STORE based on data in column COLOR_CONSULTANT_TYPE

Created : 03/28/2019 mxs216 ASP-1200 
Update  : 05/20/2019 jxc517/akj899 ASP-1200
***************************************************************************************/
DECLARE
    V_COLOR_CONSULTANT_TYPE     XMLTYPE;
    V_PCC_PCL_STORE             XMLTYPE;
    V_OUT_PCC_PCL_STORE         VARCHAR2(4000);	
    V_OUT_PCC_PCL_STORE_xmltype XMLTYPE;
	
    CURSOR COLOR_PCC_PCL_STORE_CUR IS
      SELECT c.cost_center_code,
              c.color_consultant_type,
              c.pcc_pcl_store
         FROM cost_center c,
             (SELECT *
               FROM (SELECT *
                       FROM (
             --Get all records with PCC and PCL cost centers available along with their color consultant associations
                             SELECT COST_CENTER_CODE,
                                    EXTRACTVALUE(PCC_PCL_STORE, '/PCC_PCL_STR/PCC/CC') PCC_COST_CENTER_CODE,
                                    EXTRACTVALUE(PCC_PCL_STORE, '/PCC_PCL_STR/PCL/CC') PCL_COST_CENTER_CODE,
                                    xt.*
                               FROM COST_CENTER,
                                    XMLTABLE('/PROGRAM_TYPE/COLOR_CONSULTANT_TYPE' PASSING COLOR_CONSULTANT_TYPE COLUMNS val VARCHAR2(4) PATH 'text()') xt
                              WHERE (EXTRACTVALUE(PCC_PCL_STORE, '/PCC_PCL_STR/PCC/CC') IS NOT NULL
                                     OR
                                    EXTRACTVALUE(PCC_PCL_STORE, '/PCC_PCL_STR/PCL/CC') IS NOT NULL)
                             )
             --Translate multiple association rows into single row using PIVOT function
                      PIVOT (LISTAGG( val, ',')
                        WITHIN GROUP (ORDER BY VAL)
                           FOR VAL IN ('CIW' AS CIW
                                       ,'HCR' AS HCR
                                       ,'HOA' AS HOA
                                       ,'ISR' AS ISR
                                       ,'PCC' AS PCC
                                       ,'PCL' AS PCL
                                       ,'SWD' AS SWD)
                           )
                     )
             --Identify the data that got PCC and PCL cost centers but not having corresponding association with color consultant type
             WHERE (
                     (PCC_COST_CENTER_CODE IS NOT NULL AND PCC IS NULL)
                     OR (PCL_COST_CENTER_CODE IS NOT NULL AND PCL IS NULL)
                     --OR (PCC_COST_CENTER_CODE IS NULL AND PCC IS NOT NULL)
                     --OR (PCL_COST_CENTER_CODE IS NULL AND PCL IS NOT NULL)
                    )) s
			 WHERE s.cost_center_code = c.cost_center_code;

BEGIN
    FOR C1 IN COLOR_PCC_PCL_STORE_CUR LOOP
        BEGIN
            SAVEPOINT PCC_PCL_STORE;
            V_COLOR_CONSULTANT_TYPE := C1.COLOR_CONSULTANT_TYPE;
            V_PCC_PCL_STORE := C1.PCC_PCL_STORE;
            COMMON_TOOLS.SYNC_ALLOCATION_TYPE(V_COLOR_CONSULTANT_TYPE,
                                                  V_PCC_PCL_STORE,
                                                  V_OUT_PCC_PCL_STORE);
            UPDATE cost_center
               SET pcc_pcl_store = XMLTYPE(V_OUT_PCC_PCL_STORE)
               WHERE cost_center_code = C1.cost_center_code;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                COMMON_TOOLS.LOG_ERROR(C1.cost_center_code, 'SYNC_Allocation_Type_ASP_1200.sql', SQLERRM, SQLCODE);
                ROLLBACK TO PCC_PCL_STORE;
        END;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        COMMON_TOOLS.LOG_ERROR('000000', 'SYNC_Allocation_Type_ASP_1200sql', SQLERRM, SQLCODE);
END;
/

