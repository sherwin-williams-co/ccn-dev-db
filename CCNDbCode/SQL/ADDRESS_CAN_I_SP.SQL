CREATE OR REPLACE procedure ADDRESS_CAN_I_SP ( 
/*******************************************************************************
	ADDRESS_CAN_I_SP

	This procedure is intended to Insert new Canadian address records

	CostCenter      - Cost Center that changed
  Address Type    - Address Type that changed
  Effective Date  - Effective Date of ADDRESS_CAN table that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 04/27/2012 mdh CCN Project....
revised : 12/20/2012 mdh Add EXPIRE_DATA_SP procedure
changed : 04/03/2013 BLR error message pointing to wrong procedure
        : 06/10/2013 TAL upgraded to work with multiple address and updates
*******************************************************************************/
 in_COST_CENTER    IN ADDRESS_CAN.COST_CENTER_CODE%TYPE 
,in_ADDRESS_TYPE   IN ADDRESS_CAN.ADDRESS_TYPE%TYPE 
,in_EFFECTIVE_DATE IN ADDRESS_CAN.EFFECTIVE_DATE%TYPE
,in_TABLE_NAME IN VARCHAR2
,in_ROW_DATE   IN DATE
,in_Row_data   IN VARCHAR2--sys.xmltype
)
 is 
 v_code number;
 v_errm varchar2(500);
 v_address_can_row ADDRESS_CAN%rowtype;

v_Row_data      sys.xmltype := xmltype(in_Row_data);
v_xml_frag      clob;
v_count 		integer := 1;


begin


--  LOOP Once for each occurrence of <ADDRESS_CAN> in the passed XML
    WHILE v_Row_data.EXISTSNODE('/ADDRESS_UI_UPSERT/ADDRESS_CAN' || '[' || V_COUNT || ']') = 1 LOOP
	
    v_xml_frag := v_Row_data.EXTRACT('/ADDRESS_UI_UPSERT/ADDRESS_CAN' || '[' || V_COUNT || ']').getCLOBVal();
	
--  convert XML to ROWTYPE --
    CCN_TABLE_IU_PKG.ADDRESS_CAN_ROWTYPE_SP ( 
					 in_COST_CENTER           
					,in_ADDRESS_TYPE          
					,in_EFFECTIVE_DATE        
					,in_TABLE_NAME            
					,in_ROW_DATE             
					,v_xml_frag--in_Row_data             
					,v_ADDRESS_CAN_row        
					);
--
--  Expire currently active ADDRESS_CAN Record before insert --
      COMMON_TOOLS.EXPIRE_DATA_SP (
      'ADDRESS_CAN'
		 , v_address_can_row.COST_CENTER_CODE
     , v_address_can_row.EFFECTIVE_DATE
     , v_address_can_row.ADDRESS_TYPE);
--
--  Insert new ADDRESS_OTHER row --
    BEGIN
      INSERT into ADDRESS_CAN values v_address_can_row ;    
				    				    
				    EXCEPTION
				       WHEN dup_val_on_index THEN
				            BEGIN
--								dbms_output.put_line('in dup_val on index');
								UPDATE ADDRESS_CAN SET 
                    EXPIRATION_DATE = NULL--v_ADDRESS_CAN_row.EXPIRATION_DATE
									, ADDRESS_LINE_1 = v_ADDRESS_CAN_row.ADDRESS_LINE_1
									, ADDRESS_LINE_2 = v_ADDRESS_CAN_row.ADDRESS_LINE_2
									, ADDRESS_LINE_3 = v_ADDRESS_CAN_row.ADDRESS_LINE_3
									, CITY = v_ADDRESS_CAN_row.CITY
									, PROVINCE_CODE = v_ADDRESS_CAN_row.PROVINCE_CODE
									, POSTAL_CODE = v_ADDRESS_CAN_row.POSTAL_CODE
									, VALID_ADDRESS = v_ADDRESS_CAN_row.VALID_ADDRESS
									, COUNTRY_CODE = v_ADDRESS_CAN_row.COUNTRY_CODE
								WHERE 
									COST_CENTER_CODE = v_ADDRESS_CAN_row.COST_CENTER_CODE
									AND ADDRESS_TYPE = v_ADDRESS_CAN_row.ADDRESS_TYPE
									AND EFFECTIVE_DATE = v_ADDRESS_CAN_row.EFFECTIVE_DATE;
                  										                
				  -- dbms_output.put_line('ADDRESS CAN Update executed ');
					            EXCEPTION 
					             WHEN OTHERS THEN 
					                 v_code  := SQLCODE;
					                 v_errm  := substr(SQLERRM,1,200);
					                 errpkg.raise_err(v_code, 'ADDRESS_CAN_I_SP, ' || ' ' ||
					                 v_errm || ';  ' ||
					                 'ADDRESS CAN Update Error' );
					           END;
						       
				    END;  
		V_COUNT := V_COUNT + 1;		      
      END LOOP;
        
  EXCEPTION
	  WHEN OTHERS THEN 
      v_code  := SQLCODE;
      v_errm  := substr(SQLERRM,1,200);
      errpkg.raise_err(v_code, 'ADDRESS_CAN_I_SP, ' || ' ' ||
             'IN_TABLE_NAME is ' || in_TABLE_NAME || '; ' || v_errm);
        
END ADDRESS_CAN_I_SP;

