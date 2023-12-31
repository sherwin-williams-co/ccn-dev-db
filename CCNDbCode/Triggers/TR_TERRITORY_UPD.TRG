create or replace TRIGGER COSTCNTR.TR_TERRITORY_UPD
/**********************************************************
created : Initial User
Modified: rxv940 CCN Project Team....
        : Changed code to handle file generation for both STORE
        : and TERR. 
        : 03/01/2018 nxk927/jxc527 CCN Project Team..
          indentation and the right event trigger for the catory
        : 06/27/2019 akj899 CCNCC-4 CCN project team..
          Added field territory_typ_of_busn_sgmnt_code
**********************************************************/
BEFORE INSERT OR UPDATE ON COSTCNTR.TERRITORY
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE

	v_transaction_id varchar2(500);
    v_rowdata sys.xmltype;
    v_primaryKey sys.xmltype;
    v_territory_row TERRITORY%ROWTYPE;
     
    
BEGIN
/*
	SELECT NVL(MAX(V_TRANSACTION_ID), 0) + 1 
      INTO v_TRANSACTION_ID
      FROM AUDIT_LOG;             
*/
            v_territory_row.cost_center_code := :NEW.cost_center_code;
            v_territory_row.home_store := :NEW.home_store;      
            v_territory_row.category := :NEW.category;
            v_territory_row.lease_car_indicator := :NEW.lease_car_indicator;
            v_territory_row.territory_type_busn_code := :NEW.territory_type_busn_code;
            v_territory_row.territory_typ_of_busn_sgmnt_cd := :NEW.territory_typ_of_busn_sgmnt_cd;
     
		
	
	SELECT XMLELEMENT ( "TERRITORY",               
		  XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                  'http://www.oracle.com/Employee.xsd' AS
                         "xsi:nonamespaceSchemaLocation" ),
	       XMLForest(v_territory_row.COST_CENTER_CODE COST_CENTER_CODE
			,v_territory_row.CATEGORY CATEGORY
			,v_territory_row.HOME_STORE HOME_STORE
			,v_territory_row.LEASE_CAR_INDICATOR LEASE_CAR_INDICATOR
			,v_territory_row.TERRITORY_TYPE_BUSN_CODE TERRITORY_TYPE_BUSN_CODE
            ,v_territory_row.TERRITORY_TYP_OF_BUSN_SGMNT_CD TERRITORY_TYP_OF_BUSN_SGMNT_CD
			)) AS "result" 
			,XMLELEMENT ( "PrimaryKey",               
	  			XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                				  'http://www.oracle.com/Employee.xsd' AS
                         			"xsi:nonamespaceSchemaLocation" ),
	       XMLForest(
                                v_territory_row.cost_center_code cost_center_code
                                ,V_TERRITORY_ROW.CATEGORY CATEGORY
			)) AS "primaryKey"		,
      ('|' || v_territory_row.cost_center_code || '|' || V_TERRITORY_ROW.CATEGORY || '|') tran_id
	INTO V_ROWDATA
		,v_primaryKey,v_transaction_id
	FROM DUAL;	
      
     /* -- for   Column -- */
     --IF (:OLD.CATEGORY != :NEW.CATEGORY) THEN

          INSERT INTO audit_log
               (log_id
               , transaction_id
               , transaction_date
               , table_name
               , table_pk_value
               , table_row_data
               , change_by)
          VALUES
               ((SELECT NVL(MAX(LOG_ID), 0) + 1 FROM AUDIT_LOG),
                v_transaction_id
                , SYSDATE
                , 'TERRITORY'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_TERRITORY_UPD');
     --END IF;
BEGIN
    IF V_TERRITORY_ROW.CATEGORY='T' THEN
        IF INSERTING THEN
            POS_DATA_GENERATION.POS_TRG_EVENT_LOG(V_TERRITORY_ROW.COST_CENTER_CODE, 'TERRITORY', 'ADD', 'POS_TERRITORY_UPDATE');
        ELSIF UPDATING THEN
            IF NVL(:OLD.TERRITORY_TYPE_BUSN_CODE, 'XX')         <> NVL(:NEW.TERRITORY_TYPE_BUSN_CODE, 'XX') OR
               NVL(:OLD.HOME_STORE, 'XXX')                      <> NVL(:NEW.HOME_STORE, 'XXX') THEN
                POS_DATA_GENERATION.POS_TRG_EVENT_LOG(V_TERRITORY_ROW.COST_CENTER_CODE, 'TERRITORY', 'CHANGE', 'POS_TERRITORY_UPDATE');
            END IF;
        END IF;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE, 'TR_TERRITORY_UPD', SQLERRM, v_territory_row.COST_CENTER_CODE);
END;
END TR_TERRITORY_UPD;