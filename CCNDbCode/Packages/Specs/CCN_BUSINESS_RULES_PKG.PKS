PACKAGE CCN_BUSINESS_RULES_PKG
    AS
/******************************************************************************
	CCN_BUSINESS_RULES_PKG  SPEC

	This Package SPEC is intended to validate business rules for
	CCN application

created :kdp 4/26/2012 
revised :mdh 9/24/2012
         mdh 10/16/2012 - added Business_Rules_SP (rowtype & xml) procedures
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
******************************************************************************/	
    inADDRESS_CAN_XMLTYPE    VARCHAR2--sys.xmltype
   ,inADDRESS_MEX_XMLTYPE    VARCHAR2--sys.xmltype
   ,inADDRESS_OTH_XMLTYPE    VARCHAR2--sys.xmltype
   ,inADDRESS_USA_XMLTYPE    VARCHAR2--sys.xmltype   
   ,inADMIN_XMLTYPE          VARCHAR2--sys.xmltype
   ,inBANKCARD_XMLTYPE       VARCHAR2--sys.xmltype
   ,inCOST_CENTER_XMLTYPE    VARCHAR2--sys.xmltype
   ,inMARKETING_XMLTYPE      VARCHAR2--sys.xmltype
   ,inOTHER_XMLTYPE          VARCHAR2--sys.xmltype
   ,inPhone_XMLTYPE          VARCHAR2--sys.xmltype
   ,inPHONE_PRI_XMLTYPE      VARCHAR2--sys.xmltype
   ,inPHONE_SCD_XMLTYPE      VARCHAR2--sys.xmltype
   ,inPOLLING_XMLTYPE        VARCHAR2--sys.xmltype
   ,inREAL_ESTATE_XMLTYPE    VARCHAR2--sys.xmltype
   ,inSALES_REP_XMLTYPE      VARCHAR2--sys.xmltype
   ,inSTATUS_XMLTYPE         VARCHAR2--sys.xmltype
   ,inSTORE_XMLTYPE          VARCHAR2--sys.xmltype
   ,inTERMINAL_XMLTYPE       VARCHAR2--sys.xmltype
   ,inTERRITORY_XMLTYPE      VARCHAR2--sys.xmltype 
   ,inTERR_ASGN_XMLTYPE      VARCHAR2--sys.xmltype
   ,inTERR_SLS_MGR_XMLTYPE   VARCHAR2--sys.xmltype
   ,inTYPE_XMLTYPE           VARCHAR2--sys.xmltype
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
******************************************************************************/	
    inADDRESS_CAN_ROWTYPE    in ADDRESS_CAN%rowtype
   ,inADDRESS_MEX_ROWTYPE    in ADDRESS_MEX%rowtype
   ,inADDRESS_OTH_ROWTYPE    in ADDRESS_OTHER%rowtype
   ,inADDRESS_USA_ROWTYPE    in ADDRESS_USA%rowtype   
   ,inADMIN_ROWTYPE          in ADMINISTRATION%rowtype
   ,inBANKCARD_ROWTYPE       in BANK_CARD%rowtype
   ,inCOST_CENTER_ROWTYPE    in COST_CENTER%rowtype
   ,inMARKETING_ROWTYPE      in MARKETING%rowtype
   ,inOTHER_ROWTYPE          in OTHER%rowtype
   ,inPhone_ROWTYPE          in PHONE%rowtype
   ,inPHONE_PRI_ROWTYPE      in PHONE%ROWTYPE
   ,inPHONE_SCD_ROWTYPE      in PHONE%ROWTYPE
   ,inPOLLING_ROWTYPE        in POLLING%rowtype
   ,inREAL_ESTATE_ROWTYPE    in REAL_ESTATE%rowtype
   ,inSALES_REP_ROWTYPE      in SALES_REP%rowtype
   ,inSTATUS_ROWTYPE         in STATUS%rowtype
   ,inSTORE_ROWTYPE          in STORE%rowtype
   ,inTERMINAL_ROWTYPE       in TERMINAL%rowtype
   ,inTERRITORY_ROWTYPE      in TERRITORY%rowtype  
   ,inTERR_ASGN_ROWTYPE      in TERRITORY_ASSIGNMENT%rowtype
   ,inTERR_SLS_MGR_ROWTYPE   in TERRITORY_SALES_MGR%rowtype
   ,inTYPE_ROWTYPE           in TYPE%rowtype
 );
	
/*****************************************************************************/
PROCEDURE MERCHANT_ID_SP (
/******************************************************************************
	MERCHANT_ID_SP

	This procedure is intended to enforce the Business Rules
	for verifying the Merchant_ID on the BANK_CARD Table

created : 4/26/2012
*******************************************************************************/	
	inMERCHANT_ID IN BANK_CARD.MERCHANT_ID%TYPE
 ,inCOST_CENTER_CODE IN COST_CENTER.COST_CENTER_CODE%TYPE
 ,inPOLLING_STATUS_CODE in POLLING.POLLING_STATUS_CODE%TYPE);
  
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
******************************************************************************/	
  inSTATUS_ROWTYPE      IN STATUS%ROWTYPE
 ,inCOST_CENTER_ROWTYPE IN COST_CENTER%ROWTYPE
 ,INTERRITORY_ROWTYPE   IN TERRITORY%ROWTYPE)
;	

PROCEDURE DEST_PT_CHECK_DGT_ID_SP (
/*******************************************************************************
	DEST_PT_CHECK_DGT_ID_SP

	This procedure is intended enforce the Business Rules
	for verifying the the Check_digit on the Address_USA Table
	TRD  Section: 3.3.4 

created : BLR 5/17/2012
*******************************************************************************/	
 inCheck_digit      in ADDRESS_USA.check_digit%TYPE
,inDest_point       in ADDRESS_USA.destination_point%TYPE 
,inAddress_type     in ADDRESS_USA.address_type%TYPE)   
;

PROCEDURE POLLING_STATUS_HIST_SP (
/*******************************************************************************
	POLLING_STATUS_HIST_SP

	This procedure is intended enforce the Business Rules
	for verifying the POLLING_STATUS_Code on the POLLING Table
	TRD  Section: 3.3.6

created : BLR 6/13/2012
*******************************************************************************/	
   inCOST_CENTER_ROWTYPE        in COST_CENTER%ROWTYPE 
  ,inPOLLING_ROWTYPE            in POLLING%ROWTYPE
  ,inSTATUS_ROWTYPE             in STATUS%ROWTYPE
  ,inTYPE_ROWTYPE               in TYPE%ROWTYPE
  ,inTERMINAL_ROWTYPE           in TERMINAL%ROWTYPE
  ,V_TERMINAL_ACTIVE_FLAG       in VARCHAR2
  ,inBANKCARD_ROWTYPE           in BANK_CARD%ROWTYPE
  ,inPHONE_ROWTYPE              in PHONE%ROWTYPE
  ,inPHONE_PRI_ROWTYPE          in PHONE%ROWTYPE
  ,inPHONE_SCD_ROWTYPE          in PHONE%ROWTYPE
  ,inSTORE_ROWTYPE              in STORE%ROWTYPE
  ,inADDRESS_CAN_ROWTYPE        in ADDRESS_CAN%ROWTYPE
  ,inADDRESS_MEX_ROWTYPE        in ADDRESS_MEX%ROWTYPE
  ,inADDRESS_OTH_ROWTYPE        in ADDRESS_OTHER%ROWTYPE
  ,inADDRESS_USA_ROWTYPE        in ADDRESS_USA%ROWTYPE  
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
   inCOST_CENTER_ROWTYPE        in COST_CENTER%ROWTYPE 
  ,inPOLLING_ROWTYPE            in POLLING%ROWTYPE
  ,inSTATUS_ROWTYPE             in STATUS%ROWTYPE
  ,inTYPE_ROWTYPE               in TYPE%ROWTYPE
  ,inTERMINAL_ROWTYPE           in TERMINAL%ROWTYPE
  ,V_TERMINAL_ACTIVE_FLAG       in VARCHAR2
  ,inBANKCARD_ROWTYPE           in BANK_CARD%ROWTYPE
);

PROCEDURE POLLING_CTRL_STATUS_CHKS_SP (
/*******************************************************************************
	 POLLING_CTRL_STATUS_CHKS_SP

	This procedure is intended enforce the Business Rules
	for verifying the POLLING_STATUS_Code on the POLLING Table
	TRD  Section: 3.3.8 

created : BLR 5/21/2012
*******************************************************************************/	
   inCOST_CENTER_ROWTYPE        in COST_CENTER%ROWTYPE 
  ,inPOLLING_ROWTYPE            in POLLING%ROWTYPE
  ,inSTATUS_ROWTYPE             in STATUS%ROWTYPE
  ,inTYPE_ROWTYPE               in TYPE%ROWTYPE
  ,inTERMINAL_ROWTYPE           in TERMINAL%ROWTYPE
  ,V_TERMINAL_ACTIVE_FLAG       in VARCHAR2
  ,inBANKCARD_ROWTYPE           in BANK_CARD%ROWTYPE
  ,inPHONE_ROWTYPE              in PHONE%rowtype
  ,inPHONE_PRI_ROWTYPE          in PHONE%ROWTYPE
  ,inPHONE_SCD_ROWTYPE          in PHONE%ROWTYPE
  ,inSTORE_ROWTYPE              in STORE%ROWTYPE
  ,inADDRESS_CAN_ROWTYPE        in ADDRESS_CAN%ROWTYPE
  ,inADDRESS_MEX_ROWTYPE        in ADDRESS_MEX%ROWTYPE
  ,inADDRESS_OTH_ROWTYPE        in ADDRESS_OTHER%ROWTYPE
  ,inADDRESS_USA_ROWTYPE        in ADDRESS_USA%ROWTYPE  
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
  inCOST_CENTER_ROWTYPE    in   COST_CENTER%rowtype
 ,inTERRITORY_ROWTYPE      in   TERRITORY%rowTYPE )
;	
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
  
  inaddress_can_rowtype            IN  ADDRESS_CAN%rowtype
  ,inCOST_CENTER_ROWTYPE           IN  COST_CENTER%rowtype);

PROCEDURE ADDRESS_MEX_BR_SP (
/*******************************************************************************
	 ADDRESS_MEX_BR_SP

	This procedure is intended enforce the Business Rules for verifying the
	columns on the ADDRESS_MEX Table
	TRD  Section: 3.3.27 

created : TAL 8/7/2012
*******************************************************************************/	
  
  inaddress_mex_rowtype            IN  ADDRESS_MEX%rowtype
  ,inCOST_CENTER_ROWTYPE           IN  COST_CENTER%rowtype);
  
PROCEDURE ADDRESS_OTH_BR_SP (
/*******************************************************************************
	 ADDRESS_OTHER_BR_SP

	This procedure is intended enforce the Business Rules for verifying the
	columns on the ADDRESS_OTHER Table
	TRD  Section: 3.3.28 

created : TAL 8/7/2012
*******************************************************************************/	
  
  inaddress_oth_rowtype             IN  ADDRESS_OTHER%rowtype
  ,inCOST_CENTER_ROWTYPE           IN  COST_CENTER%rowtype);
  
PROCEDURE ADDRESS_USA_BR_SP (
/*******************************************************************************
	 ADDRESS_USA_BR_SP

	This procedure is intended enforce the Business Rules for verifying the
	columns on the ADDRESS_USA Table
	TRD  Section: 3.3.29 

created : TAL 8/7/2012
*******************************************************************************/	
  
  inaddress_usa_rowtype            IN  ADDRESS_USA%rowtype
  ,inCOST_CENTER_ROWTYPE           IN  COST_CENTER%rowtype);

PROCEDURE ADMINISTRATION_BR_SP (
/*******************************************************************************
	 ADMINISTRATION_BR_SP

	This procedure is intended enforce the Business Rules
	for verifying the CATEGORY on the ADMINISTRATION Table
	TRD  Section: 3.3.20 

created : BLR 8/3/2012
*******************************************************************************/	
  
  inAdmin_rowtype                  IN  ADMINISTRATION%rowtype
 ,inCostctr_rowtype                IN  COST_CENTER%rowtype);

PROCEDURE BANK_CARD_BR_SP (
/******************************************************************************
	 BANK_CARD_BR_SP

	This procedure is intended enforce the Business Rules
	for verifying the BANK_CARD_BR on the BANK_CARD table
	TRD  Section: 3.3.11 

created : BLR 7/26//2012
*******************************************************************************/	
    inbankcard_rowtype          in Bank_card%rowtype
   ,inCostctr_rowtype           in COST_CENTER%ROWTYPE
   ,inPolling_rowtype           in POLLING%ROWTYPE
 );


PROCEDURE COST_CENTER_BR_SP (
/*******************************************************************************
	 COST_CENTER_BR_SP

	This procedure is intended enforce the Business Rules for verifying the
	columns associated with the COST_CENTER Table
	TRD  Section: 3.3.17 

created : BLR 8/3/2012
*******************************************************************************/	
   inCost_Center_rowtype            IN  COST_CENTER%rowtype
  ,inaddress_can_rowtype            IN  address_can%rowtype
  ,inaddress_mex_rowtype            IN  address_mex%rowtype
  ,inaddress_oth_rowtype            IN  address_other%rowtype
  ,inaddress_usa_rowtype            IN  address_usa%rowtype  );

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
  inCostctr_rowtype                IN  COST_CENTER%rowtype
 ,inOther_rowtype                  IN  OTHER%rowtype );
 
PROCEDURE PHONE_BR_SP (
/*******************************************************************************
	 PHONE_BR_SP

	This procedure is intended enforce the Business Rules for verifying the
	specific columns on the PHONE Table
	TRD  Section: 3.3.14 

created : TAL 7/31/2012
*******************************************************************************/	
    in_phone_rowtype             PHONE%rowtype
   ,incost_center_rowtype      COST_CENTER%rowtype
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
 ,inReal_estate_rowtype   IN  REAL_ESTATE%rowtype );
 
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
  inSALES_REP_ROWTYPE      in   SALES_REP%rowtype )
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

  inStore_rowtype                  IN  STORE%rowtype
 ,inCC_rowtype                     IN  COST_CENTER%rowtype);
  
PROCEDURE TERMINAL_BR_SP (
/*******************************************************************************
	 TERMINAL_BR_SP

	This procedure is intended enforce the Business Rules for verifying the
	specific columns on the TERMINAL Table
	TRD  Section: 3.3.13 

created : TAL 7/27/2012
*******************************************************************************/	
  
   IN_TERMINAL_ROWTYPE            IN   TERMINAL%ROWTYPE,
   in_polling_rowtype     in   polling%rowtype);


PROCEDURE TERR_ASSIGNMENT_BR_SP (
/*******************************************************************************
	 TERR_ASSIGNMENT_BR_SP

	This procedure is intended enforce the Business Rules
	for verifying the TERR_ASSIGNMENT_BR_SP on the TERRITORY_ASSIGNMENT table
	TRD  Section: 3.3.24

created : BLR 8/7/12
******************************************************************************/	
    inTerr_asgn_rowtype            IN  Territory_assignment%rowtype
     );


PROCEDURE TERRITORY_BR_SP ( 
/*****************************************************************************
	TERRITORY_BR_SP

	This procedure is intended enforce the Business Rules
	for Territory validation editas and verifying all fields (columns) 
  associated to this table.
    
created : MDH 07/31/2012
******************************************************************************/	
    inCOST_CENTER_ROWTYPE      in   COST_CENTER%rowtype
  , inTERRITORY_ROWTYPE        in   TERRITORY%rowtype )
;	
PROCEDURE TERRITORY_SALES_MGR_BR_SP ( 
/*****************************************************************************
	TERRITORY_SALES_MGR_BR_SP

	This procedure is intended enforce the Business Rules
	for Territory Sales Manger validation editas and verifying all fields (columns) 
  associated to this table.
    
created : BLR 09/24/2012
******************************************************************************/	
  inSLSMGR_ROWTYPE      in   TERRITORY_SALES_MGR%rowtype )
;	


/*******************************************************************************
--PROCEDURE TYPE_BR_SP (
	 TYPE_BR_SP

	There were no Business Rules necessary for the TYPE Table other than
  Effective and Expiration Dates. 
	TRD  Section: 3.3.16 

created : MDH 9/24/2012
*******************************************************************************/	
 
END CCN_BUSINESS_RULES_PKG;
/

