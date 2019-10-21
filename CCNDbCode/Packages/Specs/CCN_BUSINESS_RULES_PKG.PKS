create or replace PACKAGE          CCN_BUSINESS_RULES_PKG
    AS
/******************************************************************************
	CCN_BUSINESS_RULES_PKG  SPEC

	This Package SPEC is intended to validate business rules for
	CCN application

created :kdp 4/26/2012 
revised :mdh 9/24/2012
         mdh 10/16/2012 - added Business_Rules_SP (rowtype & xml) procedures
         12/16/2014 AXK326 CCN Project Team....
         Code changes made after deleting the sales manager link from the Territory Table
         Changed: 04/17/17 rxa457 --added Business Rules for DISPATCH_TERMINAL
*******************************************************************************/


PROCEDURE Business_Rules_sp (
/*******************************************************************************
	 BUSINESS_RULES_SP  (XML to Rowtype Conversion)

  This procedure is intended to pull in the XML versions of the CCN tables, and
  convert them to ROWTYPEs.

  This procedure will then call the BUSINESS_RULES_SP (Rowtype) procedure which 
  is the "main" Business Rules procedure; which will execute each of the 
  individual business rules.    

created : MDH 10/04//2012
changed : 05/16/2016 jxc517 CCN Project Team....
          Added new table ADDRESS_BRB
Changed:  03/08/2018 mxv711 CCN Project Team..
          asp400:asp-763 changes to handle LAD_CUSTOMER in CCN
******************************************************************************/	
    inADDRESS_CAN_XMLTYPE       VARCHAR2--sys.xmltype
   ,inADDRESS_MEX_XMLTYPE       VARCHAR2--sys.xmltype
   ,inADDRESS_OTH_XMLTYPE       VARCHAR2--sys.xmltype
   ,inADDRESS_USA_XMLTYPE       VARCHAR2--sys.xmltype
   ,inADDRESS_BRB_XMLTYPE       VARCHAR2--sys.xmltype
   ,inADMIN_XMLTYPE             VARCHAR2--sys.xmltype
   ,inLAD_CUSTOMER_XMLTYPE       VARCHAR2--sys.xmltype
   ,inBANKCARD_XMLTYPE          VARCHAR2--sys.xmltype
   ,inCOST_CENTER_XMLTYPE       VARCHAR2--sys.xmltype
   ,inMARKETING_XMLTYPE         VARCHAR2--sys.xmltype
   ,inOTHER_XMLTYPE             VARCHAR2--sys.xmltype
   ,inPhone_XMLTYPE             VARCHAR2--sys.xmltype
   ,inPHONE_PRI_XMLTYPE         VARCHAR2--sys.xmltype
   ,inPHONE_SCD_XMLTYPE         VARCHAR2--sys.xmltype
   ,inPOLLING_XMLTYPE           VARCHAR2--sys.xmltype
   ,inREAL_ESTATE_XMLTYPE       VARCHAR2--sys.xmltype
   ,inSALES_REP_XMLTYPE         VARCHAR2--sys.xmltype
   ,inSTATUS_XMLTYPE            VARCHAR2--sys.xmltype
   ,inSTORE_XMLTYPE             VARCHAR2--sys.xmltype
   ,inDISPATCH_TERMINAL_XMLTYPE VARCHAR2 --sys.xmltype
   ,inTERMINAL_XMLTYPE          VARCHAR2--sys.xmltype
   ,inTERRITORY_XMLTYPE         VARCHAR2--sys.xmltype
   ,inTYPE_XMLTYPE              VARCHAR2--sys.xmltype
--   ,inADDRESS_ARG_XMLTYPE    VARCHAR2--sys.xmltype
--   ,inADDRESS_BRA_XMLTYPE    VARCHAR2--sys.xmltype
--   ,inADDRESS_CHL_XMLTYPE    VARCHAR2--sys.xmltype
--   ,inADDRESS_COL_XMLTYPE    VARCHAR2--sys.xmltype
--   ,inADDRESS_ECU_XMLTYPE    VARCHAR2--sys.xmltype
--   ,inADDRESS_PER_XMLTYPE    VARCHAR2--sys.xmltype
--   ,inADDRESS_URU_XMLTYPE    VARCHAR2--sys.xmltype
   --,IN_OVERWRITE_FLAG        VARCHAR2 DEFAULT 'N'
 );

PROCEDURE Business_Rules_sp (
/*******************************************************************************
	 BUSINESS_RULES_SP (rowtype)

	This procedure is intended to be the "main" Business Rules procedure.  This
  routine will be excuted both by Batch and our UI Screens.

	Its purposes is to execute each of the individual Business Rules as defined
  in the Technical Document (Section 3.3) and housed in the Business Rules
	Package.

  Each Table specific business rule will be executed first if the related
  table rowtype is not "null".  

  Finally, specific Business Rules will be executed based on changes within
  specific columns of specific tables.

created : MDH 9/25//2012
Changed:  03/08/2018 mxv711 CCN Project Team..
          asp400:asp-763 changes to handle LAD_CUSTOMER in CCN
******************************************************************************/	
    inADDRESS_CAN_ROWTYPE       IN ADDRESS_CAN%ROWTYPE
   ,inADDRESS_MEX_ROWTYPE       IN ADDRESS_MEX%ROWTYPE
   ,inADDRESS_OTH_ROWTYPE       IN ADDRESS_OTHER%ROWTYPE
   ,inADDRESS_USA_ROWTYPE       IN ADDRESS_USA%ROWTYPE
   ,inADDRESS_BRB_ROWTYPE       IN ADDRESS_BRB%ROWTYPE
   ,inADMIN_ROWTYPE             IN ADMINISTRATION%ROWTYPE
   ,inLAD_CUSTOMER_ROWTYPE      IN LAD_CUSTOMER%ROWTYPE
   ,inBANKCARD_ROWTYPE          IN BANK_CARD%ROWTYPE
   ,inCOST_CENTER_ROWTYPE       IN COST_CENTER%ROWTYPE
   ,inMARKETING_ROWTYPE         IN MARKETING%ROWTYPE
   ,inOTHER_ROWTYPE             IN OTHER%ROWTYPE
   ,inPhone_ROWTYPE             IN PHONE%ROWTYPE
   ,inPHONE_PRI_ROWTYPE         IN PHONE%ROWTYPE
   ,inPHONE_SCD_ROWTYPE         IN PHONE%ROWTYPE
   ,inPOLLING_ROWTYPE           IN POLLING%ROWTYPE
   ,inREAL_ESTATE_ROWTYPE       IN REAL_ESTATE%ROWTYPE
   ,inSALES_REP_ROWTYPE         IN SALES_REP%ROWTYPE
   ,inSTATUS_ROWTYPE            IN STATUS%ROWTYPE
   ,inSTORE_ROWTYPE             IN STORE%ROWTYPE
   ,inDISPATCH_TERMINAL_ROWTYPE IN DISPATCH_TERMINAL%ROWTYPE
   ,inTERMINAL_ROWTYPE          IN TERMINAL%ROWTYPE
   ,inTERRITORY_ROWTYPE         IN TERRITORY%ROWTYPE
   ,inTYPE_ROWTYPE              IN TYPE%ROWTYPE
--   ,inADDRESS_ARG_ROWTYPE    IN ADDRESS_ARG%ROWTYPE
--   ,inADDRESS_BRA_ROWTYPE    IN ADDRESS_BRA%ROWTYPE
--   ,inADDRESS_CHL_ROWTYPE    IN ADDRESS_CHL%ROWTYPE
--   ,inADDRESS_COL_ROWTYPE    IN ADDRESS_COL%ROWTYPE
--   ,inADDRESS_ECU_ROWTYPE    IN ADDRESS_ECU%ROWTYPE
--   ,inADDRESS_PER_ROWTYPE    IN ADDRESS_PER%ROWTYPE
--   ,inADDRESS_URU_ROWTYPE    IN ADDRESS_URU%ROWTYPE
--   --,IN_OVERWRITE_FLAG        IN VARCHAR2 DEFAULT 'N'
 );

FUNCTION MODULUS_10 (inValidate_nbr IN varchar)
/******************************************************************************
	MODULUS_10

	This function will calculate the check digit for a number
	passed in.  DO NOT PASS THE CHECK DIGIT WITH THE NUMBER.

created : KDP 4/26/2012
*******************************************************************************/	
RETURN number;	

PROCEDURE CLOSE_CCNTR_SP ( 
/*****************************************************************************
	CLOSE_CCNTR_SP

	This procedure is intended enforce the Business Rules
	for closing a cost center and verifying the Close_Date, Status_Code, and
  Effective_Date on the various Tables.  

created : MDH 5/18/2012
changed:  MDH 7/25/2012
changed : 02/28/2019 sxg151 ASP-1219
******************************************************************************/	
  inSTATUS_ROWTYPE      IN STATUS%ROWTYPE
 ,inCOST_CENTER_ROWTYPE IN COST_CENTER%ROWTYPE
 ,INTERRITORY_ROWTYPE   IN TERRITORY%ROWTYPE
 ,indispatch_terminal_rowtype IN DISPATCH_TERMINAL%ROWTYPE)
;	

PROCEDURE DEST_PT_CHECK_DGT_ID_SP (
/*******************************************************************************
	DEST_PT_CHECK_DGT_ID_SP

	This procedure is intended enforce the Business Rules
	for verifying the the Check_digit on the Address_USA Table
	TRD  Section: 3.3.4 

created : BLR 5/17/2012
*******************************************************************************/	
 inCheck_digit      IN ADDRESS_USA.check_digit%TYPE
,inDest_point       IN ADDRESS_USA.destination_point%TYPE 
,inAddress_type     IN ADDRESS_USA.address_type%TYPE)   
;

PROCEDURE POLLING_STATUS_HIST_SP (
/*******************************************************************************
	POLLING_STATUS_HIST_SP

	This procedure is intended enforce the Business Rules
	for verifying the POLLING_STATUS_Code on the POLLING Table
	TRD  Section: 3.3.6

created : BLR 6/13/2012
*******************************************************************************/	
   inCOST_CENTER_ROWTYPE        IN COST_CENTER%ROWTYPE 
  ,inPOLLING_ROWTYPE            IN POLLING%ROWTYPE
  ,inSTATUS_ROWTYPE             IN STATUS%ROWTYPE
  ,inTYPE_ROWTYPE               IN TYPE%ROWTYPE
  ,inTERMINAL_ROWTYPE           IN TERMINAL%ROWTYPE
  ,V_TERMINAL_ACTIVE_FLAG       IN VARCHAR2
  ,inBANKCARD_ROWTYPE           IN BANK_CARD%ROWTYPE
  ,inPHONE_ROWTYPE              IN PHONE%ROWTYPE
  ,inPHONE_PRI_ROWTYPE          IN PHONE%ROWTYPE
  ,inPHONE_SCD_ROWTYPE          IN PHONE%ROWTYPE
  ,inSTORE_ROWTYPE              IN STORE%ROWTYPE
  ,inADDRESS_CAN_ROWTYPE        IN ADDRESS_CAN%ROWTYPE
  ,inADDRESS_MEX_ROWTYPE        IN ADDRESS_MEX%ROWTYPE
  ,inADDRESS_OTH_ROWTYPE        IN ADDRESS_OTHER%ROWTYPE
  ,inADDRESS_USA_ROWTYPE        IN ADDRESS_USA%ROWTYPE
  ,inADDRESS_BRB_ROWTYPE        IN ADDRESS_BRB%ROWTYPE
  );

PROCEDURE QUALITY_CTRL_STATUS_CHKS_SP (
/*******************************************************************************
	QUALITY_CTRL_STATUS_CHKS_SP

	This procedure is intended to enforce the Business Rules
	When a cost center is changed to "Q", there are checks for certain fields
	to be filled in as well as records to be active. An active record is when
	effective date is less than or equal to current date and expiration date is 
  zeros/null.
	TRD  Section: 3.3.7 

created : BLR 6/13/2012
*******************************************************************************/	
   inCOST_CENTER_ROWTYPE        IN COST_CENTER%ROWTYPE 
  ,inPOLLING_ROWTYPE            IN POLLING%ROWTYPE
  ,inSTATUS_ROWTYPE             IN STATUS%ROWTYPE
  ,inTYPE_ROWTYPE               IN TYPE%ROWTYPE
  ,inTERMINAL_ROWTYPE           IN TERMINAL%ROWTYPE
  ,V_TERMINAL_ACTIVE_FLAG       IN VARCHAR2
  ,inBANKCARD_ROWTYPE           IN BANK_CARD%ROWTYPE
);

PROCEDURE POLLING_CTRL_STATUS_CHKS_SP (
/*******************************************************************************
	 POLLING_CTRL_STATUS_CHKS_SP

	This procedure is intended enforce the Business Rules
	for verifying the POLLING_STATUS_Code on the POLLING Table
	TRD  Section: 3.3.8 

created : BLR 5/21/2012
*******************************************************************************/	
   inCOST_CENTER_ROWTYPE        IN COST_CENTER%ROWTYPE 
  ,inPOLLING_ROWTYPE            IN POLLING%ROWTYPE
  ,inSTATUS_ROWTYPE             IN STATUS%ROWTYPE
  ,inTYPE_ROWTYPE               IN TYPE%ROWTYPE
  ,inTERMINAL_ROWTYPE           IN TERMINAL%ROWTYPE
  ,V_TERMINAL_ACTIVE_FLAG       IN VARCHAR2
  ,inBANKCARD_ROWTYPE           IN BANK_CARD%ROWTYPE
  ,inPHONE_ROWTYPE              IN PHONE%ROWTYPE
  ,inPHONE_PRI_ROWTYPE          IN PHONE%ROWTYPE
  ,inPHONE_SCD_ROWTYPE          IN PHONE%ROWTYPE
  ,inSTORE_ROWTYPE              IN STORE%ROWTYPE
  ,inADDRESS_CAN_ROWTYPE        IN ADDRESS_CAN%ROWTYPE
  ,inADDRESS_MEX_ROWTYPE        IN ADDRESS_MEX%ROWTYPE
  ,inADDRESS_OTH_ROWTYPE        IN ADDRESS_OTHER%ROWTYPE
  ,inADDRESS_USA_ROWTYPE        IN ADDRESS_USA%ROWTYPE
  ,inADDRESS_BRB_ROWTYPE        IN ADDRESS_BRB%ROWTYPE
 );

PROCEDURE REOPEN_CCNTR_SP  ( 
/*****************************************************************************
	REOPEN_CCNTR_SP

  This procedure is intended enforce the Business Rules for Re-Opening a
	closed cost center and verifying the Close_Date, Status_Code, Tyep_Code,
  Effective_Date and Expiration_Date on the various Tables.  

created : NDH 6/01/2012
******************************************************************************/	
  inSTATUS_ROWTYPE      IN STATUS%ROWTYPE
 ,inCOST_CENTER_ROWTYPE IN COST_CENTER%ROWTYPE
 ,inTERRITORY_ROWTYPE   IN TERRITORY%ROWTYPE 
 ,inTYPE_ROWTYPE        IN TYPE%ROWTYPE)
;

PROCEDURE TERRITORY_HOME_STORE_ASSIGN_SP ( 
/*****************************************************************************
	TERRITORY_HOME_STORE_ASSIGN_SP

	This procedure is intended enforce the Business Rules
	for Territory Home Store assignment and Territory Category, Home Store, 
  Home Store not Closed, Statement Type, and Entity Type.

created : TAL 06/01/2012
******************************************************************************/	
  inCOST_CENTER_ROWTYPE    IN   COST_CENTER%ROWTYPE
 ,inTERRITORY_ROWTYPE      IN   TERRITORY%ROWTYPE )
;	
-- 

PROCEDURE CHECK_ADDRESS_TAG ( 
/*****************************************************************************
	CHECK_ADDRESS_TAG

	This procedure is intended to enforce the Business Rules
	for Cost center insert/update to have atleast one address element:

  1.)  Check if cost center insert or update have atleast one address element added.


created : mxv711 11/09/2017

******************************************************************************/	
  in_COST_CENTER_CATEGORY IN COST_CENTER.CATEGORY%TYPE
 ,in_Row_data    IN xmltype)	;
--
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                       TABLE SPECIFIC BUSINESS RULES SECTION
**++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
--
PROCEDURE ADDRESS_CAN_BR_SP (
/*******************************************************************************
	 ADDRESS_CAN_BR_SP

	This procedure is intended enforce the Business Rules for verifying the
	columns on the ADDRESS_CAN Table
	TRD  Section: 3.3.26 

created : TAL 8/7/2012
*******************************************************************************/	

  inaddress_can_rowtype            IN  ADDRESS_CAN%ROWTYPE
  ,inCOST_CENTER_ROWTYPE           IN  COST_CENTER%ROWTYPE);

PROCEDURE ADDRESS_MEX_BR_SP (
/*******************************************************************************
	 ADDRESS_MEX_BR_SP

	This procedure is intended enforce the Business Rules for verifying the
	columns on the ADDRESS_MEX Table
	TRD  Section: 3.3.27 

created : TAL 8/7/2012
*******************************************************************************/	

  inaddress_mex_rowtype            IN  ADDRESS_MEX%ROWTYPE
  ,inCOST_CENTER_ROWTYPE           IN  COST_CENTER%ROWTYPE);

PROCEDURE ADDRESS_OTH_BR_SP (
/*******************************************************************************
	 ADDRESS_OTHER_BR_SP

	This procedure is intended enforce the Business Rules for verifying the
	columns on the ADDRESS_OTHER Table
	TRD  Section: 3.3.28 

created : TAL 8/7/2012
*******************************************************************************/	

  inaddress_oth_rowtype             IN  ADDRESS_OTHER%ROWTYPE
  ,inCOST_CENTER_ROWTYPE           IN  COST_CENTER%ROWTYPE);

PROCEDURE ADDRESS_USA_BR_SP (
/*******************************************************************************
	 ADDRESS_USA_BR_SP

	This procedure is intended enforce the Business Rules for verifying the
	columns on the ADDRESS_USA Table
	TRD  Section: 3.3.29 

created : TAL 8/7/2012
*******************************************************************************/	

  inaddress_usa_rowtype            IN  ADDRESS_USA%ROWTYPE
  ,inCOST_CENTER_ROWTYPE           IN  COST_CENTER%ROWTYPE);

PROCEDURE ADMINISTRATION_BR_SP (
/*******************************************************************************
	 ADMINISTRATION_BR_SP

	This procedure is intended enforce the Business Rules
	for verifying the CATEGORY on the ADMINISTRATION Table
	TRD  Section: 3.3.20 

created : BLR 8/3/2012
*******************************************************************************/	

  inAdmin_rowtype                  IN  ADMINISTRATION%ROWTYPE
 ,inCostctr_rowtype                IN  COST_CENTER%ROWTYPE);

PROCEDURE LAD_CUSTOMER_BR_SP (
/*******************************************************************************
	 LAD_CUSTOMER_BR_SP

	This procedure is intended enforce the Business Rules
	for verifying the CATEGORY on the LAD_CUSTOMER Table
	TRD  Section: 3.3.20 

created : 03/08/2018 mxv711 CCN Project Team..
          asp400:asp-763 changes to handle LAD_CUSTOMER in CCN
*******************************************************************************/	

  inLad_customer_rowtype           IN  LAD_CUSTOMER%ROWTYPE
 ,inCostctr_rowtype                IN  COST_CENTER%ROWTYPE);

PROCEDURE BANK_CARD_BR_SP (
/******************************************************************************
	 BANK_CARD_BR_SP

	This procedure is intended enforce the Business Rules
	for verifying the BANK_CARD_BR on the BANK_CARD table
	TRD  Section: 3.3.11 

created : BLR 7/26//2012
changed : 01/09/2017 bxa919 added code to fetch the country code ,cost center code from
          cost center table.And removed cost center call from input parameter list
          as we will never get cost center data in the XML.
*******************************************************************************/	
    inbankcard_rowtype          IN Bank_card%ROWTYPE
   --,inCostctr_rowtype           IN COST_CENTER%ROWTYPE
   ,inPolling_rowtype           IN POLLING%ROWTYPE
 );


PROCEDURE COST_CENTER_BR_SP (
/*******************************************************************************
	 COST_CENTER_BR_SP

	This procedure is intended enforce the Business Rules for verifying the
	columns associated with the COST_CENTER Table
	TRD  Section: 3.3.17 

created : BLR 8/3/2012
*******************************************************************************/	
   inCost_Center_rowtype            IN  COST_CENTER%ROWTYPE
  ,inaddress_can_rowtype            IN  address_can%ROWTYPE
  ,inaddress_mex_rowtype            IN  address_mex%ROWTYPE
  ,inaddress_oth_rowtype            IN  address_other%ROWTYPE
  ,inaddress_usa_rowtype            IN  address_usa%ROWTYPE
  ,inaddress_brb_rowtype            IN  address_brb%ROWTYPE);

/*******************************************************************************
--PROCEDURE MARKETING_BR_SP (
	 MARKETING_BR_SP

	There were no Business Rules necessary for the MARKETING Table other than
  Effective and Expiration Dates. 
	TRD  Section: 3.3.30 

created : MDH 9/24/2012
*******************************************************************************/	

PROCEDURE OTHER_BR_SP (
/*******************************************************************************
	 OTHER_BR_SP

	This procedure is intended enforce the Business Rules for verifying the
	CATEGORY on the OTHER Table
	TRD  Section: 3.3.20 

created : BLR 8/3/2012
*******************************************************************************/	
  inCostctr_rowtype                IN  COST_CENTER%ROWTYPE
 ,inOther_rowtype                  IN  OTHER%ROWTYPE );

PROCEDURE PHONE_BR_SP (
/*******************************************************************************
	 PHONE_BR_SP

	This procedure is intended enforce the Business Rules for verifying the
	specific columns on the PHONE Table
	TRD  Section: 3.3.14 

created : TAL 7/31/2012
*******************************************************************************/	
    in_phone_rowtype             PHONE%ROWTYPE
   ,incost_center_rowtype      COST_CENTER%ROWTYPE
   );


PROCEDURE REAL_ESTATE_BR_SP (
/*******************************************************************************
	 REAL_ESTATE_BR_SP

	This procedure is intended enforce the Business Rules
	for verifying the CATEGORY on the REAL_ESTATE_ Table
	TRD  Section: 3.3.20 

created : BLR 8/3/2012
******************************************************************************/	
  inCostctr_rowtype       IN  COST_CENTER%ROWTYPE
 ,inReal_estate_rowtype   IN  REAL_ESTATE%ROWTYPE );

/*******************************************************************************
--PROCEDURE POLLING_BR_SP (
	 POLLING_BR_SP

	There were no Business Rules necessary for the POLLING Table other than
  Effective and Expiration Dates. 
	TRD  Section: 3.3.12 

created : TAL 9/25/2012
*******************************************************************************/	

PROCEDURE SALES_REP_BR_SP ( 
/*****************************************************************************
	SALES_REP_BR_SP

	This procedure is intended enforce the Business Rules
	for SALES_REP Validation editas and verifying all fields (columns) 
  associated to this table.

created : MDH 08/01/2012
******************************************************************************/	
  inSALES_REP_ROWTYPE      IN   SALES_REP%ROWTYPE )
;

/*******************************************************************************
--PROCEDURE STATUS_BR_SP (
	 STATUS_BR_SP

	There were no Business Rules necessary for the STATUS Table other than
  Effective and Expiration Dates. 
	TRD  Section: 3.3.15 

created : MDH 9/24/2012
*******************************************************************************/	

PROCEDURE STORE_BR_SP (
/******************************************************************************
	 STORE_BR_SP

	This procedure is intended enforce the Business Rules
	for verifying specific columns on the STORE Table
	TRD  Section: 3.3.19 

created : BLR 7/26/2012
*******************************************************************************/	

  inStore_rowtype                  IN  STORE%ROWTYPE
 ,inCC_rowtype                     IN  COST_CENTER%ROWTYPE);

PROCEDURE DISPATCH_TERMINAL_BR_SP(
/******************************************************************************
    DISPATCH_TERMINAL_BR_SP
    This procedure is intended to enforce the Business Rules
    for verifying specific columns on the DISPATCH_TERMINAL Table
    created : rxa457 04/17/17 asp:400-asp-763
*******************************************************************************/
    inDispatch_Terminal_rowtype IN DISPATCH_TERMINAL%ROWTYPE,
    inCC_rowtype                IN COST_CENTER%ROWTYPE,
    inSTATUS_ROWTYPE            IN STATUS%ROWTYPE);

PROCEDURE TERMINAL_BR_SP (
/*******************************************************************************
	 TERMINAL_BR_SP

	This procedure is intended enforce the Business Rules for verifying the
	specific columns on the TERMINAL Table
	TRD  Section: 3.3.13 

created : TAL 7/27/2012
*******************************************************************************/	

   IN_TERMINAL_ROWTYPE            IN   TERMINAL%ROWTYPE,
   in_polling_rowtype     IN   polling%ROWTYPE);


PROCEDURE TERRITORY_BR_SP ( 
/*****************************************************************************
	TERRITORY_BR_SP

	This procedure is intended enforce the Business Rules
	for Territory validation editas and verifying all fields (columns) 
  associated to this table.

created : MDH 07/31/2012
******************************************************************************/	
    inCOST_CENTER_ROWTYPE      IN   COST_CENTER%ROWTYPE
  , inTERRITORY_ROWTYPE        IN   TERRITORY%ROWTYPE )
;

PROCEDURE COMPARE_ZIPCODE_SP(
/*******************************************************************************
    COMPARE_ZIPCODE_SP

    This procedure is to compare the Taxware Zip code with Address Zip code.
     1.If there is no record in taxware for given cost center then do nothing.   
     2.If taxware zip code does not match with address zip code then send an email.
     3.If zip code in taxware with value as null and not matching with address 
       zip code then send an email.	   
     4.If zip code in taxware with value as NOT null and not matching with 
       address zip code then send an email. 
     5.If zip code in both tables as null then send an email.

created : 04/22/2015 SXT410 CCN Project...
revised :  
*******************************************************************************/
    IN_COST_CENTER COST_CENTER.COST_CENTER_CODE%TYPE
);

--PROCEDURE ADDRESS_ARG_BR_SP ( 
/*****************************************************************************


	This procedure is intended to enforce the Business Rules
	for ADDRESS_ARG_BR_SP validation edits and verifying the following rules: 

  1.	Cost_Center_Code (6-BR):     
      a. This field (column) cannot be spaces and must be numeric
          as it is the primary key to the ADDRESS_ARG table.
      b. This field (column) is also verified against the COST_CENTER Table.
      c. Also, this must be a Argentenia Cost Center.                               

  3.	Effective_Date (VR/BR): 
      a. This field (column) is changed automatically any time an address field (column) is changed!
          The current System Date is used, but this field (column) can be changed.

  4.	Expiration_Date (VR/BR): 
      a. The Expiration_Date will become the Effective_Date
          of the new ADDRESS_ARG Row minus 1 day. (COMMON_PKG).

  5.	Postal_Code (5-VR/BR): 
      a. This field (column) is mandatory and cannot be spaces. 
      b. This field (column) will be validated against some Argentenia Postal_Code list
          yet to be determined (Keith?).

  6.	Status_Code Change Based on change of Address_Line_1,2,3:  (MDH 01/15/2013)
      For "Stores" Cost Centers with Address_Type "M" 
        if the ADDRESS_LINE_1, ADDRESS_LINE_2, or ADDRESS_LINE_3 is updated then  
             raise warning message exception (- Warning - Address_Line changed please check Status_Code)
             The Status_Code must be changed to "3" (Relocation). All Updates/Inserts will continue.

 created : 08/11/2016 MXK766 CCN Project Team....
           Added business rule to enforce Rules for ADDRESS_ARG 
******************************************************************************/ 
--   inaddress_arg_rowtype           IN  ADDRESS_ARG%ROWTYPE
--  ,incost_center_rowtype           IN  COST_CENTER%ROWTYPE);

--PROCEDURE ADDRESS_BRA_BR_SP ( 
/*****************************************************************************


	This procedure is intended to enforce the Business Rules
	for ADDRESS_BRA_BR_SP validation edits and verifying the following rules: 

  1.	Cost_Center_Code (6-BR):     
      a. This field (column) cannot be spaces and must be numeric
          as it is the primary key to the ADDRESS_BRA table.
      b. This field (column) is also verified against the COST_CENTER Table.
      c. Also, this must be a Brazil Cost Center.                               

  3.	Effective_Date (VR/BR): 
      a. This field (column) is changed automatically any time an address field (column) is changed!
          The current System Date is used, but this field (column) can be changed.

  4.	Expiration_Date (VR/BR): 
      a. The Expiration_Date will become the Effective_Date
          of the new ADDRESS_BRA Row minus 1 day. (COMMON_PKG).

  5.	Postal_Code (5-VR/BR): 
      a. This field (column) is mandatory and cannot be spaces. 
      b. This field (column) will be validated against some Brazil Postal_Code list
          yet to be determined (Keith?).

  6.	Status_Code Change Based on change of Address_Line_1,2,3:  (MDH 01/15/2013)
      For "Stores" Cost Centers with Address_Type "M" 
        if the ADDRESS_LINE_1, ADDRESS_LINE_2, or ADDRESS_LINE_3 is updated then  
             raise warning message exception (- Warning - Address_Line changed please check Status_Code)
             The Status_Code must be changed to "3" (Relocation). All Updates/Inserts will continue.

 created : 08/11/2016 MXK766 CCN Project Team....
           Added business rule to enforce RULES FOR BRAZIL.
******************************************************************************/ 
--   inaddress_bra_rowtype           IN  ADDRESS_BRA%ROWTYPE
--  ,incost_center_rowtype           IN  COST_CENTER%ROWTYPE);

--PROCEDURE ADDRESS_CHL_BR_SP ( 
/*****************************************************************************


	This procedure is intended to enforce the Business Rules
	for ADDRESS_CHL_BR_SP validation edits and verifying the following rules: 

  1.	Cost_Center_Code (6-BR):     
      a. This field (column) cannot be spaces and must be numeric
          as it is the primary key to the ADDRESS_CHL table.
      b. This field (column) is also verified against the COST_CENTER Table.
      c. Also, this must be a CHILE Cost Center.                               

  3.	Effective_Date (VR/BR): 
      a. This field (column) is changed automatically any time an address field (column) is changed!
          The current System Date is used, but this field (column) can be changed.

  4.	Expiration_Date (VR/BR): 
      a. The Expiration_Date will become the Effective_Date
          of the new ADDRESS_CHL Row minus 1 day. (COMMON_PKG).

  5.	Postal_Code (5-VR/BR): 
      a. This field (column) is mandatory and cannot be spaces. 
      b. This field (column) will be validated against some CHILE Postal_Code list
          yet to be determined (Keith?).

  6.	Status_Code Change Based on change of Address_Line_1,2,3:  (MDH 01/15/2013)
      For "Stores" Cost Centers with Address_Type "M" 
        if the ADDRESS_LINE_1, ADDRESS_LINE_2, or ADDRESS_LINE_3 is updated then  
             raise warning message exception (- Warning - Address_Line changed please check Status_Code)
             The Status_Code must be changed to "3" (Relocation). All Updates/Inserts will continue.

 created : 08/11/2016 MXK766 CCN Project Team....
           Added business rule to enforce RULES FOR CHILE.
******************************************************************************/ 
--   inaddress_chl_rowtype           IN  ADDRESS_CHL%ROWTYPE
--  ,incost_center_rowtype           IN  COST_CENTER%ROWTYPE);

--PROCEDURE ADDRESS_COL_BR_SP ( 
/*****************************************************************************


	This procedure is intended to enforce the Business Rules
	for ADDRESS_COL_BR_SP validation edits and verifying the following rules: 

  1.	Cost_Center_Code (6-BR):     
      a. This field (column) cannot be spaces and must be numeric
          as it is the primary key to the ADDRESS_COL table.
      b. This field (column) is also verified against the COST_CENTER Table.
      c. Also, this must be a columbia Cost Center.                               

  3.	Effective_Date (VR/BR): 
      a. This field (column) is changed automatically any time an address field (column) is changed!
          The current System Date is used, but this field (column) can be changed.

  4.	Expiration_Date (VR/BR):  
      a. The Expiration_Date will become the Effective_Date
          of the new ADDRESS_COL Row minus 1 day. (COMMON_PKG).

  5.	Postal_Code (5-VR/BR): 
      a. This field (column) is mandatory and cannot be spaces. 
      b. This field (column) will be validated against some columbia Postal_Code list
          yet to be determined (Keith?).

  6.	Status_Code Change Based on change of Address_Line_1,2,3:  (MDH 01/15/2013)
      For "Stores" Cost Centers with Address_Type "M" 
        if the ADDRESS_LINE_1, ADDRESS_LINE_2, or ADDRESS_LINE_3 is updated then  
             raise warning message exception (- Warning - Address_Line changed please check Status_Code)
             The Status_Code must be changed to "3" (Relocation). All Updates/Inserts will continue.

 created : 08/11/2016 MXK766 CCN Project Team....
           Added business rule to enforce RULES FOR columbia.
******************************************************************************/ 
--   inaddress_col_rowtype           IN  ADDRESS_COL%ROWTYPE
--  ,incost_center_rowtype           IN  COST_CENTER%ROWTYPE);

--PROCEDURE ADDRESS_ECU_BR_SP (
/*****************************************************************************


	This procedure is intended to enforce the Business Rules
	for ADDRESS_ECU_BR_SP validation edits and verifying the following rules: 

  1.	Cost_Center_Code (6-BR):     
      a. This field (column) cannot be spaces and must be numeric
          as it is the primary key to the ADDRESS_ECU table.
      b. This field (column) is also verified against the COST_CENTER Table.
      c. Also, this must be a ecuador Cost Center.                               

  3.	Effective_Date (VR/BR): 
      a. This field (column) is changed automatically any time an address field (column) is changed!
          The current System Date is used, but this field (column) can be changed.

  4.	Expiration_Date (VR/BR): 
      a. The Expiration_Date will become the Effective_Date
          of the new ADDRESS_ECU Row minus 1 day. (COMMON_PKG).

  5.	Postal_Code (5-VR/BR): 
      a. This field (column) is mandatory and cannot be spaces. 
      b. This field (column) will be validated against some ECUADOR Postal_Code list
          yet to be determined (Keith?).

  6.	Status_Code Change Based on change of Address_Line_1,2,3:  (MDH 01/15/2013)
      For "Stores" Cost Centers with Address_Type "M" 
        if the ADDRESS_LINE_1, ADDRESS_LINE_2, or ADDRESS_LINE_3 is updated then  
             raise warning message exception (- Warning - Address_Line changed please check Status_Code)
             The Status_Code must be changed to "3" (Relocation). All Updates/Inserts will continue.

 created : 08/11/2016 MXK766 CCN Project Team....
           Added business rule to enforce RULES FOR ECUADOR.
******************************************************************************/ 
--   inaddress_ecu_rowtype           IN  ADDRESS_ECU%ROWTYPE
--  ,incost_center_rowtype           IN  COST_CENTER%ROWTYPE);

--PROCEDURE ADDRESS_PER_BR_SP ( 
/*****************************************************************************


	This procedure is intended to enforce the Business Rules
	for ADDRESS_PER_BR_SP validation edits and verifying the following rules: 

  1.	Cost_Center_Code (6-BR):     
      a. This field (column) cannot be spaces and must be numeric
          as it is the primary key to the ADDRESS_PER table.
      b. This field (column) is also verified against the COST_CENTER Table.
      c. Also, this must be a PERU Cost Center.                               

  3.	Effective_Date (VR/BR): 
      a. This field (column) is changed automatically any time an address field (column) is changed!
          The current System Date is used, but this field (column) can be changed.

  4.	Expiration_Date (VR/BR): 
      a. The Expiration_Date will become the Effective_Date
          of the new ADDRESS_PER Row minus 1 day. (COMMON_PKG).

  5.	Postal_Code (5-VR/BR): 
      a. This field (column) is mandatory and cannot be spaces. 
      b. This field (column) will be validated against some PERU Postal_Code list
          yet to be determined (Keith?).

  6.	Status_Code Change Based on change of Address_Line_1,2,3:  (MDH 01/15/2013)
      For "Stores" Cost Centers with Address_Type "M" 
        if the ADDRESS_LINE_1, ADDRESS_LINE_2, or ADDRESS_LINE_3 is updated then  
             raise warning message exception (- Warning - Address_Line changed please check Status_Code)
             The Status_Code must be changed to "3" (Relocation). All Updates/Inserts will continue.

 created : 08/11/2016 MXK766 CCN Project Team....
           Added business rule to enforce RULES FOR peru.
******************************************************************************/ 
--   inaddress_per_rowtype           IN  ADDRESS_PER%ROWTYPE
--  ,incost_center_rowtype           IN  COST_CENTER%ROWTYPE);

--PROCEDURE ADDRESS_URU_BR_SP ( 
/*****************************************************************************


	This procedure is intended to enforce the Business Rules
	for ADDRESS_URU_BR_SP validation edits and verifying the following rules: 

  1.	Cost_Center_Code (6-BR):     
      a. This field (column) cannot be spaces and must be numeric
          as it is the primary key to the ADDRESS_URU table.
      b. This field (column) is also verified against the COST_CENTER Table.
      c. Also, this must be a URUGUAY Cost Center.                               

  3.	Effective_Date (VR/BR): 
      a. This field (column) is changed automatically any time an address field (column) is changed!
          The current System Date is used, but this field (column) can be changed.

  4.	Expiration_Date (VR/BR): 
      a. The Expiration_Date will become the Effective_Date
          of the new ADDRESS_URU Row minus 1 day. (COMMON_PKG).

  5.	Postal_Code (5-VR/BR): 
      a. This field (column) is mandatory and cannot be spaces. 
      b. This field (column) will be validated against some URUGUAY Postal_Code list
          yet to be determined (Keith?).

  6.	Status_Code Change Based on change of Address_Line_1,2,3:  (MDH 01/15/2013)
      For "Stores" Cost Centers with Address_Type "M" 
        if the ADDRESS_LINE_1, ADDRESS_LINE_2, or ADDRESS_LINE_3 is updated then  
             raise warning message exception (- Warning - Address_Line changed please check Status_Code)
             The Status_Code must be changed to "3" (Relocation). All Updates/Inserts will continue.

 created : 08/11/2016 MXK766 CCN Project Team....
           Added business rule to enforce RULES FOR URUGUAY.
******************************************************************************/ 
--   inaddress_uru_rowtype           IN  ADDRESS_URU%ROWTYPE
--  ,incost_center_rowtype           IN  COST_CENTER%ROWTYPE);

PROCEDURE TERMINAL_COUNT_BR_SP(
/*****************************************************************************
TERMINAL_COUNT_BR_SP

This procedure is intended to check for the number of Terminal
XML Fragmentns in a given xpath
created : 01/27/2017 mxk766 CN Project....
Modified:
******************************************************************************/
   IN_ROW_DATA        IN XMLTYPE
);
FUNCTION ADMIN_COST_CNTR_BR_SP(
/*****************************************************************************
This procedure takes the cost center code as input and checks if admin_cost_cntr_type
is '01', IF so returns 'Y' That indicates to enable ALLOCATION_CC and DIVISION_OFFSET
Fields if not '01' the returns 'N', that indicates above fields are not shown on UI. 

Created : 01/05/2018 axt754 CN Project....
Modified:
******************************************************************************/
IN_COST_CENTER_CODE IN VARCHAR2) RETURN VARCHAR2;

PROCEDURE ALLOCATION_DIV_OFFSET_BR_SP (
/*******************************************************************************
	 ALLOCATION_DIV_OFFSET_BR_SP

Created : axt754 01/19/2018 CCN Project Team....
          If cost center category is 'A' and Type_code is '41', and the allocation_cc 
          , division_offset are NULL, then raise the warning that these fields are
          mandatory category "A" and type_code '41'
REVISED :
*******************************************************************************/	

  inAdmin_rowtype                  IN  ADMINISTRATION%ROWTYPE
 ,inCostctr_rowtype                IN  COST_CENTER%ROWTYPE
 ,intype_rowtype                   IN  TYPE%ROWTYPE);

PROCEDURE POLLING_QUALITY_STATUS_CHKS_SP (
/*******************************************************************************
This procedure is intended to enforce the Business Rules	When a cost center is changed to "Q".

created : 11/28/2017 sxg151 CCN Team.... ASP-911
changed : 
*******************************************************************************/	
  INPOLLING_ROWTYPE        IN POLLING%ROWTYPE
); 
PROCEDURE MERCHANT_ID_SP_CAN_MC (
/******************************************************************************
	MERCHANT_ID_SP_CAN_MC

	This procedure is intended to enforce the Business Rules
	for verifying the in_MERCH_ID_CAN_MC on the BANK_CARD Table

created  : 01/16/2018 BXA919 
Modified : 09/04/2019 axm868 CCN Project Team....CCNCC-175
           Removed in_MERCH_ID_CAN_MC input so as to remove
           all the rules around MERCH_ID_CAN_MC column
*******************************************************************************/	
 in_PCI_MERCH_ID_CAN_MC IN BANK_CARD.MERCH_ID_CAN_MC%TYPE
 ,inCOST_CENTER_CODE IN COST_CENTER.COST_CENTER_CODE%TYPE
 ,inPOLLING_STATUS_CODE IN POLLING.POLLING_STATUS_CODE%TYPE);

 PROCEDURE VALIDATE_CATEGORY(
/*******************************************************************************
  This Procedure is designed to Validate Category of cost center

  Created: 03/02/2018 mxv711 ASP-824:bulk upload changes

*******************************************************************************/
    IN_CATEGORY         IN   VARCHAR2
);

--PROCEDURE VALIDATE_DVRSIFIED_ADDR_ALLWED(
/*******************************************************************************
This Procedure is designed to Validate if  DVRSIFIED ADDRESS IS  ALLOWED for the cost center
passed

Created: 03/21/2018 nxk927 CCN Project....
*******************************************************************************/
--    IN_COST_CENTER_CODE         IN   VARCHAR2,
--    IN_ROW_DATA                 IN   VARCHAR2
--);

--PROCEDURE VIRTUAL_BR_SP (
/*******************************************************************************
	 VIRTUAL_BR_SP

	This procedure is intended enforce the Business Rules for verifying the
	CATEGORY on the Virtual Table
	TRD  Section: 3.3.20 

created : BLR 8/7/2018
*******************************************************************************/	
--  inCostctr_rowtype                IN  COST_CENTER%ROWTYPE
-- ,inOther_rowtype                  IN  OTHER%ROWTYPE 
-- );


 PROCEDURE CHECK_ARCHIVED_COST_CENTER ( 
/*****************************************************************************
	CHECK_ARCHIVED_COST_CENTER

	This procedure is intended to enforce the Business Rules
	to stop users from updating **L* archived cost centers:

  1.)  Check if cost center is archived, if Yes through error.

created : mxs216 on 11/14/2018, ASP-1158

******************************************************************************/	
  IN_COST_CENTER IN COST_CENTER.COST_CENTER_CODE%TYPE);

--PROCEDURE CHECK_TERRITORY_CC_OPEN_DT ( 
--/*****************************************************************************
--    This function is intended to enforce the business rule in CCN 
--    for territory category cost centers to always have open_date populated.
--
--    1.)  Check if cost center Category = 'T' and OPEN_DATE is null, if Yes through error.
--
-- created : mxs216 on 01/16/2019, ASP-1198 CCN Project Team....
--Modified :
--******************************************************************************/	
--    IN_COST_CENTER_ROWTYPE       COST_CENTER%ROWTYPE);

 PROCEDURE VALIDATE_STORE_DESCARTES_DISPATCH_SRVCS_CD ( 
/*****************************************************************************
	VALIDATE_STORE_DESCARTES_DISPATCH_SRVCS_CD

	This procedure is intended to validate the descartes delivery code and 
    dispatch services type code associated with Store from Code Detail

  1.)  Check if values is not present in Code detail then throw error.

  Created : 10/07/2019 akj899 CCNA2-55 CCN Project..

******************************************************************************/	
  IN_ROW IN TEMP_STR_DISPATCH_SERVICES_UPD%ROWTYPE);

 PROCEDURE VALIDATE_CC_CATEGORY(
/*******************************************************************************
  This Procedure is designed to Validate Cost Center against a particular Category 

  Created : 10/08/2019 akj899 CCNA2-55 CCN Project..

*******************************************************************************/
    IN_COST_CENTER_CODE         IN   COST_CENTER.COST_CENTER_CODE%TYPE,
    IN_CATEGORY                 IN   COST_CENTER.CATEGORY%TYPE
);

END CCN_BUSINESS_RULES_PKG;