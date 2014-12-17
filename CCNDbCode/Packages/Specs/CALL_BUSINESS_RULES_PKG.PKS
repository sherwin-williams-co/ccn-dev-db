create or replace PACKAGE CALL_BUSINESS_RULES_PKG AS
/******************************************************************************
This package SPEC has procedures and functions related to the CALL_BUSINESS_RULES Package

created : 03/05/2013 TAL CCN project
changes : 12/16/2014 AXK326 CCN Project Team....
          Code changes made after deleting the sales manager link from the Territory Table

*******************************************************************************/


PROCEDURE CALL_BUSINESS_RULES_SP  ( 
/******************************************************************************
	CALL_BUSINESS_RULES_SP   --    Business Rules Calling Procedure

	This procedure is intended to call the Business Rules Package for all 
  	Cost Center table entries returned from the Database.
  
created : 02/26/2013 TAL CCN Project....
revised :
*******************************************************************************/
   in_Cost_Center_Code      IN   COST_CENTER.Cost_Center_Code%type  
  );


PROCEDURE BUSINESS_RULES_INPUT_1 (
/******************************************************************************
	BUSINESS_RULES_INPUT_1 

	This procedure will Build the Business Rules 1 Rowtype ROWs
			COST_CENTER%rowtype
			ADMINISTRATION%rowtype
			BANK_CARD%rowtype
			MARKETING%rowtype
			OTHER%rowtype
			PHONE_FAX%rowtype

created : 02/21/2013 MDH -- CCN Project....
******************************************************************************/
-- Below are the fields required for the Business_Rules_Input call: 
-- Cost_Center_code, Table_Rowtypes 

   in_cost_center            in   varchar2
  ,v_COST_CENTER_rowtype     out  COST_CENTER%rowtype
  ,v_ADMINISTRATION_rowtype  out  ADMINISTRATION%rowtype
  ,v_BANK_CARD_rowtype       out  BANK_CARD%rowtype
  ,v_MARKETING_rowtype       out  MARKETING%rowtype
  ,v_OTHER_rowtype           out  OTHER%rowtype
  ,v_PHONE_FAX_rowtype       out  PHONE%rowtype
  );


PROCEDURE BUSINESS_RULES_INPUT_2 (
/******************************************************************************
	BUSINESS_RULES_INPUT_2 

	This procedure will Build the Business Rules 2 Rowtype ROWs
			PHONE%rowtype	PRI Primary
			PHONE%rowtype   SCD Secondary
			POLLING%rowtype
			REAL_ESTATE%rowtype
			SALES_REP%rowtype
			STATUS%rowtype
			COST_CENTER%rowtype
			TERRITORY_ASSIGNMENT%rowtype

created : 02/21/2013 BLR -- CCN Project....
******************************************************************************/
-- Below are the fields required for the Business_Rules_Input call: 
-- Cost_Center_code, Table_Rowtypes 

   in_cost_center_code             in   varchar2
  ,V_PHONE_PRI_ROWTYPE             out  PHONE%rowtype
  ,V_PHONE_SCD_ROWTYPE             out  PHONE%rowtype
  ,V_POLLING_ROWTYPE               out  POLLING%rowtype
  ,V_REAL_ESTATE_ROWTYPE           out  REAL_ESTATE%rowtype
  ,V_SALES_REP_ROWTYPE             out  SALES_REP%rowtype
  ,V_STATUS_ROWTYPE                out  STATUS%rowtype
  ,V_cost_center_rowtype           out  COST_CENTER%rowtype
  ,V_terr_asgn_rowtype             out  TERRITORY_ASSIGNMENT%rowtype
  );


PROCEDURE BUSINESS_RULES_INPUT_3 (
/******************************************************************************
	BUSINESS_RULES_INPUT_3 

	This procedure will Build the Business Rules 3 Rowtype ROWs
			STORE%rowtype
			TERMINAL%rowtype
			TERRITORY%rowtype
			TERRITORY_ASSIGNMENT%rowtype
		--	TERRITORY_SALES_MGR%rowtype
			TYPE%rowtype
			COST_CENTER%rowtype

created : 02/21/2013 TAL    -- CCN Project....
Modified: 12/15/2014 axk326 -- CCN Project Team....
          Removed Territory_sls_mgr
******************************************************************************/
-- Below are the fields required for the Business_Rules_Input call: 
-- Cost_Center_code, Table_Rowtypes 

   in_cost_center          in   varchar2
  ,v_STORE_rowtype  	     out  STORE%rowtype
  ,v_TERMINAL_rowtype      out  TERMINAL%rowtype
  ,v_TERRITORY_rowtype     out  TERRITORY%rowtype
  ,v_TERR_ASGN_rowtype     out  TERRITORY_ASSIGNMENT%rowtype
  ,v_TYPE_rowtype          out  TYPE%rowtype
  ,v_COST_CENTER_rowtype   out  COST_CENTER%rowtype
  );  
  
  
PROCEDURE LOG_PROCEDURE_ERRORS  (
/*******************************************************************************
  This Procedure is designed to LOG Processing Errors to the ERROR_LOG Table
  
  v_code      the '-99999' Component of the Oracle Error Message 'ORA-99999'
  v_proc      the calling procedure name
  v_errm      the error message to be written to the ERROR_LOG
  v_cost_center   Cost_Center occurrence during processing
  v_note      optional notes to be written to the ERROR_LOG
  
Created: 02/28/2013 TAL
Updated: 05/21/2013 TAL - added v_note to the parameter list
*******************************************************************************/
    v_code         IN   VARCHAR2
   ,v_proc         IN   VARCHAR2
   ,v_errm         IN   VARCHAR2
   ,v_cost_center  IN   VARCHAR2
   ,v_note         IN   VARCHAR2
   );


END CALL_BUSINESS_RULES_PKG;