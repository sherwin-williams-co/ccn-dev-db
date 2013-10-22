procedure ADDRESS_OTHER_I_SP ( 
/*******************************************************************************
	ADDRESS_OTHER_I_SP

	This procedure is intended to Insert new OTHER address records

	CostCenter      - Cost Center that changed
  Address Type    - Address Type that changed
  Effective Date  - Effective Date of ADDRESS_OTHER table that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 04/30/2012 mdh CCN Project....
revised : 12/20/2012 mdh Add EXPIRE_DATA_SP procedure
changed : 04/03/2013 BLR error message pointing to wrong procedure
        : 06/10/2013 TAL upgraded to work with multiple address and updates
*******************************************************************************/
in_COST_CENTER    IN ADDRESS_OTHER.COST_CENTER_CODE%TYPE,
in_ADDRESS_TYPE   IN ADDRESS_OTHER.ADDRESS_TYPE%TYPE,
in_EFFECTIVE_DATE IN ADDRESS_OTHER.EFFECTIVE_DATE%TYPE
,in_TABLE_NAME IN VARCHAR2
,in_ROW_DATE   IN DATE
,in_Row_data   IN varchar2 --sys.xmltype
)
 is 
 v_code number;
 v_errm varchar2(500);
 v_address_other_row ADDRESS_OTHER%rowtype;

v_Row_data      sys.xmltype := xmltype(in_Row_data);
v_xml_frag      clob;
v_count 		integer := 1;


begin


--  LOOP Once for each occurrence of <ADDRESS_OTHER> in the passed XML
    WHILE v_Row_data.EXISTSNODE('/ADDRESS_UI_UPSERT/ADDRESS_OTHER' || '[' || V_COUNT || ']') = 1 LOOP
	
    v_xml_frag := v_Row_data.EXTRACT('/ADDRESS_UI_UPSERT/ADDRESS_OTHER' || '[' || V_COUNT || ']').getCLOBVal();
	
--  convert XML to ROWTYPE --
    CCN_TABLE_IU_PKG.ADDRESS_OTHER_ROWTYPE_SP (
					 in_COST_CENTER           
					,in_ADDRESS_TYPE          
					,in_EFFECTIVE_DATE        
					,in_TABLE_NAME            
					,in_ROW_DATE             
					,v_xml_frag--in_Row_data             
					,v_ADDRESS_OTHER_row        
					);
--
--  Expire currently active ADDRESS_OTHER Record before insert --
      COMMON_TOOLS.EXPIRE_DATA_SP (
      'ADDRESS_OTHER'
		 , v_address_other_row.COST_CENTER_CODE
     , v_address_other_row.EFFECTIVE_DATE
     , v_address_other_row.ADDRESS_TYPE);
--
--  Insert new ADDRESS_OTHER row --
    BEGIN
      INSERT into ADDRESS_OTHER values v_address_other_row;    
				    				    
				    EXCEPTION
				       WHEN dup_val_on_index THEN
				            BEGIN
--								dbms_output.put_line('in dup_val on index');
								UPDATE ADDRESS_OTHER SET 
                    EXPIRATION_DATE = NULL--v_ADDRESS_OTHER_row.EXPIRATION_DATE
									, ADDRESS_LINE_1 = v_ADDRESS_OTHER_row.ADDRESS_LINE_1
									, ADDRESS_LINE_2 = v_ADDRESS_OTHER_row.ADDRESS_LINE_2
									, ADDRESS_LINE_3 = v_ADDRESS_OTHER_row.ADDRESS_LINE_3
									, CITY = v_ADDRESS_OTHER_row.CITY
									, PROVINCE_CODE = v_ADDRESS_OTHER_row.PROVINCE_CODE
									, STATE_CODE = v_ADDRESS_OTHER_row.STATE_CODE
									, POSTAL_CODE = v_ADDRESS_OTHER_row.POSTAL_CODE
									, VALID_ADDRESS = v_ADDRESS_OTHER_row.VALID_ADDRESS
									, COUNTRY_CODE = v_ADDRESS_OTHER_row.COUNTRY_CODE
								WHERE 
									COST_CENTER_CODE = v_ADDRESS_OTHER_row.COST_CENTER_CODE
									AND ADDRESS_TYPE = v_ADDRESS_OTHER_row.ADDRESS_TYPE
									AND EFFECTIVE_DATE = v_ADDRESS_OTHER_row.EFFECTIVE_DATE;
                  										                
				  -- dbms_output.put_line('ADDRESS USA Update executed ');
					            EXCEPTION 
					             WHEN OTHERS THEN 
					                 v_code  := SQLCODE;
					                 v_errm  := substr(SQLERRM,1,200);
					                 errpkg.raise_err(v_code, 'ADDRESS_OTHER_I_SP, ' || ' ' ||
					                 v_errm || ';  ' ||
					                 'ADDRESS OTHER Update Error' );
					           END;
						       
				    END;  
		V_COUNT := V_COUNT + 1;		      
      END LOOP;
        
  EXCEPTION
	  WHEN OTHERS THEN 
      v_code  := SQLCODE;
      v_errm  := substr(SQLERRM,1,200);
      errpkg.raise_err(v_code, 'ADDRESS_OTHER_I_SP, ' || ' ' ||
             'IN_TABLE_NAME is ' || in_TABLE_NAME || '; ' || v_errm);
        
END ADDRESS_OTHER_I_SP;
/

