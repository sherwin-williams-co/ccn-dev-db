create or replace TRIGGER TR_HIER_DETAIL_FUTURE_UPD 
/*******************************************************************************
This trigger fires on an insert/ update on HIERARCHY_DETAIL_FUTURE table

Created : 08/02/2017 rxv940 CCN Project Team....
Modified: 11/10/2017 rxv940 CCN Project Team....
        : Changed condition for processing Dates

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

    BEGIN

        IF V_HI_DET_ROW.HRCHY_HDR_NAME ='PRICE_DISTRICT' AND
           LENGTH(V_HI_DET_ROW.HRCHY_DTL_CURR_ROW_VAL)=6 AND 
           V_HI_DET_ROW.HRCHY_DTL_NEXT_LVL_VAL='~~~' THEN

            IF INSERTING THEN
                POS_DATA_GENERATION.POS_TRG_EVENT_LOG(V_HI_DET_ROW.HRCHY_DTL_CURR_ROW_VAL,
                                                     'HIERARCHY_DETAIL',
                                                     'ADD',
                                                     'POS_STORE_UPDATE'
                                                     );

            ELSIF UPDATING THEN
                -- Check to see if HRCHY_DTL_CURR_LVL_VAL OR HRCHY_DTL_EFF_DATE is changed
                IF NVL(:OLD.HRCHY_DTL_CURR_LVL_VAL,'XXX')   <> NVL(:NEW.HRCHY_DTL_CURR_LVL_VAL,'XXX') OR 
                   NVL(:OLD.HRCHY_DTL_EFF_DATE, '12-JAN-1112') <> NVL(:NEW.HRCHY_DTL_EFF_DATE,'12-JAN-1112')  THEN  
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
                                   'TR_HIER_DETAIL_FUTURE_UPD',
                                   SQLERRM,
                                   V_HI_DET_ROW.HRCHY_DTL_CURR_ROW_VAL
                                   );

    END;

END TR_HIER_DETAIL_FUTURE_UPD;