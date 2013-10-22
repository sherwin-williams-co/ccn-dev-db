procedure COST_CENTER_BR_SP  (
/*****************************************************************************
	COST_CENTER_BR_SP       3.3.17   'COST_CENTER' TABLE COLUMNS

	This procedure is intended to enforce the Business Rules
	for COST_CENTER validation edits and verifying the following rules:
      
  The list below are the business rules by column for the COST_CENTER table:

    1.	Cost_Center_Code (6-VR): 
        This Field is broken down into two (2) sub fields. 
            The COA (Pick list will be created) code is 2 digits and will be edited (??????), 
            And the 4 digit Cost Center Number which can be any numeric or alpha-numeric number.
        The Cost_Center_Code cannot already be in the COST_CENTER table (New Function).   
        The Cost_Center_Code cannot be Spaces.
        
        In Addition -- For a Cost_Center "ADD"  Address Information must also be present
       ( A Cost_Center may not be added without an Address )       
TAL 05/23/2013 CCNA-384 When a cost center is being added there must be an address being added also

    2.	Category (1-VR/BR): 
        The Category code determines whether a STORE, ADMINISTRATION, REAL_ESTATE, TERRITORY,
            or OTHER table will be stored.  

    3.	Statement_Type (2-VR/BR): 
        This Field (column) cannot be null!
        The Statement_Type determines the Sherwin-Williams entities (usually acquisitions), 
          which are part of the SW family. 
        The Statement_Type is the closest thing to our current GNRC Indicator in IDMS. 
        This code will be used in verifying D-A-D assignments (Hierarchy_Detail table)
          by comparing to the Statement_Type of the Hierarchy_Detail table.
        This code is also used to make sure that the Contry_Code is populated correctly.
        This will happen in the 'Insert' package of the COST_CENTER table.
          Statement_Type is 'MX'    Country_Code is 'MEX'
          Statement_Type is 'PR'    Country_Code is 'PRI'
          Statement_Type is 'TR'    Country_Code is 'TTO'
          Statement_Type is 'JM'    Country_Code is 'JAM'
          Statement_Type is 'AW'    Country_Code is 'ABW'
          Statement_Type is 'CW'    Country_Code is 'CUW'
          Statement_Type is 'AN'    Country_Code is 'ANT'
          Statement_Type is 'GD'    Country_Code is 'GRD'

          Country_Code is 'CAN'    Statement_Type is 'CN','AC','DC'
          
          Country_Code is 'USA'    Statement_Type is 'US','AU','DU','CK','CP','DP','FB',
                                                     'GP','GS','MB','MZ','NP','SG','QK'
TAL 04/29/2013 CCNQC-25 fix to Country Code must match Statement Type added "UN" for "USA"


    4.	Country_Code (3-VR/BR): 
        This Field (column) cannot be null!
        The Country_Code determines the country that the Sherwin-Williams cost center resides.
        This field also determines the Address Table used (ADDRESS_USA, ADDRESS_CAN, ADDRESS_MEX, ADDRESS_OTHER).  
        This will also happen in the 'Insert' package of the COST_CENTER table.
        The Country_Code is compared to the Statement_Type (above) to validate and force consistency between these two fields.
        In most cases, the Statement_Type forces the Country_Code!

    5.	Close_Date (VR/BR): 
        For the Business Rules for this field (column) please refer to the Technical Document (section 3.3.2).

    6.	Financial_Close_Date (VR/BR): 
        This date refers to the date that the Financial Data was cleaned off of the books for a Cost Center.
        This field can only be populated if the cost center has previously been closed 
          (i.e. Close_Date not zeros and STATUS table reflects 'closed' status.

    7.	Currency_Code (3-VR/BR):  
        This field is also influenced by the Country_Code,
          since the Statement_Type, Country_Code, and Currency_Code must correspond to each other.  
        This will also happen in the 'Insert' package of the COST_CENTER table.
          If Country_Code is 'USA' then Currency_Code must be 'USD' for 'Store' cost centers only. 
          If Country_Code is 'CAN' then Currency_Code must be 'CAD' for 'Store' cost centers only.
          If Country_Code is 'GRD' then Currency_Code must be 'GRD' or 'USA' for 'Store' cost centers only.
          If Country_Code is 'MEX' then first two digits of Currency_Code must start with 'MX' for 'Store' cost centers only.

    8.	POS_Prog_Ver_Nbr: 
        There are no edits for this field.  This field can be changed, but is usually updated from Polling (CCN00500). 

    9.	POS_Prog_Ver_Eff_Date: 
        There are no edits for this field.  This field can be changed, but is usually updated from Polling (CCN00500). 
        
   10.  DUNS_NUMBER:
        This field is only required for Store(S) and Other(o) cost centers.
        this field cannot be spaces and must be numeric.

 created : TAL 08/03/2012
 revised : TAL 04/29/2013 CCNQC-25 fix to Country Code must match Statement Type added "UN" for "USA"
           MDH 06/19/2013 added Duns_Number check.
           MDH 07/02/2013 Added GD statement type and GRD for Grenada.
******************************************************************************/	
   
   incost_center_rowtype             cost_center%rowtype
  ,inaddress_can_rowtype             address_can%rowtype
  ,inaddress_mex_rowtype             address_mex%rowtype
  ,inaddress_oth_rowtype             address_other%rowtype
  ,inaddress_usa_rowtype             address_usa%rowtype
       )
   
        IS 

-- Error #01a
   cost_center_pre_not_valid_exp   exception;
   
-- Error #01b
   cost_center_suf_not_valid_exp   exception;
   
-- Error #01c
-- duplicate_cost_center_exp       exception;
   
-- Error #01d
   cctr_must_be_ent_exp            exception;
   
-- Error #01x
   address_info_missing_exp        exception;   
-- TAL 05/23/2013 CCNA-384 When a cost center is being added 
-- there must be an address being added also
   
-- Error #02a  
   invalid_category_exp            exception;
   
-- Error #03a  
   invalid_statement_type_exp      exception;
   
-- Error #04a
   invalid_country_code_exp        exception;
   
-- Error #04b
   country_statement_match_exp     exception;
   
-- Error #05a
-- invalid_close_date_exp          exception;
   
-- Error #06a
   invalid_fin_close_date_exp      exception;
   
-- Error #07a
   invalid_currency_code_exp       exception;
   
-- Error #07b
   country_currency_match_exp      exception;
      
-- Error #10a
   invalid_duns_nbr_exp            exception;
      
-- Error #10b
   invalid_duns_num_exp            exception;
  
   
   v_code   number;
   v_date   date  ;
   v_count  number;
   v_errm   varchar(500);
   v_cost_center  number   := 0 ;
   
   v_address_can_rowtype        Address_CAN%rowtype ;
   v_address_mex_rowtype        Address_MEX%rowtype ;
   v_address_oth_rowtype        Address_OTHER%rowtype ;
   v_address_usa_rowtype        Address_USA%rowtype ;
   
   v_code_detail_country_row          code_detail%rowtype;
   v_code_detail_statement_row        code_detail%rowtype;
 
  
begin

/******************************************************************************
  1).	Cost_Center_Code (6-VR): 
        This Field is broken down into two (2) sub fields. 
      a.      The COA (Pick list will be created) code is 2 digits and will be edited (??????), 
      b.      And the 4 digit Cost Center Number which can be any numeric or alpha-numeric number.
      c.  The Cost_Center_Code cannot already be in the COST_CENTER table (New Function).   
      d.  The Cost_Center_Code cannot be Spaces.
      
        In Addition -- For a Cost_Center "ADD"  Address Information must also be present
       ( A Cost_Center may not be added without an Address )       
TAL 05/23/2013 CCNA-384 When a cost center is being added there must be an address being added also
*******************************************************************************/ 

/*******************************************************************************
      d. Cost_Center can not be null, spaces, or all zeroes, and must 6 characters 
*******************************************************************************/

--    cost_center_code can not be null 
      if  incost_center_rowtype.cost_center_code  is  null
--    cost_center_code can not be just one or more spaces
      or  regexp_like(incost_center_rowtype.cost_center_code, '^ *$')
--    cost_center_code can not be all zeroes
      or  incost_center_rowtype.cost_center_code  =   '000000'   
--    cost_center_code entered must be 6 characters in length
      or  length(incost_center_rowtype.cost_center_code)  !=  6
      then
          raise cctr_must_be_ent_exp;
-- See Error #01d.
      end if;
      
/*******************************************************************************
      a. Cost_Center first 2 digits must be numeric. 
*******************************************************************************/

/*******************************************************************************
      b. Cost_Center last 4 digits must be numeric or alpha.
*******************************************************************************/

/*******************************************************************************
      c. Cost_Center_Code cannot already be in the COST_CENTER table.
*******************************************************************************/	
     
--begin
--
--      select  count(1)  into  v_count
--       from  cost_center
--       where cost_center.cost_center_code     =  incost_center_rowtype.cost_center_code ;
--        
--      if v_count > 0 then
--         raise duplicate_cost_center_exp;  
-- See Error #01c.
--      end if;    
--      
--end;

/*******************************************************************************
        In Addition -- For a Cost_Center "ADD"  Address Information must also be present
       ( A Cost_Center may not be added without an Address )       
TAL 05/23/2013 CCNA-384 When a cost center is being added there must be an address being added also
*******************************************************************************/	
     
  begin
  
        select  count(1)  into  v_count
         from  cost_center
         where cost_center.cost_center_code     =  incost_center_rowtype.cost_center_code ;
          
--      if a Cost_Center not found - this is an add, so verify Address information is present
        if v_count = 0 then
           if inaddress_can_rowtype.cost_center_code  is  null  and
              inaddress_mex_rowtype.cost_center_code  is  null  and
              inaddress_oth_rowtype.cost_center_code  is  null  and
              inaddress_usa_rowtype.cost_center_code  is  null  then
                 raise address_info_missing_exp;
-- See Error #01x.
-- TAL 05/23/2013 CCNA-384 When a cost center is being added 
-- there must be an address being added also
           end if;
        end if; 
        
  end;

/*******************************************************************************
  2).	Category (1-VR/BR): 
      a.  The Category determines whether a the Cost_Center is a:
          STORE, ADMINISTRATION, REAL_ESTATE, TERRITORY, or OTHER.  
          'A' = Admisistration
          'R' = Real Estate
          'S' = Store
          'T' = Territory
          'O' = Other
*******************************************************************************/

      if  not  common_tools.code_detail_valid('CATEGORY', incost_center_rowtype.category) 
      or       incost_center_rowtype.category  is  null    then 
          raise invalid_category_exp;
-- See Error #02a
      end if;

/*******************************************************************************
  3).	Statement_Type (2-VR/BR): 
      a.  This Field (column) cannot be null!
          Must match an entry in the table below.
          Statement_Type is 'MX'    Country_Code is 'MEX'
          Statement_Type is 'PR'    Country_Code is 'PRI'
          Statement_Type is 'TR'    Country_Code is 'TTO'
          Statement_Type is 'JM'    Country_Code is 'JAM'
          Statement_Type is 'AW'    Country_Code is 'ABW'
          Statement_Type is 'CW'    Country_Code is 'CUW'
          Statement_Type is 'AN'    Country_Code is 'ANT'
          Statement_Type is 'GD'    Country_Code is 'GRD'          

          Country_Code is 'CAN'    Statement_Type is 'CN','AC','DC'
          
          Country_Code is 'USA'    Statement_Type is 'US','AU','DU','CK','CP','DP','FB',
                                                     'GP','GS','MB','MZ','NP','SG','QK'
TAL 04/29/2013 CCNQC-25 fix to Country Code must match Statement Type added "UN" for "USA"

*******************************************************************************/

/*******************************************************************************
	     a. validate Statement_Type
*******************************************************************************/	

      if  not  common_tools.code_detail_valid('STATEMENT_TYPE', incost_center_rowtype.statement_type) 
      or       incost_center_rowtype.statement_type  is  null    then
          raise invalid_statement_type_exp;
-- See Error #03a
      end if;
      
/*******************************************************************************
  4).	Country_Code (3-VR/BR):
      a.  This Field (column) cannot be null!
          Must match an entry in the table below.
          Statement_Type is 'MX'    Country_Code is 'MEX'
          Statement_Type is 'PR'    Country_Code is 'PRI'
          Statement_Type is 'TR'    Country_Code is 'TTO'
          Statement_Type is 'JM'    Country_Code is 'JAM'
          Statement_Type is 'AW'    Country_Code is 'ABW'
          Statement_Type is 'CW'    Country_Code is 'CUW'
          Statement_Type is 'AN'    Country_Code is 'ANT'
          Statement_Type is 'GD'    Country_Code is 'GRD'

          Country_Code is 'CAN'    Statement_Type is 'CN','AC','DC'
          
          Country_Code is 'USA'    Statement_Type is 'US','AU','DU','CK','CP','DP','FB',
                                                     'GP','GS','MB','MZ','NP','SG','QK'
TAL 04/29/2013 CCNQC-25 fix to Country Code must match Statement Type added "UN" for "USA"
                                                     
      b.  Country_Code must match to Statement_Type.

*******************************************************************************/

/*******************************************************************************
	    a. validate Country_Code
*******************************************************************************/	  

      if  not  common_tools.code_detail_valid('COUNTRY_CODE', incost_center_rowtype.country_code) 
      or       incost_center_rowtype.country_code  is  null   then
          raise invalid_country_code_exp;
-- See Error #04a
      end if;
      
/*******************************************************************************
	    b. validate Country_Code and Statement_Type match
*******************************************************************************/	  

--a funtion to call translation table will replace code in this section.

/*******************************************************************************
This matching routine needs to be better defined 
MDH 07/02/2013 Added GD statement type and GRD for Grenada.
*******************************************************************************/

      if (incost_center_rowtype.country_code        =   'MEX'
      and incost_center_rowtype.statement_type  not in ('MX') )
      
      or (incost_center_rowtype.country_code        =   'PRI'
      and incost_center_rowtype.statement_type  not in ('PR') )
      
      or (incost_center_rowtype.country_code        =   'TTO'
      and incost_center_rowtype.statement_type  not in ('TR') )
      
      or (incost_center_rowtype.country_code        =   'JAM'
      and incost_center_rowtype.statement_type  not in ('JM') )
      
      or (incost_center_rowtype.country_code        =   'ABW'
      and incost_center_rowtype.statement_type  not in ('AW') )
      
      or (incost_center_rowtype.country_code        =   'CUW'
      and incost_center_rowtype.statement_type  not in ('CW') )
      
      or (incost_center_rowtype.country_code        =   'ANT'
      and incost_center_rowtype.statement_type  not in ('AN') )
            
      or (incost_center_rowtype.country_code        =   'GRD'
      and incost_center_rowtype.statement_type  not in ('GD') )
      
      or (incost_center_rowtype.country_code        =   'CAN'
      and incost_center_rowtype.statement_type  not in ('CN','AC','DC') )
      
      or (incost_center_rowtype.country_code        =   'USA'
      and incost_center_rowtype.statement_type  not in ('US','AU','DU','CK','CP','DP','FB','UN',
--  TAL 04/29/2013 CCNQC-25 fix to Country Code must match Statement Type added "UN" for "USA"
                                                        'GP','GS','MB','MZ','NP','SG','QK') )  
      then
               raise country_statement_match_exp;
-- See Error #04b          
      end if;

/*******************************************************************************
  5). Close_Date (VR/BR): 
      a.  For the Business Rules for this field (column) please refer to the Technical Document (section 3.3.2).
          Not necessary, CLOSE_CCNTR_SP procedure checks close date.
          MDH 01/17/2013     
*******************************************************************************/	  

/*******************************************************************************
	    a. validate Close_Date
*******************************************************************************/	  

--     if  incost_center_rowtype.close_date  is not  null    then
--          raise invalid_close_date_exp;
-- See Error #05a
--      end if;

/*******************************************************************************
  6).	Financial_Close_Date (VR/BR): 
        This date refers to the date that the Financial Data was cleaned off of the books for a Cost Center.
        This field can only be populated if the cost center has previously been closed 
          (i.e. Close_Date not zeros and STATUS table reflects 'closed' status.

*******************************************************************************/	  

/*******************************************************************************
	    a. validate Financial_Close_Date
 *******************************************************************************/

      if  incost_center_rowtype.financial_close_date  is not  null    then
      
begin

      v_date  :=  incost_center_rowtype.financial_close_date;
-- Yes, it was a valid date (no EXCEPTION)

EXCEPTION
  when others then
  raise invalid_fin_close_date_exp;
-- No,  not a valid date
-- See Error #06a
end;

      end if;
      
/*******************************************************************************
  7). Currency_Code (3-VR/BR):  
      a. This field is also influenced by the Country_Code,
          since the Statement_Type, Country_Code, and Currency_Code must correspond to each other.  
        This will also happen in the 'Insert' package of the COST_CENTER table.
          If Country_Code is 'USA' then Currency_Code must be 'USD' for 'Store' cost centers only. 
          If Country_Code is 'CAN' then Currency_Code must be 'CAD' for 'Store' cost centers only.
          If Country_Code is 'GRD' then Currency_Code must be 'GRD' or 'USA' for 'Store' cost centers only.
          If Country_Code is 'MEX' then first two digits of Currency_Code must start with 'MX' for 'Store' cost centers only.
*******************************************************************************/	  

/*******************************************************************************
	     a. validate Currency_Code
                 
MDH 07/02/2013 Added GD statement type and GRD for Grenada.      
*******************************************************************************/	  

--  Currency_Code edit is valid for "Store" Cost_Centers only

      if  incost_center_rowtype.category  =  'S'    then
          
          if  not  common_tools.code_detail_valid('CURRENCY_CODE', incost_center_rowtype.currency_code) 
          or   incost_center_rowtype.currency_code  is  null    then
               raise invalid_currency_code_exp;
-- See Error #07a
          end if;
          
          if ( incost_center_rowtype.country_code    =  'USA'
          and  incost_center_rowtype.currency_code  !=  'USD' )
          
          or ( incost_center_rowtype.country_code    =  'CAN'
          and  incost_center_rowtype.currency_code  !=  'CAD' )
                    
          or ( incost_center_rowtype.country_code    =  'GRD'
          and (incost_center_rowtype.currency_code  !=  'GRD'
          and   incost_center_rowtype.currency_code  !=  'USD' ) )
          
          or ( incost_center_rowtype.country_code    =  'MEX'
          and  substr(incost_center_rowtype.currency_code,1,2)  !=  'MX' )  
                                                                then
               raise country_currency_match_exp;
-- See Error #07b
          end if;
          
      end if;
      
/*******************************************************************************
  8). POS_Prog_Ver_Nbr: 
      a. There are no edits for this field.  This field can be changed, but is usually updated from Polling (CCN00500). 
*******************************************************************************/	  

/*******************************************************************************
	    a. validate POS_Prog_Ver_Nbr
*******************************************************************************/	  

/*******************************************************************************
  9). POS_Prog_Ver_Eff_Date: 
      a. there are no edits for this field.  this field can be changed, but is usually updated from polling (ccn00500). 
*******************************************************************************/	  

/*******************************************************************************
	    a. validate POS_Prog_Ver_Eff_Date
*******************************************************************************/	  


/*******************************************************************************
 10). DUNS_NUMBER: 
      a. The duns number must be entered for Store(S) and Other(O) Cost Centers
         It cannot be null or spaces and must be numeric. 
*******************************************************************************/	  
      
begin
  if (incost_center_rowtype.CATEGORY  in ('S', 'O'))   then
      if (incost_center_rowtype.DUNS_NUMBER is NULL  
      or  incost_center_rowtype.DUNS_NUMBER = '         ')  then
-- See Error #10a      
           raise invalid_duns_nbr_exp;
      end if;
     if not regexp_like(incost_center_rowtype.DUNS_NUMBER, '\d{9}')  then
-- See Error #10b      
           raise invalid_duns_num_exp;
      end if;
  end if;
end;


/*******************************************************************************
	  EXCEPTION ERRORS AREA
*******************************************************************************/	  
	
          EXCEPTION

-- Error #01c
--               when duplicate_cost_center_exp then
--                    v_code := errnums.en_duplicate_cost_center_err; 
--                    errpkg.raise_err(v_code, 'COST_CENTER_BR_SP.duplicate_cost_center_exp '  ,
--                   'Cost_Center_Code was entered as "' || incost_center_rowtype.cost_center_code || '". ' ||
--                   'However, Cost_Center already exists.' );  

-- Error #01b
--             when invalid_cost_center_exp  then  
--                  v_code := errnums.en_invalid_cost_center_err;
--                  errpkg.raise_err(v_code, 'COST_CENTER_BR_SP.invalid_cost_center_exp ' ,
--                 'Cost_Center_Code was entered as "' || incost_center_rowtype.cost_center_code || '", ' ||
--                 'However, specified Cost_Center was not found.' );
          
-- Error #01d
               when cctr_must_be_ent_exp     then
                    v_code := errnums.en_cctr_must_be_ent_err; 
                    errpkg.raise_err(v_code, 'COST_CENTER_BR_SP.cctr_must_be_ent_exp ' ,
                   'Cost_Center_Code was entered as "' || incost_center_rowtype.cost_center_code || '", ' ||
                   'However, Cost_Center_Code must be entered , can not be "null" or "spaces", ' ||
                   'and must be 6 digits numeric.' );  

-- Error #01x
                 when address_info_missing_exp then
                      v_code := errnums.en_address_info_missing_err; 
                      errpkg.raise_err(v_code, 'COST_CENTER_BR_SP.address_info_missing_exp '  ,
                     'Cost_Center_Code was entered as "' || incost_center_rowtype.cost_center_code || '". ' ||
                     'However, for new Cost Centers, Address information must also be entered.' );  
 
                    
-- Error #02a
               when invalid_category_exp then
                    v_code := errnums.en_invalid_code_detail_err;
                    errpkg.raise_err(v_code, 'COST_CENTER_BR_SP.category_not_valid_exp ' ,
                   'Category was entered as "' || incost_center_rowtype.category || '". ' || 
                   'This value was not found on the Code_Detail table.');  
                   
-- Error #03a
               when invalid_statement_type_exp then
                    v_code := errnums.en_invalid_code_detail_err;
                    errpkg.raise_err(v_code, 'COST_CENTER_BR_SP.invalid_statement_type_exp ' ,
                   'Statement_Type was entered as "' || incost_center_rowtype.statement_type || '". ' || 
                   'This value was not found on the Code_Detail table.'); 
                   
-- Error #04a
               when invalid_country_code_exp then
                    v_code := errnums.en_invalid_code_detail_err;
                    errpkg.raise_err(v_code, 'COST_CENTER_BR_SP.invalid_country_code_exp ' ,
                   'Country_Code was entered as "' || incost_center_rowtype.country_code || '". ' || 
                   'This value was not found on the Code_Detail table.'); 
                   
-- Error #04b
               when country_statement_match_exp then
                    v_code := errnums.en_country_stmt_match_err;
                    errpkg.raise_err(v_code, 'COST_CENTER_BR_SP.country_statement_match_exp ' ,
                   'Country_Code and Statement_Type were entered as  "' || incost_center_rowtype.country_code ||
                   '" and "' || incost_center_rowtype.statement_type || '". ' ||
                   'These two fields must contain corresponding values.' );  
                   
-- Error #05a
--               when invalid_close_date_exp then
--                    v_code := errnums.en_invalid_close_date_err;
--                    errpkg.raise_err(v_code, 'COST_CENTER_BR_SP.invalid_close_date_exp ' ,
--                   'Close_Date was entered as  "' || incost_center_rowtype.close_date || '". ' ||
--                   'However, Close_Date can not be entered.' );  
                   
-- Error #06a
               when invalid_fin_close_date_exp then
                    v_code := errnums.en_invalid_fin_close_date_err;
                    errpkg.raise_err(v_code, 'COST_CENTER_BR_SP.invalid_fin_close_date_exp ' ,
                   'Fin_Close_Date was entered as  "' || incost_center_rowtype.financial_close_date || '". ' ||
                   'However, Fin_Close_Date must be a valid date.' );  
                   
-- Error #07a
               when invalid_currency_code_exp then
                    v_code := errnums.en_invalid_currency_code_err;
                    errpkg.raise_err(v_code, 'COST_CENTER_BR_SP.invalid_currency_code_exp ' ,
                   'Currency_Code was entered as  "' ||  incost_center_rowtype.currency_code || '". ' ||
                   'This value was not found on the Code_Detail table.'); 
                   
-- Error #07a
               when country_currency_match_exp then
                    v_code := errnums.en_country_currency_match_err;
                    errpkg.raise_err(v_code, 'COST_CENTER_BR_SP.country_currency_match_exp ' ,
                   'Country_Code and Currency_Code were entered as  "' || incost_center_rowtype.country_code ||
                   '" and "' ||  incost_center_rowtype.currency_code || '". ' ||
                   'These two fields must contain corresponding values.' );  
                   
-- Error #08a       no edits for this field
                   
-- Error #09a       no edits for this field

-- Error #10a  
               when invalid_duns_nbr_exp then
                    v_code := errnums.en_invalid_duns_number_err;
                    errpkg.raise_err(v_code, 'COST_CENTER_BR_SP.invalid_duns_nbr_exp ' ,
                   'Duns Number is Mandatory for Store and Other Cost Centers');  
-- Error #10b  
               when invalid_duns_num_exp then
                    v_code := errnums.en_invalid_duns_number_err;
                    errpkg.raise_err(v_code, 'COST_CENTER_BR_SP.invalid_duns_num_exp ' ,
                   'Duns Number must be numeric');  

end COST_CENTER_BR_SP;
/

