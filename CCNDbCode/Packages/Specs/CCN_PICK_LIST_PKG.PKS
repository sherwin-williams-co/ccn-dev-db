create or replace PACKAGE CCN_PICK_LIST_PKG
/**********************************************************
	CCN_PICK_LIST_PKG

	This Package is intended to return values for picklists and 
	picklist screen

created : 
**********************************************************/
    AS
	
	 	TYPE REF_CUR_CODE IS REF CURSOR;

--
--
FUNCTION GET_USER_ROLES_DESC(
/**********************************************************
	CODE_TABLE_H_SP

	This procedure is intended to return the Roles and their Description 
	for the user ID passed

created : 
changed : 03/02/2016 sxh487 Added IN_USER_ID for Credit Hierarchy
**********************************************************/	
  IN_USER_ID  IN VARCHAR2
 ) RETURN VARCHAR2;
 
		PROCEDURE CODE_TABLE_H_SP (
/**********************************************************
	CODE_TABLE_H_SP

	This procedure is intended to return a ref cursor with data from 
	from the CODE_HEADER.  

created : 
changed : 03/02/2016 sxh487 Added IN_USER_ID for Credit Hierarchy
        : Added logic to check if the user has special roles
**********************************************************/	
      IN_USER_ID     IN     VARCHAR2
			,in_HEADER_NAME IN CODE_HEADER.CODE_HEADER_NAME%TYPE
			,in_HEADER_TYPE IN CODE_HEADER.CODE_HEADER_TYPE%TYPE
			, out_CODE_HEADER_CUR OUT REF_CUR_CODE)
;

TYPE REF_CURSOR IS REF CURSOR;

		PROCEDURE CODE_TABLE_D_SP (
/**********************************************************
	CODE_TABLE_D_SP

	This procedure is intended to return a ref cursor with data from 
	from the CODE_DETAIL table.  

created : 
**********************************************************/		
		in_HEADER_NAME IN CODE_DETAIL.CODE_HEADER_NAME%TYPE
		,in_HEADER_TYPE IN CODE_DETAIL.CODE_HEADER_TYPE%TYPE
		--,in_DETAIL_VALUE IN CODE_DETAIL.CODE_DETAIL_VALUE%TYPE
    	, out_CODE_DETAIL_CUR OUT REF_CUR_CODE)
;

FUNCTION GET_CODE_DETAIL_VALUE_DSCRPTN (
/**********************************************************
	GET_CODE_DETAIL_VALUE_DSCRPTN

	This procedure is intended to return the description for the code detail value
  from CODE_DETAIL table based on the passed parameters.  

created : 
**********************************************************/
	in_HEADER_NAME  IN CODE_DETAIL.CODE_HEADER_NAME%TYPE,
	in_HEADER_TYPE  IN CODE_DETAIL.CODE_HEADER_TYPE%TYPE,
	in_DETAIL_VALUE IN CODE_DETAIL.CODE_DETAIL_VALUE%TYPE)
RETURN VARCHAR2;

	PROCEDURE CODE_TABLE_D_DESC_SP (
/**********************************************************
	CODE_TABLE_D_DESC_SP

	This procedure is intended to return a ref cursor with data from 
	from the CODE_DETAIL table.  

created : 
**********************************************************/
	in_HEADER_NAME IN CODE_DETAIL.CODE_HEADER_NAME%TYPE
	,in_HEADER_TYPE IN CODE_DETAIL.CODE_HEADER_TYPE%TYPE
	,in_DETAIL_VALUE IN CODE_DETAIL.CODE_DETAIL_VALUE%TYPE
	, out_CODE_DETAIL_CUR OUT REF_CUR_CODE);

--**********************************************************

PROCEDURE CODE_DETAIL_INSERT(
/**********************************************************
CODE_DETAIL_INSERT

	This procedure will insert into the CODE_DETAIL table 

<CODE_DETAIL>
  <row_data>
      <CODE_HEADER_NAME>MKT_BRAND</CODE_HEADER_NAME> 
      <CODE_HEADER_TYPE>COD</CODE_HEADER_TYPE> 
      <CODE_DETAIL_VALUE>C</CODE_DETAIL_VALUE> 
      <CODE_DETAIL_DESCRIPTION>COLUMBIA</CODE_DETAIL_DESCRIPTION>
      <CODE_DETAIL_EXPIRE_FLAG>NULL</CODE_DETAIL_EXPIRE_FLAG>
      <CODE_DETAIL_EXPIRE_USER>NULL</CODE_DETAIL_EXPIRE_USER>
	    <CODE_DETAIL_EXPIRE_EFF_DATE>NULL</CODE_DETAIL_EXPIRE_EFF_DATE>
      <CODE_DETAIL_ID>1</CODE_DETAIL_ID>	   
      <CODE_DETAIL_CREATE_USER>USER</CODE_DETAIL_CREATE_USER>
	    <CODE_DETAIL_EFF_DATE>DATE</CODE_DETAIL_EFF_DATE>
  </row_data>
  <row_data>
      <CODE_HEADER_NAME>MKT_BRAND</CODE_HEADER_NAME> 
      <CODE_HEADER_TYPE>COD</CODE_HEADER_TYPE> 
      <CODE_DETAIL_VALUE>C</CODE_DETAIL_VALUE> 
      <CODE_DETAIL_DESCRIPTION>COLUMBIA</CODE_DETAIL_DESCRIPTION>
      <CODE_DETAIL_EXPIRE_FLAG>NULL</CODE_DETAIL_EXPIRE_FLAG>
      <CODE_DETAIL_EXPIRE_USER>NULL</CODE_DETAIL_EXPIRE_USER>
	    <CODE_DETAIL_EXPIRE_EFF_DATE>NULL</CODE_DETAIL_EXPIRE_EFF_DATE>
	    <CODE_DETAIL_ID>1</CODE_DETAIL_ID>	
      <CODE_DETAIL_CREATE_USER>USER</CODE_DETAIL_CREATE_USER>
	    <CODE_DETAIL_EFF_DATE>DATE</CODE_DETAIL_EFF_DATE>
  </row_data>
  <row_data>
      <CODE_HEADER_NAME>MKT_BRAND</CODE_HEADER_NAME> 
      <CODE_HEADER_TYPE>COD</CODE_HEADER_TYPE> 
      <CODE_DETAIL_VALUE>C</CODE_DETAIL_VALUE> 
      <CODE_DETAIL_DESCRIPTION>COLUMBIA</CODE_DETAIL_DESCRIPTION>
      <CODE_DETAIL_EXPIRE_FLAG>NULL</CODE_DETAIL_EXPIRE_FLAG>
      <CODE_DETAIL_EXPIRE_USER>NULL</CODE_DETAIL_EXPIRE_USER>
	    <CODE_DETAIL_EXPIRE_EFF_DATE>NULL</CODE_DETAIL_EXPIRE_EFF_DATE>
	    <CODE_DETAIL_ID>1</CODE_DETAIL_ID>	
      <CODE_DETAIL_CREATE_USER>USER</CODE_DETAIL_CREATE_USER>
	    <CODE_DETAIL_EFF_DATE>DATE</CODE_DETAIL_EFF_DATE>
  </row_data>
</CODE_DETAIL>
**********************************************************/
    in_XML                VARCHAR2);

	PROCEDURE CODE_DETAIL_UPDATE(
/**********************************************************
		CODE_DETAIL_UPDATE

	This procedure will UPDATE into the table CODE_DETAIL

<CODE_DETAIL>
  <row_data>
      <CODE_HEADER_NAME>MKT_BRAND</CODE_HEADER_NAME> 
      <CODE_HEADER_TYPE>COD</CODE_HEADER_TYPE> 
      <CODE_DETAIL_VALUE>C</CODE_DETAIL_VALUE> 
      <CODE_DETAIL_DESCRIPTION>COLUMBIA</CODE_DETAIL_DESCRIPTION>
      <CODE_DETAIL_EXPIRE_FLAG>NULL</CODE_DETAIL_EXPIRE_FLAG>
      <CODE_DETAIL_EXPIRE_USER>NULL</CODE_DETAIL_EXPIRE_USER>
	    <CODE_DETAIL_EXPIRE_EFF_DATE>NULL</CODE_DETAIL_EXPIRE_EFF_DATE>
	    <CODE_DETAIL_ID>1</CODE_DETAIL_ID>	
      <CODE_DETAIL_CREATE_USER>USER</CODE_DETAIL_CREATE_USER>
	    <CODE_DETAIL_EFF_DATE>DATE</CODE_DETAIL_EFF_DATE>
  </row_data>
</CODE_DETAIL>

created : 
Revised : 08/27/2015 AXK326 CCN Project Team....
          Updated the parameter from XML to CLOB type
**********************************************************/
    in_XML                CLOB);
	
PROCEDURE CODE_DETAIL_DELETE(
/**********************************************************
CODE_DETAIL_DELETE

	This procedure will UPDATE THE EXISTING CODES FROM the table CODE_DETAIL

<CODE_DETAIL>
  <row_data>
      <CODE_HEADER_NAME>MKT_BRAND</CODE_HEADER_NAME> 
      <CODE_HEADER_TYPE>COD</CODE_HEADER_TYPE> 
      <CODE_DETAIL_VALUE>C</CODE_DETAIL_VALUE> 
      <CODE_DETAIL_DESCRIPTION>COLUMBIA</CODE_DETAIL_DESCRIPTION>
      <CODE_DETAIL_EXPIRE_FLAG>NULL</CODE_DETAIL_EXPIRE_FLAG>
      <CODE_DETAIL_EXPIRE_USER>NULL</CODE_DETAIL_EXPIRE_USER>
	    <CODE_DETAIL_EXPIRE_EFF_DATE>NULL</CODE_DETAIL_EXPIRE_EFF_DATE>
	    <CODE_DETAIL_ID>1</CODE_DETAIL_ID>	 
      <CODE_DETAIL_CREATE_USER>USER</CODE_DETAIL_CREATE_USER>
	    <CODE_DETAIL_EFF_DATE>DATE</CODE_DETAIL_EFF_DATE>
  </row_data>
</CODE_DETAIL>

created : 
Revised : 08/27/2015 AXK326 CCN Project Team....
          Updated the parameter from XML to CLOB type
**********************************************************/
    IN_XML                CLOB);
  
PROCEDURE CODE_HEADER_INSERT(
/**********************************************************
	CODE_HEADER_INSERT

	This procedure will insert into the table CODE_HEADER

<CODE_HEADER>
  <row_data>
      <CODE_HEADER_NAME>RPS_ZONE_CODE</CODE_HEADER_NAME> 
      <CODE_HEADER_TYPE>COD</CODE_HEADER_TYPE> 
      <CODE_HEADER_DESCRIPTION>RPS SHIPPING ZONE CODES</CODE_HEADER_DESCRIPTION>
      <CODE_HEADER_EXPIRE_FLAG>NULL</CODE_HEADER_EXPIRE_FLAG>
      <CODE_HEADER_EXPIRE_USER>NULL</CODE_HEADER_EXPIRE_USER>
	    <CODE_HEADER_EXPIRE_EFF_DATE>NULL</CODE_HEADER_EXPIRE_EFF_DATE>
	    <CODE_HEADER_DTL_VAL_SIZE>1</CODE_HEADER_DTL_VAL_SIZE>
      <CODE_HEADER_DTL_VAL_DEFAULT>NULL</CODE_HEADER_DTL_VAL_DEFAULT>	
      <CODE_HEADER_CREATE_USER>USER</CODE_HEADER_CREATE_USER>
	    <CODE_HEADER_EFF_DATE>DATE</CODE_HEADER_EFF_DATE>
  </row_data>
</CODE_HEADER>
**********************************************************/
    IN_XML                VARCHAR2);
    
PROCEDURE CODE_HEADER_UPDATE(
/**********************************************************
CODE_HEADER_UPDATE
	
	This procedure will UPDATE into the table CODE_HEADER

<CODE_HEADER>
  <row_data>
     <CODE_HEADER_NAME>RPS_ZONE_CODE</CODE_HEADER_NAME> 
      <CODE_HEADER_TYPE>COD</CODE_HEADER_TYPE> 
      <CODE_HEADER_DESCRIPTION>RPS SHIPPING ZONE CODES</CODE_HEADER_DESCRIPTION>
      <CODE_HEADER_EXPIRE_FLAG>NULL</CODE_HEADER_EXPIRE_FLAG>
      <CODE_HEADER_EXPIRE_USER>NULL</CODE_HEADER_EXPIRE_USER>
	    <CODE_HEADER_EXPIRE_EFF_DATE>NULL</CODE_HEADER_EXPIRE_EFF_DATE>
	    <CODE_HEADER_DTL_VAL_SIZE>1</CODE_HEADER_DTL_VAL_SIZE>
      <CODE_HEADER_DTL_VAL_DEFAULT>NULL</CODE_HEADER_DTL_VAL_DEFAULT>	 
      <CODE_HEADER_CREATE_USER>USER</CODE_HEADER_CREATE_USER>
	    <CODE_HEADER_EFF_DATE>DATE</CODE_HEADER_EFF_DATE>
  </row_data>
</CODE_HEADER>
**********************************************************/
    in_XML                VARCHAR2);
    
PROCEDURE CODE_HEADER_DELETE(
/**********************************************************
		CODE_HEADER_DELETE

	This procedure will update existing code header FROM the table CODE_HEADER

<CODE_HEADER>
  <row_data>
      <CODE_HEADER_NAME>RPS_ZONE_CODE</CODE_HEADER_NAME> 
      <CODE_HEADER_TYPE>COD</CODE_HEADER_TYPE> 
      <CODE_HEADER_DESCRIPTION>RPS SHIPPING ZONE CODES</CODE_HEADER_DESCRIPTION>
      <CODE_HEADER_EXPIRE_FLAG>NULL</CODE_HEADER_EXPIRE_FLAG>
      <CODE_HEADER_EXPIRE_USER>NULL</CODE_HEADER_EXPIRE_USER>
	    <CODE_HEADER_EXPIRE_EFF_DATE>NULL</CODE_HEADER_EXPIRE_EFF_DATE>
	    <CODE_HEADER_DTL_VAL_SIZE>1</CODE_HEADER_DTL_VAL_SIZE>
      <CODE_HEADER_DTL_VAL_DEFAULT>NULL</CODE_HEADER_DTL_VAL_DEFAULT>	
      <CODE_HEADER_CREATE_USER>USER</CODE_HEADER_CREATE_USER>
	    <CODE_HEADER_EFF_DATE>DATE</CODE_HEADER_EFF_DATE>
  </row_data>
</CODE_HEADER>
**********************************************************/
    in_XML                VARCHAR2);

PROCEDURE CODE_HEADER_ROWTYPE_SP (
/*******************************************************************************
	CODE_HEADER_ROWTYPE_SP

	This procedure is intended to insert new CODE_HEADER records

created : 11/27/2013 jxc517 CCN Project....
changed : 
*******************************************************************************/

in_TABLE_NAME           IN      VARCHAR2 
,in_Row_data             IN      varchar2--sys.xmltype
,out_CODE_HEADER_type        out CODE_HEADER%rowtype);

PROCEDURE CODE_DETAIL_ROWTYPE_SP (
/*******************************************************************************
	CODE_DETAIL_ROWTYPE_SP

	This procedure is intended to insert new CODE_DETAIL records

created : 11/27/2013 jxc517 CCN Project....
changed : 
*******************************************************************************/

in_TABLE_NAME           IN      VARCHAR2 
,in_Row_data             IN      varchar2--sys.xmltype
,out_CODE_DETAIL_type        out CODE_DETAIL%rowtype);

END CCN_PICK_LIST_PKG;