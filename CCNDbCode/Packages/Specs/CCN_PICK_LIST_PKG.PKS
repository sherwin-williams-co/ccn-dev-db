PACKAGE CCN_PICK_LIST_PKG
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
		PROCEDURE CODE_TABLE_H_SP (
/**********************************************************
	CODE_TABLE_H_SP

	This procedure is intended to return a ref cursor with data from 
	from the CODE_HEADER.  

created : 
**********************************************************/	
			in_HEADER_NAME IN CODE_HEADER.CODE_HEADER_NAME%TYPE
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

	This procedure will insert into the table CODE_DETAIL

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
  </row_data>
</CODE_DETAIL>
**********************************************************/
    in_XML                VARCHAR2);

	PROCEDURE CODE_DETAIL_UPDATE(
/**********************************************************
	CODE_DETAIL_UPDATE

	This procedure will insert into the table CODE_DETAIL

<CODE_DETAIL>
  <row_data>
      <CODE_HEADER_NAME>NAME</CODE_HEADER_NAME> 
      <CODE_HEADER_TYPE>TYPE</CODE_HEADER_TYPE> 
      <CODE_DETAIL_VALUE>VALUE</CODE_DETAIL_VALUE> 
      <CODE_DETAIL_DESCRIPTION>DESCRIPTION</CODE_DETAIL_DESCRIPTION>
      <CODE_DETAIL_EXPIRE_FLAG>FLAG</CODE_DETAIL_EXPIRE_FLAG>
      <CODE_DETAIL_EXPIRE_USER>EXPIRE_USER</CODE_DETAIL_EXPIRE_USER>
	    <CODE_DETAIL_EXPIRE_EFF_DATE>EXPIRE EFF_DATE</CODE_DETAIL_EXPIRE_EFF_DATE>
	    <CODE_DETAIL_ID>DETAIL ID</CODE_DETAIL_ID>	   
  </row_data>
</CODE_DETAIL>
**********************************************************/
    in_XML                VARCHAR2);
	
PROCEDURE CODE_DETAIL_DELETE(
/**********************************************************
	CODE_DETAIL_DELETE

	This procedure will delete from the table CODE_DETAIL

<CODE_DETAIL>
  <row_data>
      <CODE_HEADER_NAME>NAME</CODE_HEADER_NAME> 
      <CODE_HEADER_TYPE>TYPE</CODE_HEADER_TYPE> 
      <CODE_DETAIL_VALUE>VALUE</CODE_DETAIL_VALUE> 
      <CODE_DETAIL_DESCRIPTION>DESCRIPTION</CODE_DETAIL_DESCRIPTION>
      <CODE_DETAIL_EXPIRE_FLAG>FLAG</CODE_DETAIL_EXPIRE_FLAG>
      <CODE_DETAIL_EXPIRE_USER>EXPIRE_USER</CODE_DETAIL_EXPIRE_USER>
	  <CODE_DETAIL_EXPIRE_EFF_DATE>EXPIRE EFF_DATE</CODE_DETAIL_EXPIRE_EFF_DATE>
	  <CODE_DETAIL_ID>DETAIL ID</CODE_DETAIL_ID>	   
  </row_data>
</CODE_DETAIL>
**********************************************************/
    IN_XML                VARCHAR2);
  
PROCEDURE CODE_HEADER_INSERT(
/**********************************************************
	CODE_HEADER_INSERT

	This procedure will insert into the table CODE_HEADER

<CODE_HEADER>
  <row_data>
      <CODE_HEADER_NAME>NAME</CODE_HEADER_NAME> 
      <CODE_HEADER_TYPE>TYPE</CODE_HEADER_TYPE> 
      <CODE_HEADER_DESCRIPTION>DESCRIPTION</CODE_HEADER_DESCRIPTION>
      <CODE_HEADER_EXPIRE_FLAG>FLAG</CODE_HEADER_EXPIRE_FLAG>
      <CODE_HEADER_EXPIRE_USER>EXPIRE_USER</CODE_HEADER_EXPIRE_USER>
	    <CODE_HEADER_EXPIRE_EFF_DATE>EXPIRE EFF_DATE</CODE_HEADER_EXPIRE_EFF_DATE>
	    <CODE_HEADER_DTL_VAL_SIZE>DETAIL VALUE_SIZE</CODE_HEADER_DTL_VAL_SIZE>
      <CODE_HEADER_DTL_VAL_DEFAULT>DETAIL VAL_DEFAULT</CODE_HEADER_DTL_VAL_DEFAULT>		  
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
      <CODE_HEADER_NAME>NAME</CODE_HEADER_NAME> 
      <CODE_HEADER_TYPE>TYPE</CODE_HEADER_TYPE> 
      <CODE_HEADER_DESCRIPTION>DESCRIPTION</CODE_HEADER_DESCRIPTION>
      <CODE_HEADER_EXPIRE_FLAG>FLAG</CODE_HEADER_EXPIRE_FLAG>
      <CODE_HEADER_EXPIRE_USER>EXPIRE_USER</CODE_HEADER_EXPIRE_USER>
	    <CODE_HEADER_EXPIRE_EFF_DATE>EXPIRE EFF_DATE</CODE_HEADER_EXPIRE_EFF_DATE>
	    <CODE_HEADER_DTL_VAL_SIZE>HEADER VALUE_SIZE</CODE_HEADER_DTL_VAL_SIZE>
      <CODE_HEADER_DTL_VAL_DEFAULT>HEADER VAL_DEFAULT</CODE_HEADER_DTL_VAL_DEFAULT>		  
  </row_data>
</CODE_HEADER>
**********************************************************/
    in_XML                VARCHAR2);
    
PROCEDURE CODE_HEADER_DELETE(
/**********************************************************
	CODE_HEADER_DELETE

	This procedure will DELETE FROM the table CODE_HEADER

<CODE_HEADER>
  <row_data>
      <CODE_HEADER_NAME>NAME</CODE_HEADER_NAME> 
      <CODE_HEADER_TYPE>TYPE</CODE_HEADER_TYPE> 
      <CODE_HEADER_DESCRIPTION>DESCRIPTION</CODE_HEADER_DESCRIPTION>
      <CODE_HEADER_EXPIRE_FLAG>FLAG</CODE_HEADER_EXPIRE_FLAG>
      <CODE_HEADER_EXPIRE_USER>EXPIRE_USER</CODE_HEADER_EXPIRE_USER>
	    <CODE_HEADER_EXPIRE_EFF_DATE>EXPIRE EFF_DATE</CODE_HEADER_EXPIRE_EFF_DATE>
	    <CODE_HEADER_DTL_VAL_SIZE>HEADER VALUE_SIZE</CODE_HEADER_DTL_VAL_SIZE>
      <CODE_HEADER_DTL_VAL_DEFAULT>HEADER VAL_DEFAULT</CODE_HEADER_DTL_VAL_DEFAULT>		  
  </row_data>
</CODE_HEADER>
**********************************************************/
    in_XML                VARCHAR2);
END CCN_PICK_LIST_PKG;
/

