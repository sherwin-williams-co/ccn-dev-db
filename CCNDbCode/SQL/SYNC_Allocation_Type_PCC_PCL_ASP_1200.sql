/********************************************************
This script will sync column PCC_PCL_STORE based on data in column COLOR_CONSULTANT_TYPE

Created : 03/28/2019 mxs216 ASP-1200 
Update  :
********************************************************/
DECLARE
    V_COLOR_CONSULTANT_TYPE XMLTYPE;
    V_PCC_PCL_STORE         XMLTYPE;
    V_OUT_PCC_PCL_STORE     VARCHAR2(4000);
V_OUT_PCC_PCL_STORE_xmltype XMLTYPE;
    CURSOR COLOR_PCC_PCL_STORE_CUR IS
       SELECT cost_center_code,
              color_consultant_type,
              pcc_pcl_store
         FROM cost_center;
BEGIN
    FOR C1 IN COLOR_PCC_PCL_STORE_CUR LOOP
        BEGIN
            SAVEPOINT PCC_PCL_STORE;
            V_COLOR_CONSULTANT_TYPE := C1.COLOR_CONSULTANT_TYPE;
            V_PCC_PCL_STORE := C1.PCC_PCL_STORE;
            CCN_TABLE_IU_PKG.SYNC_ALLOCATION_TYPE(V_COLOR_CONSULTANT_TYPE,
                                                  V_PCC_PCL_STORE,
                                                  V_OUT_PCC_PCL_STORE);
            UPDATE cost_center
               SET pcc_pcl_store = XMLTYPE(V_OUT_PCC_PCL_STORE)
               WHERE cost_center_code = C1.cost_center_code;
            COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
                COMMON_TOOLS.LOG_ERROR(C1.cost_center_code, 'SYNC_Allocation_Type_ASP_1200.sql', SQLERRM, SQLCODE);
                ROLLBACK TO HIERARCHY_HER_NAME;
        END;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        COMMON_TOOLS.LOG_ERROR('000000', 'SYNC_Allocation_Type_ASP_1200sql', SQLERRM, SQLCODE);
END;
/

SHOW ERROR