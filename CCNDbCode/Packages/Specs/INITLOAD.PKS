create or replace PACKAGE initLoad
/**************************************************************** 
This package will load the new CCN Oracle Database
created : 11/21/2011 mdh CCN coding projecet
Revised : 12/16/2014 AXK326 CCN Project Team....
          Code changes made after deleting the sales manager link from the Territory Table
*****************************************************************/
IS


PROCEDURE DELETE_CCN_TABLES;
/***************************************************************
	DELETE_CCN_TABLES

	This function will delete all data loaded to the new CCN   
	Oracle Database before reloading data from files created off
  of the legacy idms database.  

created : 11/23/2011 mdh CCN Project....
***************************************************************/
	--return REF_CURSOR;


PROCEDURE LOAD_COST_CENTER_TABLE;
/***************************************************************
	LOAD_COST_CENTER_TABLE

	This function will load the COST_CENTER table from data  
	file from legacy idms database.  

created : 09/29/2011 mdh CCN Project....
***************************************************************/
	

PROCEDURE LOAD_STORE_TABLE;
/***************************************************************
	LOAD_STORE_TABLE

	This function will load the STORE table from data  
	file from legacy idms database.  

created : 09/29/2011 mdh CCN Project....
***************************************************************/


PROCEDURE LOAD_ADMINISTRATION_TABLE;
/***************************************************************
	LOAD_ADMINISTRATION_TABLE

	This function will load the ADMINISTRATION table from data  
	file from legacy idms database.  

created : 10/25/2011 mdh CCN Project....
***************************************************************/


PROCEDURE LOAD_REAL_ESTATE_TABLE;
/***************************************************************
	LOAD_REAL_ESTATE_TABLE

	This function will load the REAL_ESTATE table from data  
	file from legacy idms database.  

created : 10/25/2011 mdh CCN Project....
***************************************************************/


PROCEDURE LOAD_OTHER_TABLE;
/***************************************************************
	LOAD_OTHER_TABLE

	This function will load the OTHER table from data  
	file from legacy idms database.  

created : 10/25/2011 mdh CCN Project....
***************************************************************/


PROCEDURE LOAD_PHONE_TABLE;
/***************************************************************
	LOAD_PHONE_TABLE

	This function will load the PHONE table from data  
	file from legacy idms database.  

created : 09/19/2011 mdh CCN Project....
***************************************************************/


PROCEDURE LOAD_STATUS_TABLE;
/***************************************************************
	LOAD_STATUS_TABLE

	This function will load the STATUS table from data  
	file from legacy idms database.  

created : 09/19/2011 mdh CCN Project....
***************************************************************/


PROCEDURE LOAD_TYPE_TABLE;
/***************************************************************
	LOAD_TYPE_TABLE

	This function will load the TYPE table from data  
	file from legacy idms database.  

created : 09/19/2011 mdh CCN Project....
***************************************************************/


PROCEDURE LOAD_ADDRESS_USA_TABLE;
/***************************************************************
	LOAD_ADDRESS_USA_TABLE

	This function will load the ADDRESS_USA table from data  
	file from legacy idms database.  

created : 10/05/2011 mdh CCN Project....
***************************************************************/


PROCEDURE LOAD_ADDRESS_CAN_TABLE;
/***************************************************************
	LOAD_ADDRESS_CAN_TABLE

	This function will load the ADDRESS_CAN table from data  
	file from legacy idms database.  

created : 10/05/2011 mdh CCN Project....
***************************************************************/


PROCEDURE LOAD_ADDRESS_MEX_TABLE;
/***************************************************************
	LOAD_ADDRESS_MEX_TABLE

	This function will load the ADDRESS_MEX table from data  
	file from legacy idms database.  

created : 10/05/2011 mdh CCN Project....
***************************************************************/


PROCEDURE LOAD_ADDRESS_OTH_TABLE;
/***************************************************************
	LOAD_ADDRESS_OTH_TABLE

	This function will load the ADDRESS_OTH table from data  
	file from legacy idms database.  

created : 10/05/2011 mdh CCN Project....
***************************************************************/


PROCEDURE LOAD_MARKETING_TABLE;
/***************************************************************
	LOAD_MARKETING_TABLE

	This function will load the MARKETING table from data  
	file from legacy idms database.  

created : 10/21/2011 mdh CCN Project....
***************************************************************/

PROCEDURE LOAD_TERRITORY_TABLE;
/***************************************************************
	LOAD_TERRITORY_TABLE

	This function will load the TERRITORY table from data  
	file from legacy idms database.  

created : 11/21/2011 blr CCN Project....
***************************************************************/


PROCEDURE LOAD_SALES_REP_TABLE;
/***************************************************************
	LOAD_SALES_REP_TABLE

	This function will load the SALES_REP table from data  
	file from legacy idms database.  

created : 11/21/2011 blr CCN Project....
***************************************************************/


PROCEDURE UPDT_TERRITORY_TABLE;
/***************************************************************
	UPDT_TERRITORY_TABLE

	This function will update the TERRITORY table from a data  
	file from legacy idms database.  This procedure will update
  all territories added by Benita in Territory to make sure they
  align to the CCN Database.

created : 10/25/2011 mdh CCN Project....
***************************************************************/


PROCEDURE LOAD_POLLING_TABLE;
/***************************************************************
	LOAD_POLLING_TABLE

	This function will update the POLLING table from a data  
	file from legacy idms database.  

created : 06/15/2012 tal CCN Project....
***************************************************************/


PROCEDURE LOAD_BANK_CARD_TABLE;
/***************************************************************
	LOAD_BANK_CARD_TABLE

	This function will update the BANK_CARD table from a data  
	file from legacy idms database.  

created : 06/15/2012 tal CCN Project....
***************************************************************/


PROCEDURE LOAD_TERMINAL_TABLE;
/***************************************************************
	LOAD_TERMINAL_TABLE

	This function will update the TERMINAL table from a data  
	file from legacy idms database.  

created : 06/15/2012 tal CCN Project....
***************************************************************/


PROCEDURE LOAD_POLLING_DWLD_RSN_TABLE;
/***************************************************************
	LOAD_POLLING_DWLD_RSN_TABLE

	This function will update the POLLING_DWLD_RSN_HIST table from a data  
	file from legacy idms database.  

created : 08/23/2012 tal CCN Project....
***************************************************************/


PROCEDURE LOAD_TAXWARE_TABLE;
/***************************************************************
	LOAD_TAXWARE_TABLE

	This function will update the TAXWARE table from a data  
	file from legacy idms database.  

created : 08/23/2012 tal CCN Project....
***************************************************************/


PROCEDURE ADDRESS_CAN_INITLOAD_SP (
/*******************************************************************************
	ADDRESS_CAN_INITLOAD_SP

	This procedure is intended to build an AUDIT_LOG entry for ADDRESS_CAN Records

created : 04/18/2012 TAL CCN Project....
*******************************************************************************/
    inADDRESS_CAN_rowtype  IN  ADDRESS_CAN%ROWTYPE );


PROCEDURE ADDRESS_MEX_INITLOAD_SP (
/*******************************************************************************
	ADDRESS_MEX_INITLOAD_SP

	This procedure is intended to build an AUDIT_LOG entry for ADDRESS_MEX Records

created : 04/18/2012 TAL CCN Project....
*******************************************************************************/
    inADDRESS_MEX_rowtype  IN  ADDRESS_MEX%ROWTYPE );


PROCEDURE ADDRESS_OTHER_INITLOAD_SP (
/*******************************************************************************
	ADDRESS_OTHER_INITLOAD_SP

	This procedure is intended to build an AUDIT_LOG entry for ADDRESS_OTHER Records

created : 04/18/2012 TAL CCN Project....
*******************************************************************************/
    inADDRESS_OTHER_rowtype  IN  ADDRESS_OTHER%ROWTYPE );


PROCEDURE ADDRESS_USA_INITLOAD_SP (
/*******************************************************************************
	ADDRESS_USA_INITLOAD_SP

	This procedure is intended to build an AUDIT_LOG entry for ADDRESS_USA Records

created : 04/18/2012 TAL CCN Project....
*******************************************************************************/
    inADDRESS_USA_rowtype  IN  ADDRESS_USA%ROWTYPE );


PROCEDURE ADMINISTRATION_INITLOAD_SP (
/*******************************************************************************
	ADMINISTRATION_INITLOAD_SP

	This procedure is intended to build an AUDIT_LOG entry for ADministration Records

created : 04/18/2012 TAL CCN Project....
*******************************************************************************/
    inADMINISTRATION_rowtype  IN  ADMINISTRATION%ROWTYPE );


PROCEDURE BANK_CARD_INITLOAD_SP (
/*******************************************************************************
	BANK_CARD_INITLOAD_SP

	This procedure is intended to build an AUDIT_LOG entry for BANK_CARD Records

created : 04/18/2012 TAL CCN Project....
*******************************************************************************/
    inBANK_CARD_rowtype  IN  BANK_CARD%ROWTYPE );


PROCEDURE COST_CENTER_INITLOAD_SP (
/*******************************************************************************
	COST_CENTER_INITLOAD_SP

	This procedure is intended to build an AUDIT_LOG entry for COST_CENTER Records

created : 04/18/2012 TAL CCN Project....
*******************************************************************************/
    inCOST_CENTER_rowtype  IN  COST_CENTER%ROWTYPE );


PROCEDURE EMP_DATA_INITLOAD_SP (
/*******************************************************************************
	EMP_DATA_INITLOAD_SP

	This procedure is intended to build an AUDIT_LOG entry for EMP_DATA Records

created : 04/18/2012 TAL CCN Project....
*******************************************************************************/
    inEMP_DATA_rowtype  IN  EMP_DATA%ROWTYPE );


PROCEDURE HIER_DESC_INITLOAD_SP (
/*******************************************************************************
	HIER_DESC_INITLOAD_SP

	This procedure is intended to build an AUDIT_LOG entry for HIER_DESC Records

created : 04/18/2012 TAL CCN Project....
*******************************************************************************/
    inHIER_DESC_rowtype  IN  HIERARCHY_DESCRIPTION%ROWTYPE );


PROCEDURE HIER_DETAIL_INITLOAD_SP (
/*******************************************************************************
	HIER_DETAIL_INITLOAD_SP

	This procedure is intended to build an AUDIT_LOG entry for HIER_DETAIL Records

created : 04/18/2012 TAL CCN Project....
*******************************************************************************/
    inHIER_DETAIL_rowtype  IN  HIERARCHY_DETAIL%ROWTYPE );


PROCEDURE HIER_HEADER_INITLOAD_SP (
/*******************************************************************************
	HIER_HEADER_INITLOAD_SP

	This procedure is intended to build an AUDIT_LOG entry for HIER_HEADER Records

created : 04/18/2012 TAL CCN Project....
*******************************************************************************/
    inHIER_HEADER_rowtype  IN  HIERARCHY_HEADER%ROWTYPE );


PROCEDURE MARKETING_INITLOAD_SP (
/*******************************************************************************
	MARKETING_INITLOAD_SP

	This procedure is intended to build an AUDIT_LOG entry for MARKETING Records

created : 04/18/2012 TAL CCN Project....
*******************************************************************************/
    inMARKETING_rowtype  IN  MARKETING%ROWTYPE );


PROCEDURE OTHER_INITLOAD_SP (
/*******************************************************************************
	OTHER_INITLOAD_SP

	This procedure is intended to build an AUDIT_LOG entry for OTHER Records

created : 04/18/2012 TAL CCN Project....
*******************************************************************************/
    inOTHER_rowtype  IN  OTHER%ROWTYPE );

procedure PHONE_INITLOAD_SP(
/*******************************************************************************
	PHONE_INITLOAD_SP 

	CCNA-356 - This procedure is intended to build an AUDIT_LOG entry for 
  PHONE Records

created : 04/23/2013 BLR CCN Project....
*******************************************************************************/
inPhone_rowtype IN PHONE%ROWTYPE
);

PROCEDURE POLL_DWLD_RSN_HIST_INITLOAD_SP (
/*******************************************************************************
	POLL_DWLD_RSN_HIST_INITLOAD_SP

	CCNA-356 - This procedure is intended to build an AUDIT_LOG entry for 
  POLLING_DWLD_RSN_HIST Records

created : 04/23/2013 BLR CCN Project....
*******************************************************************************/
  inPOLLING_DWLD_RSN_HIST_row POLLING_DWLD_RSN_HIST%rowtype
  ); 
  
PROCEDURE POLLING_INITLOAD_SP (
/*******************************************************************************
	POLLING_INITLOAD_SP

	CCNA-356 - This procedure is intended to build an AUDIT_LOG entry for 
  POLLING Records

created : 04/23/2013 BLR CCN Project....
*******************************************************************************/
  inPOLLING_row IN POLLING%rowtype
  ); 
  
PROCEDURE REAL_ESTATE_INITLOAD_SP (
/*******************************************************************************
	REAL_ESTATE_INITLOAD_SP

	CCNA-356 - This procedure is intended to build an AUDIT_LOG entry for
  REAL_ESTATE Records

created : 04/23/2013 BLR CCN Project....
*******************************************************************************/
  inREAL_ESTATE_rowtype IN REAL_ESTATE%rowtype
  ); 
  
PROCEDURE SALES_REP_INITLOAD_SP (
/*******************************************************************************
	SALES_REP_INITLOAD_SP

	CCNA-356 - This procedure is intended to build an AUDIT_LOG entry for
  SALES_REP Records

created : 04/23/2013 BLR CCN Project....
*******************************************************************************/
  inSALES_REP_rowtype IN SALES_REP%rowtype
  ); 
  
PROCEDURE STATUS_INITLOAD_SP (
/*******************************************************************************
	STATUS_INITLOAD_SP

	CCNA-356 - This procedure is intended to build an AUDIT_LOG entry for 
  STATUS Records

created : 04/23/2013 BLR CCN Project....
*******************************************************************************/
  inSTATUS_rowtype IN STATUS%rowtype
  ); 
  
PROCEDURE STORE_INITLOAD_SP (
/*******************************************************************************
	STORE_INITLOAD_SP

	CCNA-356 - This procedure is intended to build an AUDIT_LOG entry for 
  STORE Records

created : 04/23/2013 BLR CCN Project....
*******************************************************************************/
  inSTORE_rowtype IN STORE%rowtype
  ); 
  
PROCEDURE TAXWARE_INITLOAD_SP (
/*******************************************************************************
	TAXWARE_INITLOAD_SP 

	CCNA-356 - This procedure is intended to build an AUDIT_LOG entry for
  TAXWARE Records

created : 04/23/2013 BLR CCN Project....
*******************************************************************************/
  inTAXWARE_rowtype IN TAXWARE%rowtype
  ); 
  
PROCEDURE TERMINAL_INITLOAD_SP (
/*******************************************************************************
	TERMINAL_INITLOAD_SP

	CCNA-356 - This procedure is intended to build an AUDIT_LOG entry for 
  TERMINAL Records

created : 04/23/2013 BLR CCN Project....
*******************************************************************************/
  inTERMINAL_rowtype IN TERMINAL%rowtype
  ); 
  
PROCEDURE TERRITORY_INITLOAD_SP (
/*******************************************************************************
	TERRITORY_INITLOAD_SP

	CCNA-356 - This procedure is intended to build an AUDIT_LOG entry for
  TERRITORY Records

created : 04/23/2013 BLR CCN Project....
*******************************************************************************/
    interritory_rowtype IN TERRITORY%rowtype
    );
  
PROCEDURE TYPE_INITLOAD_SP (
/*******************************************************************************
	TYPE_INITLOAD_SP

	CCNA-356 - This procedure is intended to build an AUDIT_LOG entry for TYPE Records

created : 04/23/2013 BLR CCN Project....
*******************************************************************************/
  intype_rowtype IN TYPE%rowtype
  ); 

Procedure COST_CENTER_AUDIT_INITLOAD_SP
/******************************************************************	
This Procedure is a wrapper for the COST_CENTER_INITLOAD_SP 
Audit Load of the CCN tables 	
    * Loads the COST_CENTER Audit table				
									
Created: SH 05/06/2013						
******************************************************************/	
;
Procedure ADDRESS_CAN_AUDIT_INITLOAD_SP
/******************************************************************	
This Procedure is a wrapper for the ADDRESS_CAN_INITLOAD_SP 
Audit Load of the CCN tables 	
    * Loads the ADDRESS_CAN Audit table				
									
Created: SH 05/06/2013						
******************************************************************/
;
Procedure ADDRESS_MEX_AUDIT_INITLOAD_SP
/******************************************************************	
This Procedure is a wrapper for the ADDRESS_MEX_INITLOAD_SP 
Audit Load of the CCN tables 	
    * Loads the ADDRESS_MEX Audit table				
									
Created: SH 05/06/2013						
******************************************************************/
;
Procedure ADDR_OTHER_AUDIT_INITLOAD_SP
/******************************************************************	
This Procedure is a wrapper for the ADDRESS_OTHER_INITLOAD_SP 
Audit Load of the CCN tables 	
    * Loads the ADDRESS_OTHER Audit table				
									
Created: SH 05/06/2013						
******************************************************************/
;
Procedure ADDR_USA_AUDIT_INITLOAD_SP
/******************************************************************	
This Procedure is a wrapper for the ADDRESS_USA_INITLOAD_SP 
Audit Load of the CCN tables 	
    * Loads the ADDRESS_USA Audit table				
									
Created: SH 05/06/2013						
******************************************************************/
;
Procedure ADMN_AUDIT_INITLOAD_SP
/******************************************************************	
This Procedure is a wrapper for the ADMINISTRATION_INITLOAD_SP 
Audit Load of the CCN tables 	
    * Loads the ADMINISTRATION Audit table				
									
Created: SH 05/06/2013						
******************************************************************/	
;
Procedure OTHER_AUDIT_INITLOAD_SP
/******************************************************************	
This Procedure is a wrapper for the OTHER_INITLOAD_SP 
Audit Load of the CCN tables 	
    * Loads the OTHER Audit table				
									
Created: SH 05/06/2013						
******************************************************************/
;
Procedure PHONE_AUDIT_INITLOAD_SP
/******************************************************************	
This Procedure is a wrapper for the PHONE_INITLOAD_SP 
Audit Load of the CCN tables 	
    * Loads the PHONE Audit table				
									
Created: SH 05/06/2013						
******************************************************************/
;
Procedure REAL_ESTATE_AUDIT_INITLOAD_SP
/******************************************************************	
This Procedure is a wrapper for the REAL_ESTATE_INITLOAD_SP 
Audit Load of the CCN tables 	
    * Loads the REAL_ESTATE Audit table				
									
Created: SH 05/06/2013						
******************************************************************/
;
Procedure STATUS_AUDIT_INITLOAD_SP
/******************************************************************	
This Procedure is a wrapper for the STATUS_INITLOAD_SP 
Audit Load of the CCN tables 	
    * Loads the STATUS Audit table				
									
Created: SH 05/06/2013						
******************************************************************/
;
Procedure STORE_AUDIT_INITLOAD_SP
/******************************************************************	
This Procedure is a wrapper for the STORE_INITLOAD_SP 
Audit Load of the CCN tables 	
    * Loads the STORE Audit table				
									
Created: SH 05/06/2013						
******************************************************************/
;
Procedure POLLING_AUDIT_INITLOAD_SP
/******************************************************************	
This Procedure is a wrapper for the POLLING_INITLOAD_SP 
Audit Load of the CCN tables 	
    * Loads the POLLING Audit table				
									
Created: SH 05/06/2013						
******************************************************************/
;
Procedure TYPE_AUDIT_INITLOAD_SP
/******************************************************************	
This Procedure is a wrapper for the TYPE_INITLOAD_SP 
Audit Load of the CCN tables 	
    * Loads the TYPE Audit table				
									
Created: SH 05/06/2013						
******************************************************************/
;
Procedure BANK_CARD_AUDIT_INITLOAD_SP
/******************************************************************	
This Procedure is a wrapper for the BANK_CARD_INITLOAD_SP 
Audit Load of the CCN tables 	
    * Loads the BANK_CARD Audit table				
									
Created: SH 05/06/2013						
******************************************************************/
;
Procedure POLL_DWLD_AUDIT_INITLOAD_SP
/******************************************************************	
This Procedure is a wrapper for the POLL_DWLD_RSN_HIST_INITLOAD_SP 
Audit Load of the CCN tables 	
    * Loads the POLLING_DWLD_RSN_HIST Audit table				
									
Created: SH 05/06/2013						
******************************************************************/
;
Procedure TERMINAL_AUDIT_INITLOAD_SP
/******************************************************************	
This Procedure is a wrapper for the TERMINAL_INITLOAD_SP 
Audit Load of the CCN tables 	
    * Loads the TERMINAL Audit table				
									
Created: SH 05/06/2013						
******************************************************************/
;
Procedure SALES_REP_AUDIT_INITLOAD_SP
/******************************************************************	
This Procedure is a wrapper for the SALES_REP_INITLOAD_SP 
Audit Load of the CCN tables 	
    * Loads the SALES_REP Audit table				
									
Created: SH 05/06/2013						
******************************************************************/	
;

Procedure TERRITORY_AUDIT_INITLOAD_SP
/******************************************************************	
This Procedure is a wrapper for the TERRITORY_INITLOAD_SP 
Audit Load of the CCN tables 	
    * Loads the TERRITORY Audit table				
									
Created: SH 05/06/2013						
******************************************************************/
;
Procedure MARKETING_AUDIT_INITLOAD_SP
/******************************************************************	
This Procedure is a wrapper for the MARKETING_INITLOAD_SP 
Audit Load of the CCN tables 	
    * Loads the MARKETING Audit table				
									
Created: SH 05/06/2013						
******************************************************************/	
;
Procedure TAXWARE_AUDIT_INITLOAD_SP
/******************************************************************	
This Procedure is a wrapper for the TAXWARE_INITLOAD_SP 
Audit Load of the CCN tables 	
    * Loads the TAXWARE Audit table				
									
Created: SH 05/06/2013						
******************************************************************/
;
Procedure CCN_AUDIT_INITLOAD_SP
/******************************************************************
This Procedure is a wrapper for the Initial Load of the CCN tables
    * Disables all the Triggers 
    * Deletes all the CCN tables
    * Loads all the CCN tables
    * Loads the Audit tables
    * Re-Enables the Triggers

Created: SH 05/06/2013
******************************************************************/
;
END initLoad;

