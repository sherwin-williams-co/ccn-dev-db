package PICK_LIST_RULES 
    AS
/******************************************************************************
	PICK_LIST_RULES_PKG

	This Package is intended to validate business rules for the PICK_LIST
	function;  Namely the CODE_HEADER and CODE_DETAIL tables

created : MDH 8/27/2012 
*******************************************************************************/

PROCEDURE PICK_LIST_RULES_SP (
/******************************************************************************
  PICK_LIST_RULES_SP

	This is the main validation program that will run through all the rules 
	and raise the first violation hit.

created : 8/27/2012
*******************************************************************************/	
	inCODE_HEADER_ROWTYPE  IN  CODE_HEADER%rowtype  ) ;
  
PROCEDURE CODE_HEADER_BR_SP (
/******************************************************************************
  CODE_HEADER_BR_SP

	This procedure is intended to enforce the Business Rules
	for verifying the CODE_HEADER Table fields (columns).

created : 8/03/2012
*******************************************************************************/	
	inCODE_HEADER_ROWTYPE  IN  CODE_HEADER%rowtype  ) ;
  

PROCEDURE CODE_DETAIL_BR_SP (
/******************************************************************************
  CODE_DETAIL_BR_SP

	This procedure is intended to enforce the Business Rules
	for verifying the CODE_DETAIL Table fields (columns).

created : 8/09/2012
*******************************************************************************/	
	inCODE_HEADER_ROWTYPE  IN  CODE_HEADER%rowtype  
 ,inCODE_DETAIL_ROWTYPE  IN  CODE_DETAIL%rowtype  ) ;
  
end pick_list_rules;
/

