PROCEDURE ADDRESS_USA_I_SP (
/*******************************************************************************
	ADDRESS_USA_I_SP

	This procedure is intended to insert new ADDRESS_USA records

	CostCenter - Cost Center that changed
  Address Type    - Address Type that changed
  Effective Date  - Effective Date of ADDRESS_OTHER table that changed
	OracleTableName -Table name for row (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 05/02/2012 tal CCN Project....
revised : 10/03/2012 blr CCN Project....
        : 12/20/2012 mdh Add EXPIRE_DATA_SP procedure
		: 04/03/2013 BLR error message pointing to wrong procedure
        : 06/10/2013 kdp upgraded to work with multiple address and updates
*******************************************************************************/
in_COST_CENTER          IN  ADDRESS_USA.COST_CENTER_CODE%TYPE,
in_ADDRESS_TYPE         IN  ADDRESS_USA.ADDRESS_TYPE%TYPE,
in_EFFECTIVE_DATE       IN  ADDRESS_USA.EFFECTIVE_DATE%TYPE,
in_TABLE_NAME           IN  VARCHAR2,
in_ROW_DATE             IN  DATE,
in_Row_data             IN  varchar2--sys.xmltype
)
 is 
 v_code number;
 v_errm varchar2(500);
 v_ADDRESS_USA_row ADDRESS_USA%rowtype;

v_Row_data      sys.xmltype := xmltype(in_Row_data);
v_xml_frag      clob;
v_count 		integer := 1;


begin


--  LOOP Once for each occurrence of <ADDRESS_USA> in the passed XML
    WHILE v_Row_data.EXISTSNODE('/ADDRESS_UI_UPSERT/ADDRESS_USA' || '[' || V_COUNT || ']') = 1 LOOP
	
    v_xml_frag := v_Row_data.EXTRACT('/ADDRESS_UI_UPSERT/ADDRESS_USA' || '[' || V_COUNT || ']').getCLOBVal();
	
--  convert XML to ROWTYPE --
    CCN_TABLE_IU_PKG.ADDRESS_USA_ROWTYPE_SP (
					 in_COST_CENTER           
					,in_ADDRESS_TYPE          
					,in_EFFECTIVE_DATE        
					,in_TABLE_NAME            
					,in_ROW_DATE             
					,v_xml_frag--in_Row_data             
					,v_ADDRESS_USA_row        
					);
				
--  Expire currently active ADDRESS_USA Record before insert --
      COMMON_TOOLS.EXPIRE_DATA_SP (
      'ADDRESS_USA'
		 , v_address_usa_row.COST_CENTER_CODE
     , v_address_usa_row.EFFECTIVE_DATE
     , v_address_usa_row.ADDRESS_TYPE);
--
--  Insert new ADDRESS_OTHER row --
    BEGIN
      INSERT into ADDRESS_USA values v_ADDRESS_USA_row;     
				    				    
				    EXCEPTION
				       WHEN dup_val_on_index THEN
				            BEGIN
--								dbms_output.put_line('in dup_val on index');
								UPDATE ADDRESS_USA SET 
                    EXPIRATION_DATE = NULL--v_ADDRESS_USA_row.EXPIRATION_DATE
									, ADDRESS_LINE_1 = v_ADDRESS_USA_row.ADDRESS_LINE_1
									, ADDRESS_LINE_2 = v_ADDRESS_USA_row.ADDRESS_LINE_2
									, ADDRESS_LINE_3 = v_ADDRESS_USA_row.ADDRESS_LINE_3
									, CITY = v_ADDRESS_USA_row.CITY
									, STATE_CODE = v_ADDRESS_USA_row.STATE_CODE
									, ZIP_CODE = v_ADDRESS_USA_row.ZIP_CODE
									, ZIP_CODE_4 = v_ADDRESS_USA_row.ZIP_CODE_4
									, COUNTY = v_ADDRESS_USA_row.COUNTY
									, FIPS_CODE = v_ADDRESS_USA_row.FIPS_CODE
									, DESTINATION_POINT = v_ADDRESS_USA_row.DESTINATION_POINT
									, CHECK_DIGIT = v_ADDRESS_USA_row.CHECK_DIGIT
									, VALID_ADDRESS = v_ADDRESS_USA_row.VALID_ADDRESS
									, COUNTRY_CODE = v_ADDRESS_USA_row.COUNTRY_CODE
								WHERE 
									COST_CENTER_CODE = v_ADDRESS_USA_row.COST_CENTER_CODE
									AND ADDRESS_TYPE = v_ADDRESS_USA_row.ADDRESS_TYPE
									AND EFFECTIVE_DATE = v_ADDRESS_USA_row.EFFECTIVE_DATE;
                  										                
				  -- dbms_output.put_line('ADDRESS USA Update executed ');
					            EXCEPTION 
					             WHEN OTHERS THEN 
					                 v_code  := SQLCODE;
					                 v_errm  := substr(SQLERRM,1,200);
					                 errpkg.raise_err(v_code, 'ADDRESS_USA_I_SP, ' || ' ' ||
					                 v_errm || ';  ' ||
					                 'ADDRESS USA Update Error' );
					           END;
						       
				    END;  
		V_COUNT := V_COUNT + 1;		      
      END LOOP;
        
  EXCEPTION
	  WHEN OTHERS THEN 
      v_code  := SQLCODE;
      v_errm  := substr(SQLERRM,1,200);
      errpkg.raise_err(v_code, 'ADDRESS_USA_I_SP, ' || ' ' ||
             'IN_TABLE_NAME is ' || in_TABLE_NAME || '; ' || v_errm);
	
END ADDRESS_USA_I_SP;
/

