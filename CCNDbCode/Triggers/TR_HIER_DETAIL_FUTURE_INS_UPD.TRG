create or replace TRIGGER TR_HIER_DETAIL_FUTURE_INS_UPD 
/*******************************************************************************
This trigger fires on an insert/ update on HIERARCHY_DETAIL_FUTURE table

Created : 08/02/2017 rxv940 CCN Project Team....
Changed : 
          
*******************************************************************************/
BEFORE INSERT OR UPDATE ON HIERARCHY_DETAIL_FUTURE
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE

    V_HI_DET_ROW     HIERARCHY_DETAIL_FUTURE%ROWTYPE; 

BEGIN

    V_HI_DET_ROW.HRCHY_HDR_NAME             := :NEW.HRCHY_HDR_NAME;
    V_HI_DET_ROW.HRCHY_DTL_LEVEL            := :NEW.HRCHY_DTL_LEVEL;
    V_HI_DET_ROW.HRCHY_DTL_PREV_LVL_VAL     := :NEW.HRCHY_DTL_PREV_LVL_VAL;
    V_HI_DET_ROW.HRCHY_DTL_CURR_LVL_VAL     := :NEW.HRCHY_DTL_CURR_LVL_VAL;
    V_HI_DET_ROW.HRCHY_DTL_NEXT_LVL_VAL     := :NEW.HRCHY_DTL_NEXT_LVL_VAL;
    V_HI_DET_ROW.HRCHY_DTL_EFF_DATE         := :NEW.HRCHY_DTL_EFF_DATE;
    V_HI_DET_ROW.HRCHY_DTL_EXP_DATE         := :NEW.HRCHY_DTL_EXP_DATE;
    V_HI_DET_ROW.HRCHY_DTL_DESC             := :NEW.HRCHY_DTL_DESC;
    V_HI_DET_ROW.HRCHY_DTL_CURR_ROW_VAL     := :NEW.HRCHY_DTL_CURR_ROW_VAL;
    
    IF V_HI_DET_ROW.HRCHY_HDR_NAME ='PRICE_DISTRICT' THEN 
        IF INSERTING THEN
            IF LENGTH(V_HI_DET_ROW.HRCHY_DTL_CURR_ROW_VAL)=6 AND V_HI_DET_ROW.HRCHY_DTL_NEXT_LVL_VAL='~~~' THEN
                POS_DATA_GENERATION.POS_TRG_EVENT_LOG(V_HI_DET_ROW.HRCHY_DTL_CURR_ROW_VAL,
                                                    'HIERARCHY_DETAIL',
                                                    'ADD',
                                                    'POS_STORE_UPDATE'
                                                    );
            END IF;
        
        ELSIF UPDATING THEN
            IF 
            (
            NVL(:OLD.HRCHY_DTL_CURR_LVL_VAL,'XXX')<> NVL(:NEW.HRCHY_DTL_CURR_LVL_VAL,'XXX')
            OR 
                NOT 
                   (
                   (:OLD.HRCHY_DTL_EFF_DATE = :NEW.HRCHY_DTL_EFF_DATE) 
                   OR 
                   (:OLD.HRCHY_DTL_EFF_DATE IS NULL AND :NEW.HRCHY_DTL_EFF_DATE IS NULL)
                   )
            )
            AND LENGTH(V_HI_DET_ROW.HRCHY_DTL_CURR_ROW_VAL)=6 
            AND V_HI_DET_ROW.HRCHY_DTL_NEXT_LVL_VAL='~~~'
            THEN
                POS_DATA_GENERATION.POS_TRG_EVENT_LOG(V_HI_DET_ROW.HRCHY_DTL_CURR_ROW_VAL,
                                                    'HIERARCHY_DETAIL',
                                                    'CHANGE',
                                                    'POS_STORE_UPDATE'
                                                   );
            END IF;
        END IF;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
    ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                               'TR_HIER_DETAIL_FUTURE_INS_UPD',
                               SQLERRM,
                               V_HI_DET_ROW.HRCHY_DTL_CURR_ROW_VAL
                               );
END TR_HIER_DETAIL_FUTURE_UPD;