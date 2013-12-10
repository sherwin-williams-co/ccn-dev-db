CREATE OR REPLACE PROCEDURE CALL_BUSINESS_RULES_SP  ( 
/******************************************************************************
	CALL_BUSINESS_RULES_SP   --    Business Rules Calling Procedure

	This procedure is intended to call the Business Rules Package for all 
  Cost Center table entries returned from the Database.
  
created : 02/26/2013 TAL CCN Project....
revised :
*******************************************************************************/
  
   in_Cost_Center_Code      IN   COST_CENTER.Cost_Center_Code%type  
  )
    
is

  v_code number;
  v_errm  varchar2(500);  
  v_note  varchar2(200);
        
  v_ADDRESS_CAN_rowtype    ADDRESS_CAN%rowtype;
  v_ADDRESS_MEX_rowtype    ADDRESS_MEX%rowtype;
  v_ADDRESS_OTH_rowtype    ADDRESS_OTHER%rowtype;
  v_ADDRESS_USA_rowtype    ADDRESS_USA%rowtype;   
	v_ADMIN_rowtype          ADMINISTRATION%rowtype;
	v_BANKCARD_rowtype       BANK_CARD%rowtype;
	v_COST_CENTER_rowtype    COST_CENTER%rowtype;
	v_MARKETING_rowtype      MARKETING%rowtype;
	v_OTHER_rowtype          OTHER%rowtype;
	v_PHONE_rowtype          PHONE%rowtype;

	v_PHONE_PRI_rowtype      PHONE%rowtype;
	v_PHONE_SCD_rowtype      PHONE%rowtype;
	v_POLLING_rowtype        POLLING%rowtype;
	v_REAL_ESTATE_rowtype    REAL_ESTATE%rowtype;
	v_SALES_REP_rowtype      SALES_REP%rowtype;
	v_STATUS_rowtype         STATUS%rowtype;

	v_STORE_rowtype          STORE%rowtype;
	v_TERMINAL_rowtype       TERMINAL%rowtype;
	v_TERRITORY_rowtype      TERRITORY%rowtype;  
	v_TERR_ASGN_rowtype      TERRITORY_ASSIGNMENT%rowtype;
	v_TERR_SLS_MGR_rowtype   TERRITORY_SALES_MGR%rowtype;
	v_TYPE_rowtype           TYPE%rowtype;

--------------------------------------------------------------------------------
	BEGIN  --  Begin Call_Business_Rules_SP
--------------------------------------------------------------------------------

			CALL_BUSINESS_RULES_PKG.BUSINESS_RULES_INPUT_1 (
         in_cost_center_code   
				,v_COST_CENTER_rowtype   
        ,v_ADMIN_rowtype         
				,v_BANKCARD_rowtype    
				,v_MARKETING_rowtype    
				,v_OTHER_rowtype         
				,v_PHONE_rowtype         
			);	
      

      CALL_BUSINESS_RULES_PKG.BUSINESS_RULES_INPUT_2 (
         in_cost_center_code
				,v_PHONE_PRI_rowtype
				,v_PHONE_SCD_rowtype
				,v_POLLING_rowtype
				,v_REAL_ESTATE_rowtype
				,v_SALES_REP_rowtype
				,v_STATUS_rowtype
        ,v_COST_CENTER_rowtype
        ,v_TERR_ASGN_rowtype
			);
      
      
			CALL_BUSINESS_RULES_PKG.BUSINESS_RULES_INPUT_3 (
         in_cost_center_code   
				,v_STORE_rowtype      
				,v_TERMINAL_rowtype      
				,v_TERRITORY_rowtype        
				,v_TERR_ASGN_rowtype    
				,v_TERR_SLS_MGR_rowtype      
				,v_TYPE_rowtype         
        ,v_COST_CENTER_rowtype
			);

--------------------------------------------------------------------------------
    BEGIN  --  Begin Process of Business Rules for the next Cost-Center	
--------------------------------------------------------------------------------

      dbms_output.put_line('Now Processing Cost Center "' ||
            v_COST_CENTER_rowtype.cost_center_code || '" ' ||
            'Category "' || v_COST_CENTER_rowtype.category || '" ' ) ;

			CCN_BUSINESS_RULES_PKG.BUSINESS_RULES_SP( 
         v_ADDRESS_CAN_rowtype
        ,v_ADDRESS_MEX_rowtype
        ,v_ADDRESS_OTH_rowtype
        ,v_ADDRESS_USA_rowtype   
   			,v_ADMIN_rowtype          
				,v_BANKCARD_rowtype       
				,v_COST_CENTER_rowtype   
				,v_MARKETING_rowtype     
				,v_OTHER_rowtype         
				,v_PHONE_rowtype   
				,v_PHONE_PRI_rowtype      
				,v_PHONE_SCD_rowtype      
				,v_POLLING_rowtype     
        ,v_REAL_ESTATE_rowtype
        ,v_SALES_REP_ROWTYPE      
        ,v_STATUS_ROWTYPE         
				,v_STORE_rowtype      
				,v_TERMINAL_rowtype     
				,v_TERRITORY_rowtype        
				,v_TERR_ASGN_rowtype   
				,v_TERR_SLS_MGR_rowtype      
				,v_TYPE_rowtype         
			);

--------------------------------------------------------------------------------
    EXCEPTION  --  Handle Exceptions from Business Rules for one Cost Center
--------------------------------------------------------------------------------

      when others then
--        dbms_output.put_line('Exception inside loop for Cost_Center "' ||
--            v_COST_CENTER_rowtype.cost_center_code || '" ' );

        v_code  := SQLCODE;
        v_errm  := substr(SQLERRM,13,500);
    CALL_BUSINESS_RULES_PKG.LOG_PROCEDURE_ERRORS(v_code, 'CALL_BUSINESS_RULES',
                      v_errm, v_COST_CENTER_rowtype.cost_center_code, v_note ) ;

--------------------------------------------------------------------------------
    END;   --  Ended Process of Business Rules for the next Cost-Center	
--------------------------------------------------------------------------------
      
--------------------------------------------------------------------------------
    EXCEPTION  --  Exceptions
--------------------------------------------------------------------------------

    when others then
        dbms_output.put_line('CALL_BUSINESS_RULES_SP, Exception "When Others" ');
--        dbms_output.put_line(sqlerrm);
        v_code  := SQLCODE;
        v_errm  := substr(SQLERRM,1,200);
        dbms_output.put_line('About to Raise Error at end of CALL_BUSINESS_RULES');
        errpkg.raise_err(v_code, 'CALL_BUSINESS_RULES_SP ' ||
                            v_errm || 'in Others' );
        
--------------------------------------------------------------------------------
END CALL_BUSINESS_RULES_SP;  --  Call_Business_Rules_SP
--------------------------------------------------------------------------------

