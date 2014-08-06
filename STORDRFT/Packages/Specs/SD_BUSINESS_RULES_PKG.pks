create or replace PACKAGE SD_BUSINESS_RULES_PKG
/****************************************************************************** 
This package BODY will do the business rules validations:
  
created : 06/30/2014 
changed :
******************************************************************************/
AS

G_HISTORY_MONTHS     NUMBER := 18;

PROCEDURE SET_STORE_DRAFT_FLAGS(
/*****************************************************************************
	SET_STORE_DRAFT_FLAGS

	This function will get set the flag values for store drafts table

created : 07/10/2014 
changed :
*****************************************************************************/
    IN_ROW_TYPE     IN OUT    STORE_DRAFTS%ROWTYPE);

FUNCTION GET_OPEN_FLAG(
/*****************************************************************************
	GET_OPEN_FLAG

	This function will get the flag value for open store drafts  

created : 06/30/2014 
changed :
*****************************************************************************/
    IN_ROW_TYPE     IN    STORE_DRAFTS%ROWTYPE) RETURN VARCHAR2;

FUNCTION GET_STOP_FLAG(
/*****************************************************************************
	GET_STOP_FLAG

	This function will get the flag value for stop store drafts  

created : 06/30/2014 
changed :
*****************************************************************************/
    IN_ROW_TYPE     IN    STORE_DRAFTS%ROWTYPE) RETURN VARCHAR2;

FUNCTION GET_VOID_FLAG(
/*****************************************************************************
	GET_VOID_FLAG

	This function will get the flag value for void store drafts  

created : 06/30/2014 
changed :
*****************************************************************************/
    IN_ROW_TYPE     IN    STORE_DRAFTS%ROWTYPE) RETURN VARCHAR2;

FUNCTION GET_PAY_FLAG(
/*****************************************************************************
	GET_PAY_FLAG

	This function will get the flag value for pay store drafts  

created : 06/30/2014 
changed :
*****************************************************************************/
    IN_ROW_TYPE     IN    STORE_DRAFTS%ROWTYPE) RETURN VARCHAR2;
    

FUNCTION IS_UNATTACHED_STORE_DRAFT(
/*****************************************************************************
	IS_UNATTACHED_STORE_DRAFT

	This function will return if the passed record is unattached or not based on some ruels.  

created : 07/01/2014
changed :
*****************************************************************************/
    IN_STORE_DRAFTS_RECORD     IN    STORE_DRAFTS%ROWTYPE) RETURN BOOLEAN;

END SD_BUSINESS_RULES_PKG;