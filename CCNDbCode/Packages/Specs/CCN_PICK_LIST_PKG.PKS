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
END CCN_PICK_LIST_PKG;

