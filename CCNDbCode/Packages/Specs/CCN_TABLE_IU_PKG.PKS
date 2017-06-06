create or replace PACKAGE CCN_TABLE_IU_PKG
    AS
-- PACKAGE SPEC
/****************************************************************************** 
This package is intended to control access to the core CCN table.

created : 09/18/2012 TAL -- CCN coding project
changed : 12/16/2014 AXK326 CCN Project Team....
          Code changes made after deleting the sales manager link from the Territory Table
		: 04/13/2017 rxa457 CCN Project team.. 
                     Code changes related to Dispatch Terminal
                     Added Procedures DISPATCH_TERMINAL_S_SP,DISPATCH_TERMINAL_I_SP, DISPATCH_TERMINAL_U_SP, and DISPATCH_TERMINAL_ROWTYPE_SP
******************************************************************************/
	 	TYPE REF_CURSOR IS REF CURSOR;

--MEMORY VARIABLES
--BElow memory variable is used to by-pass trigger code when needed
    TRIGGER_DISABLE_FLAG VARCHAR2(1);

  	PROCEDURE All_TABLE_COL_S_SP (
/*******************************************************************************
	All_TABLE_COL_S_SP
	
	This procedure is intended to return a ref cursor with datPOLLING_S_SPa from 
	from the all_table_col table.  

created : 04/26/2012 kdp CCN Project....
*******************************************************************************/
			in_TABLE_NAME IN ALL_TAB_COLUMNS.TABLE_NAME%TYPE
			,out_all_tab_ref_cur OUT ref_cursor	);    
      

	PROCEDURE ADDRESS_CAN_S_SP  (IN_COST_CENTER   IN ADDRESS_CAN.COST_CENTER_CODE%TYPE
                              ,IN_ADDRESS_TYPE  IN ADDRESS_CAN.ADDRESS_TYPE%TYPE
                              ,OUT_ADDRESS_CAN_REF_CUR OUT REF_CURSOR)
/*******************************************************************************
	ADDRESS_CAN_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the ADDRESS_CAN table.  

created : 11/15/2010 kdp CCN Project....
*******************************************************************************/
;

       
	PROCEDURE ADDRESS_MEX_S_SP  (IN_COST_CENTER   IN ADDRESS_MEX.COST_CENTER_CODE%TYPE
                              ,IN_ADDRESS_TYPE  IN ADDRESS_MEX.ADDRESS_TYPE%TYPE
                              ,OUT_ADDRESS_MEX_REF_CUR OUT REF_CURSOR)
/*******************************************************************************
	ADDRESS_MEX_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the ADDRESS_MEX table.  

created : 03/20/2012 MDH CCN Project....
*******************************************************************************/
;


	PROCEDURE ADDRESS_OTHER_S_SP  (IN_COST_CENTER IN ADDRESS_OTHER.COST_CENTER_CODE%TYPE
                                ,IN_ADDRESS_TYPE IN ADDRESS_OTHER.ADDRESS_TYPE%TYPE
                                ,OUT_ADDRESS_OTHER_REF_CUR OUT REF_CURSOR)
/*******************************************************************************
	ADDRESS_OTHER_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the ADDRESS_OTHER table.  

created : 03/20/2012 MDH CCN Project....
*******************************************************************************/
;


	PROCEDURE ADDRESS_USA_S_SP  (IN_COST_CENTER IN ADDRESS_USA.COST_CENTER_CODE%TYPE
                              ,IN_ADDRESS_TYPE IN ADDRESS_USA.ADDRESS_TYPE%TYPE
                              ,OUT_ADDRESS_USA_REF_CUR OUT REF_CURSOR)
/*******************************************************************************
	ADDRESS_USA_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the ADDRESS_USA  table.  

created : 03/20/2012 MDH CCN Project....
*******************************************************************************/
;


  PROCEDURE ADMINISTRATION_S_SP (in_COST_CENTER IN ADMINISTRATION.COST_CENTER_CODE%TYPE
							, out_ADMINISTRATION_REF_CUR OUT REF_CURSOR)
/*******************************************************************************
	ADMINISTRATION_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the ADMINISTRATION table.  

created : 03/20/2012 mdh CCN Project....
*******************************************************************************/
;


	PROCEDURE BANK_CARD_S_SP  (IN_COST_CENTER           IN BANK_CARD.COST_CENTER_CODE%TYPE
                            ,IN_POLLING_STATUS_CODE   IN BANK_CARD.POLLING_STATUS_CODE%TYPE
                            ,IN_MERCHANT_ID_CODE      IN BANK_CARD.MERCHANT_ID%TYPE
                            ,OUT_BANK_CARD_REF_CUR    OUT REF_CURSOR)
/*******************************************************************************
	BANK_CARD_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the bank_card table.  

created : 03/21/2012 MDH CCN Project....
*******************************************************************************/
;
  
PROCEDURE BATCH_JOB_S_SP (in_batch_job_name     IN  batch_job.batch_job_name%type
                        , in_batch_job_number   IN  batch_job.batch_job_number%type
			, out_BATCH_JOB_REF_CUR OUT REF_CURSOR)
/******************************************************************************
	BATCH_JOB_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the BATCH_JOB table.  

created : 07/18/2012 tal CCN Project....
*******************************************************************************/
;

  PROCEDURE CODE_DETAIL_S_SP ( in_code_header_name      IN code_detail.code_header_name%type
         , in_CODE_HEADER_TYPE      IN CODE_DETAIL.CODE_HEADER_TYPE%TYPE
			   , in_CODE_DETAIL_VALUE     IN CODE_DETAIL.CODE_DETAIL_VALUE%TYPE
			  , out_CODE_DETAIL_REF_CUR  OUT REF_CURSOR )
/*******************************************************************************
	CODE_DETAIL_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the CODE_DETAIL table.  

created : 03/20/2012 tal CCN Project....
*******************************************************************************/
;


  PROCEDURE CODE_HEADER_S_SP ( in_code_header_name      IN code_header.code_header_name%type
			   , in_CODE_HEADER_TYPE      IN CODE_HEADER.CODE_HEADER_TYPE%TYPE
			  , out_CODE_HEADER_REF_CUR  OUT REF_CURSOR )
/*******************************************************************************
	CODE_HEADER_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the CODE_HEADER table.  

created : 03/20/2012 tal CCN Project....
*******************************************************************************/
;


  PROCEDURE COST_CENTER_S_SP (in_COST_CENTER IN COST_CENTER.COST_CENTER_CODE%TYPE
									, out_COST_CENTER_REF_CUR OUT REF_CURSOR
									)
/*******************************************************************************
	COST_CENTER_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the cost center table.  

created : 11/15/2010 kdp CCN Project....
*******************************************************************************/
;

PROCEDURE EMP_DATA_S_SP ( in_EMPLOYEE_NUMBER    IN EMP_DATA.EMPLOYEE_NUMBER%TYPE
		       , out_EMP_DATA_REF_CUR  OUT REF_CURSOR )
/******************************************************************************
	EMP_DATA_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the EMP_DATA table.  

created : 03/20/2012 tal CCN Project....
*******************************************************************************/
;


PROCEDURE HIERARCHY_DESCRIPTION_S_SP ( in_HRCHY_HDR_NAME IN HIERARCHY_DESCRIPTION.HRCHY_HDR_NAME%TYPE
			 , in_HRCHY_HDR_LVL_NBR IN HIERARCHY_DESCRIPTION.HRCHY_HDR_LVL_NBR%TYPE
			, out_HIERARCHY_DESCRIPT_REF_CUR  OUT REF_CURSOR )
/*******************************************************************************
	HIERARCHY_DESCRIPTION_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the HIERARCY_DESCRIPTION table.  

created : 03/22/2012 mdh CCN Project....
******************************************************************************/
;


PROCEDURE HIERARCHY_DETAIL_S_SP ( in_HRCHY_HDR_NAME IN HIERARCHY_DETAIL.HRCHY_HDR_NAME%TYPE
			    ,in_HRCHY_DTL_LEVEL         HIERARCHY_DETAIL.HRCHY_DTL_LEVEL%TYPE
          ,in_HRCHY_DTL_PREV_LVL_VAL  HIERARCHY_DETAIL.HRCHY_DTL_PREV_LVL_VAL%TYPE
          ,in_HRCHY_DTL_CURR_LVL_VAL  HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE
          ,in_HRCHY_DTL_NEXT_LVL_VAL  HIERARCHY_DETAIL.HRCHY_DTL_NEXT_LVL_VAL%TYPE
          ,in_HRCHY_DTL_EFF_DATE      HIERARCHY_DETAIL.HRCHY_DTL_EFF_DATE%TYPE
			, out_HIERARCHY_DETAIL_REF_CUR  OUT REF_CURSOR )
/******************************************************************************
	HIERARCHY_DETAIL_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the HIERARCY_DETAIL table.  

created : 03/22/2012 mdh CCN Project....
******************************************************************************/
;


PROCEDURE HIERARCHY_HEADER_S_SP ( in_HRCHY_HDR_NAME IN HIERARCHY_HEADER.HRCHY_HDR_NAME%TYPE
			 			, out_HIERARCHY_HEADER_REF_CUR  OUT REF_CURSOR )
/*******************************************************************************
	HIERARCHY_HEADER_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the HIERARCY_HEADER table.  

created : 03/22/2012 mdh CCN Project....
******************************************************************************/
;


PROCEDURE MARKETING_S_SP  ( IN_COST_CENTER                 IN  MARKETING.COST_CENTER_CODE%TYPE
                          , IN_MARKETING_TYPE              IN  MARKETING.MARKETING_TYPE%TYPE                          
                          , OUT_MARKETING_REF_CUR          IN  OUT sys_refcursor)
/*******************************************************************************
	MARKETING_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the MARKETING table.  

created : 03/20/2012 tal CCN Project....
*******************************************************************************/
;


PROCEDURE OTHER_S_SP ( in_COST_CENTER     IN OTHER.COST_CENTER_CODE%TYPE
		    , out_OTHER_REF_CUR  OUT REF_CURSOR )
/*******************************************************************************
	OTHER_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the OTHER table.  

created : 03/20/2012 tal CCN Project....
*******************************************************************************/
;


	PROCEDURE PHONE_S_SP ( in_COST_CENTER IN PHONE.COST_CENTER_CODE%TYPE
		    , out_PHONE_REF_CUR OUT REF_CURSOR )
/******************************************************************************
	PHONE_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the PHONE table.  

created : 03/20/2012 tal CCN Project....
******************************************************************************/
;


  PROCEDURE POLLING_S_SP ( in_cost_center          IN polling.cost_center_code%type
					               , in_polling_status_code  IN OUT polling.polling_status_code%type
					               , out_POLLING_REF_CUR    OUT REF_CURSOR)
/*******************************************************************************
	POLLING_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the polling table.  

created : 11/15/2010 kdp CCN Project....
*******************************************************************************/
;

PROCEDURE POLLING_DWLD_RSN_HIST_S_SP ( in_cost_center          IN polling_dwld_rsn_hist.cost_center_code%type
                                     , in_polling_status_code  IN polling_dwld_rsn_hist.polling_status_code%type
                                     , in_effective_date       IN polling_dwld_rsn_hist.effective_date%type
					                           , out_POLLING_DWLD_RSN_REF_CUR    OUT REF_CURSOR)
/******************************************************************************
	POLLING_DWLD_RSN_HIST_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the polling_dwld_rsn_hist table.

created : 07/25/2012 tal CCN Project....
*******************************************************************************/
;

PROCEDURE POLLING_HST_I_SP
( 
/*******************************************************************************
    POLLING_HST_I_SP

    This procedure is intended to insert previous POLLING record into Polling_hst 
    table for Historical purpose.

created : 02/18/2015 SXT410 CCN Project....
revised : 
*******************************************************************************/
IN_POLLING_ROW IN POLLING%ROWTYPE
);

PROCEDURE EXPIRE_POLLING_DATA_SP
( IN_POLLING_ROW POLLING%ROWTYPE 
/*******************************************************************************
    EXPIRE_POLLING_DATA_SP
    
    This procedure is intended to expire Previous row of data based on 
    Cost_center_code and Polling_status_code.

created : 02/18/2015 SXT410 CCN Project....
revised : 
    
*******************************************************************************/
);

	PROCEDURE REAL_ESTATE_S_SP ( in_COST_CENTER     IN REAL_ESTATE.COST_CENTER_CODE%TYPE
		    , out_REAL_ESTATE_REF_CUR  OUT REF_CURSOR )
/*******************************************************************************
	REAL_ESTATE_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the REAL_ESTATE table.  

created : 03/20/2012 tal CCN Project....
*******************************************************************************/
;


PROCEDURE SALES_REP_S_SP  ( IN_GEMS_EMPLOYEE_ID    IN SALES_REP.GEMS_EMPLOYEE_ID%TYPE
                          , OUT_SALES_REP_REF_CUR  OUT REF_CURSOR )
/*******************************************************************************
	SALES_REP_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the SALES_REP table.  

created : 03/20/2012 tal CCN Project....
*******************************************************************************/
;


PROCEDURE STATUS_S_SP ( IN_COST_CENTER      IN STATUS.COST_CENTER_CODE%TYPE
                      , IN_STATUS_CODE      IN STATUS.STATUS_CODE%TYPE
                      , OUT_STATUS_REF_CUR  OUT REF_CURSOR )
/******************************************************************************
	STATUS_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the STATUS table.  

created : 03/20/2012 tal CCN Project....
********************************************************************************/
;


PROCEDURE STORE_S_SP ( in_COST_CENTER     IN STORE.COST_CENTER_CODE%TYPE
		    , out_STORE_REF_CUR  OUT REF_CURSOR )
/*******************************************************************************
	STORE_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the STORE table.  

created : 03/20/2012 tal CCN Project....
********************************************************************************/
;

PROCEDURE DISPATCH_TERMINAL_S_SP(
	in_COST_CENTER IN DISPATCH_TERMINAL.COST_CENTER_CODE%TYPE,
	out_DISPATCH_TERMINAL_REF_CUR OUT REF_CURSOR)
  /*******************************************************************************
  DISPATCH_TERMINAL_S_SP
  This procedure is intended to return a ref cursor with data from
  from the DISPATCH_TERMINAL table.
  created : 04/13/2017 tal CCN Project.... rxa457-asp-763
  ********************************************************************************/
  ;

PROCEDURE TAXWARE_S_SP  ( IN_COST_CENTER        IN  TAXWARE.COST_CENTER_CODE%TYPE
                        , OUT_TAXWARE_REF_CUR   OUT REF_CURSOR )
/*******************************************************************************
	TAXWARE_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the TAXWARE table.  

created : 08/24/2012 tal CCN Project....
*******************************************************************************/
;

-- ***********************************************************************************
PROCEDURE TERMINAL_S_SP ( IN_COST_CENTER_CODE   IN  TERMINAL.COST_CENTER_CODE%TYPE
                        , IN_POLLING_STATUS_CD  IN  TERMINAL.POLLING_STATUS_CODE%TYPE
                        , IN_TERMINAL_NUMBER    IN  TERMINAL.TERMINAL_NUMBER%TYPE
                        , OUT_TERMINAL_REF_CUR  OUT REF_CURSOR )
/******************************************************************************
	TERMINAL_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the TERMINAL table.  

created : 03/22/2012 BLR CCN Project....
********************************************************************************/
;

PROCEDURE TERRITORY_S_SP ( in_terr_cc TERRITORY.COST_CENTER_CODE%TYPE            
                                     ,out_TERRITORY_REF_CUR  OUT REF_CURSOR )
/******************************************************************************
	TERRITORY_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the TERRITORY table.  

created : 03/22/2012 BLR CCN Project....
*******************************************************************************/
;

PROCEDURE TYPE_S_SP ( IN_COST_CENTER    IN  TYPE.COST_CENTER_CODE%TYPE
                    , IN_TYPE_CODE      IN  TYPE.TYPE_CODE%TYPE
                    , OUT_TYPE_REF_CUR  OUT REF_CURSOR )
/*******************************************************************************
	TYPE_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the TYPE table.  

created : 03/22/2012 BLR CCN Project....
changed : 09/12/2012 TAL removed effective_date
******************************************************************************/
;
--**********************************************************


PROCEDURE ADDRESS_CAN_I_SP (
/******************************************************************************
	ADDRESS_CAN_I_SP

	This procedure is intended to insert new ADDRESS_CAN records

	CostCenter     - Cost Center that changed
  Address Type   - Address Type that changed
  Effective Date - Effective Date of ADDRESS_CAN table that changed
	OracleTableName -Table name for row (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 04/27/2012 mdh CCN Project....
******************************************************************************/
in_COST_CENTER          IN  ADDRESS_CAN.COST_CENTER_CODE%TYPE,
in_ADDRESS_TYPE         IN  ADDRESS_CAN.ADDRESS_TYPE%TYPE,
in_EFFECTIVE_DATE       IN  ADDRESS_CAN.EFFECTIVE_DATE%TYPE,
in_TABLE_NAME           IN  VARCHAR2,
in_ROW_DATE             IN  DATE,
in_Row_data             IN  varchar2--sys.xmltype
);

PROCEDURE ADDRESS_MEX_I_SP (
/*****************************************************************************
	ADDRESS_MEX_I_SP

	This procedure is intended to insert new ADDRESS_MEX records

	CostCenter     - Cost Center that changed
  Address Type   - Address Type that changed
  Effective Date - Effective Date of ADDRESS_MEX table that changed
	OracleTableName -Table name for row (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 04/30/2012 mdh CCN Project....
******************************************************************************/
in_COST_CENTER          IN  ADDRESS_MEX.COST_CENTER_CODE%TYPE,
in_ADDRESS_TYPE         IN  ADDRESS_MEX.ADDRESS_TYPE%TYPE,
in_EFFECTIVE_DATE       IN  ADDRESS_MEX.EFFECTIVE_DATE%TYPE,
in_TABLE_NAME           IN  VARCHAR2,
in_ROW_DATE             IN  DATE,
in_Row_data             IN  varchar2--sys.xmltype
);

PROCEDURE ADDRESS_OTHER_I_SP (
/*****************************************************************************
	ADDRESS_OTHER_I_SP

	This procedure is intended to insert new ADDRESS_OTHER records

	CostCenter     - Cost Center that changed
  Address Type   - Address Type that changed
  Effective Date - Effective Date of ADDRESS_OTHER table that changed
	OracleTableName -Table name for row (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 04/30/2012 mdh CCN Project....
******************************************************************************/
in_COST_CENTER          IN  ADDRESS_OTHER.COST_CENTER_CODE%TYPE,
in_ADDRESS_TYPE         IN  ADDRESS_OTHER.ADDRESS_TYPE%TYPE,
in_EFFECTIVE_DATE       IN  ADDRESS_OTHER.EFFECTIVE_DATE%TYPE,
in_TABLE_NAME           IN  VARCHAR2,
in_ROW_DATE             IN  DATE,
in_Row_data             IN  varchar2--sys.xmltype
);

PROCEDURE ADDRESS_USA_I_SP (
/******************************************************************************
	ADDRESS_USA_I_SP

	This procedure is intended to insert new ADDRESS_USA records

	CostCenter - Cost Center that changed
  Address Type   - Address Type that changed
  Effective Date - Effective Date of ADDRESS_OTHER table that changed
	OracleTableName -Table name for row (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 05/02/2012 mdh CCN Project....
*******************************************************************************/
in_COST_CENTER          IN  ADDRESS_USA.COST_CENTER_CODE%TYPE,
in_ADDRESS_TYPE         IN  ADDRESS_USA.ADDRESS_TYPE%TYPE,
in_EFFECTIVE_DATE       IN  ADDRESS_USA.EFFECTIVE_DATE%TYPE,
in_TABLE_NAME           IN  VARCHAR2,
in_ROW_DATE             IN  DATE,
in_Row_data             IN  varchar2--sys.xmltype
);

PROCEDURE ADMINISTRATION_I_SP (
/******************************************************************************
	ADMINISTRATION_I_SP

	This procedure is intended to insert new ADMINISTRATION records

	CostCenter - Cost Center that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 05/01/2012 mdh CCN Project....
******************************************************************************/
in_COST_CENTER          IN  ADMINISTRATION.COST_CENTER_CODE%TYPE,
in_TABLE_NAME           IN  VARCHAR2,
in_ROW_DATE             IN  DATE,
in_ROW_DATA             IN  varchar2 
);

PROCEDURE BANK_CARD_I_SP (
/****************************************************************************
	BANK_CARD_I_SP

	This procedure is intended to insert new BANK_CARD records

	CostCenter        - Cost Center that changed
  PollingStatusCode - Polling Status Code that changed
  Merchant I.D.     - Merchant I.D. that changed
  Effective Date    - Effective Date of Bank_Card that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 04/24/2012 mdh CCN Project....
*****************************************************************************/
in_COST_CENTER          IN  BANK_CARD.COST_CENTER_CODE%TYPE,
in_POLLING_STATUS_CODE  IN  BANK_CARD.POLLING_STATUS_CODE%TYPE,
in_MERCHANT_ID          IN  BANK_CARD.MERCHANT_ID%TYPE,
in_EFFECTIVE_DATE       IN  BANK_CARD.EFFECTIVE_DATE%TYPE,
in_TABLE_NAME           IN  VARCHAR2,
in_ROW_DATE             IN  DATE,
in_ROW_DATA             IN  varchar2 
);

PROCEDURE COST_CENTER_I_SP (
/****************************************************************************
	COST_CENTER_I_SP

	This procedure is intended to insert new cost center records

	CostCenter - Cost Center that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 02/21/2012 kdp CCN Project....
*****************************************************************************/
in_COST_CENTER IN COST_CENTER.COST_CENTER_CODE%TYPE
,in_TABLE_NAME IN VARCHAR2
,in_ROW_DATE   IN DATE
,in_row_data   IN varchar2--sys.xmltype
);

PROCEDURE BATCH_JOB_I_SP (
/***************************************************************
	BATCH_JOB_I_SP

	This procedure is intended to insert new BATCH_JOB records

	BATCH_JOB_NAME    - Batch Job Name   that changed
  BATCH_JOB_NUMBER  - Batch Job Number that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 07/16/2012 tal CCN Project....
***************************************************************/
/***  below are the Primary Key Fields followed by fileds TABLE_NAME, ROW_DATE, Row_data  ***/
in_batch_job_name    IN  batch_job.batch_job_name%type,
in_batch_job_number  IN  batch_job.batch_job_number%type,

in_TABLE_NAME           IN  VARCHAR2,
in_ROW_DATE             IN  DATE,
in_row_data             IN  varchar2--sys.xmltype
);

PROCEDURE CODE_DETAIL_I_SP (
/***************************************************************
	CODE_DETAIL_I_SP

	This procedure is intended to insert new CODE_DETAIL records

	CODE_HEADER_NAME  - Code Header Name  that changed
  CODE_HEADER_TYPE  - Code Header Type  that changed
  CODE_DETAIL_VALUE - Code Detail Value that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 07/12/2012 tal CCN Project....
***************************************************************/
/***  below are the Primary Key Fields followed by fileds TABLE_NAME, ROW_DATE, Row_data  ***/
in_CODE_HEADER_name   IN  CODE_DETAIL.CODE_HEADER_name%type,
in_code_header_type   IN  code_detail.code_header_type%type,
in_code_detail_value  IN  code_detail.code_detail_value%type, 

in_TABLE_NAME           IN  VARCHAR2,
in_ROW_DATE             IN  DATE,
in_row_data             IN  varchar2--sys.xmltype
);

PROCEDURE CODE_HEADER_I_SP (
/***************************************************************
	CODE_HEADER_I_SP

	This procedure is intended to insert new CODE_HEADER records

	CODE_HEADER_NAME - Code Header Name that changed
  CODE_HEADER_TYPE - Code Header Type that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 07/12/2012 tal CCN Project....
***************************************************************/
/***  below are the Primary Key Fields followed by fileds TABLE_NAME, ROW_DATE, Row_data  ***/
in_code_header_name   IN  code_header.code_header_name%type,
in_code_header_type   IN  CODE_HEADER.code_header_type%type,

in_TABLE_NAME           IN  VARCHAR2,
in_ROW_DATE             IN  DATE,
in_row_data             IN  varchar2--sys.xmltype
);

PROCEDURE EMP_DATA_I_SP (
/***************************************************************
	EMP_DATA_I_SP

	This procedure is intended to insert new EMP_DATA records

	EMPLOYEE_NUMBER - Employee Number than changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 07/12/2012 tal CCN Project....
***************************************************************/
/***  below are the Primary Key Fields followed by fileds TABLE_NAME, ROW_DATE, Row_data  ***/
in_employee_number  IN  emp_data.employee_number%type,

in_TABLE_NAME           IN  VARCHAR2,
in_ROW_DATE             IN  DATE,
in_row_data             IN  varchar2--sys.xmltype
);

PROCEDURE MARKETING_I_SP (
/***************************************************************
	MARKETING_I_SP

	This procedure is intended to insert new MARKETING records

	CostCenter     -  Cost Center      that changed
        MarketingType  -  Marketing Type   that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 05/03/2012 tal CCN Project....
***************************************************************/
/***  below are the Primary Key Fields followed by fileds TABLE_NAME, ROW_DATE, Row_data  ***/
in_cost_center          IN  marketing.cost_center_code%type,
in_marketing_type       IN  marketing.marketing_type%type,

in_TABLE_NAME           IN  VARCHAR2,
in_ROW_DATE             IN  DATE,
in_row_data             IN  varchar2--sys.xmltype
);

PROCEDURE OTHER_I_SP (
/***************************************************************
	OTHER_I_SP

	This procedure is intended to insert new OTHER records

	CostCenter - Cost Center that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 07/12/2012 tal CCN Project....
***************************************************************/
/***  below are the Primary Key Fields followed by fileds TABLE_NAME, ROW_DATE, Row_data  ***/
in_COST_CENTER          IN  OTHER.COST_CENTER_CODE%TYPE,

in_TABLE_NAME           IN  VARCHAR2,
in_ROW_DATE             IN  DATE,
in_row_data             IN  varchar2--sys.xmltype
);

PROCEDURE PHONE_I_SP (
/***************************************************************
	PHONE_I_SP

	This procedure is intended to insert new PHONE records

	CostCenter       -  Cost Center        that changed
  PhoneNumberType  -  Phone Number Type  that changed
  
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 05/03/2012 tal CCN Project....
***************************************************************/
/***  below are the Primary Key Fields followed by fileds TABLE_NAME, ROW_DATE, Row_data  ***/
in_COST_CENTER          IN  PHONE.COST_CENTER_CODE%TYPE,
in_phone_number_type    IN  phone.phone_number_type%type,

in_TABLE_NAME           IN  VARCHAR2,
in_ROW_DATE             IN  DATE,
in_row_data             IN  varchar2--sys.xmltype
);

PROCEDURE POLLING_I_SP (
/*****************************************************************************
	POLLING_I_SP

	This procedure is intended to insert new POLLING records

	OracleTableName  -  Table name for row -varible
      xml file     -  the data being inserted
  Polling_ROWTYPE  -  Polling Data Row

created : 05/02/2012 tal CCN Project....
changed: 10/02/2012 TAL - modified to call POLLING_ROWTYPE_SP
*******************************************************************************/
/***  below are the fields required for the ROWTYPE call: Table_name, Row_Data, Table_Rowtype ***/
 in_table_name           IN  varchar2 
,in_row_data             IN  varchar2 --sys.xmltype
,out_POLLING_row         OUT POLLING%ROWTYPE
);

PROCEDURE POLLING_DWLD_RSN_HIST_I_SP (
/***************************************************************
	POLLING_DWLD_RSN_HIST_I_SP

	This procedure is intended to insert new POLLING_DWLD_RSN_HIST records

	CostCenter         -  Cost Center          that changed
  PollingStatusCode  -  Polling Status Code  that changed
  EffectiveDate      -  Effective Date       that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 07/25/2012 tal CCN Project....
***************************************************************/
/***  below are the Primary Key Fields followed by fileds TABLE_NAME, ROW_DATE, Row_data  ***/
in_cost_center          IN polling_dwld_rsn_hist.cost_center_code%type,
in_polling_status_code  IN polling_dwld_rsn_hist.polling_status_code%type,
in_effective_date       IN polling_dwld_rsn_hist.effective_date%type,

in_table_name IN varchar2,
in_ROW_DATE   IN DATE,
in_row_data   IN varchar2 --sys.xmltype
);

PROCEDURE REAL_ESTATE_I_SP (
/*****************************************************************************
	REAL_ESTATE_I_SP

	This procedure is intended to insert new REAL_ESTATE records

	OracleTableName  -  Table name for row -varible
      xml file     -  the data being inserted
  Real_Estate_ROWTYPE  -  Real_Estate Data Row

created : 05/03/2012 tal CCN Project....
changed: 10/02/2012 TAL - modified to call REAL_ESTATE_ROWTYPE_SP
*******************************************************************************/
/***  below are the fields required for the ROWTYPE call: Table_name, Row_Data, Table_Rowtype ***/
 in_table_name           IN  varchar2 
,in_row_data             IN  varchar2 --sys.xmltype
,out_REAL_ESTATE_row     OUT REAL_ESTATE%ROWTYPE
);

PROCEDURE SALES_REP_I_SP (
/*****************************************************************************
	SALES_REP_I_SP

	This procedure is intended to insert new SALES_REP records

	OracleTableName  -  Table name for row -varible
      xml file     -  the data being inserted
  Sales_ROWTYPE    -  Sales Data Row

created : 05/03/2012 tal CCN Project....
changed: 10/02/2012 TAL - modified to call SALES_REP_ROWTYPE_SP
*******************************************************************************/
/***  below are the fields required for the ROWTYPE call: Table_name, Row_Data, Table_Rowtype ***/
 in_table_name           IN  varchar2 
,in_row_data             IN  varchar2 --sys.xmltype
,out_SALES_REP_row       OUT SALES_REP%ROWTYPE
);

PROCEDURE STATUS_I_SP (
/*****************************************************************************
	STATUS_I_SP

	This procedure is intended to insert new STATUS records

	OracleTableName  -  Table name for row -varible
      xml file     -  the data being inserted
  Status_ROWTYPE   -  Statue Data Row

created : 05/03/2012 tal CCN Project....
changed: 10/02/2012 TAL - modified to call STATUS_ROWTYPE_SP
*******************************************************************************/
/***  below are the fields required for the ROWTYPE call: Table_name, Row_Data, Table_Rowtype ***/
 in_table_name           IN  varchar2 
,in_row_data             IN  varchar2 --sys.xmltype
,out_STATUS_row          OUT STATUS%ROWTYPE
);

PROCEDURE STORE_I_SP (
/*****************************************************************************
	STORE_I_SP

	This procedure is intended to insert new STORE records

	OracleTableName  -  Table name for row -varible
      xml file     -  the data being inserted
  Store_ROWTYPE    -  Store Data Row

created : 05/03/2012 tal CCN Project....
changed: 10/02/2012 TAL - modified to call STORE_ROWTYPE_SP
*******************************************************************************/
/***  below are the fields required for the ROWTYPE call: Table_name, Row_Data, Table_Rowtype ***/
 in_table_name           IN  varchar2 
,in_row_data             IN  varchar2 --sys.xmltype
,out_STORE_row           OUT STORE%ROWTYPE
);

PROCEDURE DISPATCH_TERMINAL_I_SP(
    /*****************************************************************************
    DISPATCH_TERTMINAL_I_SP
    This procedure is intended to insert new DISPATCH_TERMINAL records
    OracleTableName  -  Table name for row -varible
    xml file     -  the data being inserted
    DISPATCH_TERMINAL_ROWTYPE    -  Dispatch Terminal Data Row
    created : 04/14/2017 asp-763 CCN Project....
    -- below are the fields required for the ROWTYPE call: Table_name, Row_Data, Table_Rowtype ***/
    in_table_name IN VARCHAR2,
    in_row_data   IN VARCHAR2, --sys.xmltype
    out_dispatch_terminal_row OUT DISPATCH_TERMINAL%ROWTYPE);


PROCEDURE TAXWARE_I_SP (
/*****************************************************************************
	TAXWARE_I_SP

	This procedure is intended to insert new TAXWARE records

	OracleTableName  -  Table name for row -varible
      xml file     -  the data being inserted
  Taxware_ROWTYPE  -  Taxware Data Row

created : 08/24/2012 tal CCN Project....
changed: 10/02/2012 TAL - modified to call TAXWARE_ROWTYPE_SP
*******************************************************************************/
/***  below are the fields required for the ROWTYPE call: Table_name, Row_Data, Table_Rowtype ***/
 in_table_name           IN  varchar2 
,in_row_data             IN  varchar2 --sys.xmltype
,out_TAXWARE_row         OUT TAXWARE%ROWTYPE
);

PROCEDURE TERMINAL_I_SP 
(
/****************************************************************************
	TERMINAL_I_SP

	This procedure is intended to insert new terminal records

	OracleTableName  -  Table name for row -varible
      xml file     -  the data being inserted
  Terminal_ROWTYPE  -  Terminal Data Row

created : 04/24/2012 BLR CCN Project....
changed: 10/02/2012 TAL - modified to call TERMINAL_ROWTYPE_SP
*******************************************************************************/
/***  below are the fields required for the ROWTYPE call: Table_name, Row_Data, Table_Rowtype ***/
 in_table_name           IN  varchar2 
,in_row_data             IN  varchar2 --sys.xmltype
,out_TERMINAL_row        OUT TERMINAL%ROWTYPE
);

PROCEDURE TERRITORY_I_SP (
/*****************************************************************************
	TERRITORY_I_SP

	This procedure is intended to insert new TERRITORY records

	OracleTableName  -  Table name for row -varible
      xml file     -  the data being inserted
  Territory_ROWTYPE  -  Territory Data Row

created : 04/24/2012 BLR CCN Project....
changed: 10/02/2012 TAL - modified to call TERRITORY_ROWTYPE_SP
*******************************************************************************/
/***  below are the fields required for the ROWTYPE call: Table_name, Row_Data, Table_Rowtype ***/
 in_table_name           IN  varchar2 
,in_row_data             IN  varchar2 --sys.xmltype
,out_TERRITORY_row       OUT TERRITORY%ROWTYPE
);

PROCEDURE TYPE_I_SP (
/******************************************************************************
	TYPE_I_SP

	This procedure is intended to insert new TYPE records

	OracleTableName  -  Table name for row -varible
      xml file     -  the data being inserted
  Type_ROWTYPE  -  Type Data Row

created : 04/24/2012 BLR CCN Project....
changed: 10/02/2012 TAL - modified to call TYPE_ROWTYPE_SP
*******************************************************************************/
/***  below are the fields required for the ROWTYPE call: Table_name, Row_Data, Table_Rowtype ***/
 in_table_name           IN  varchar2 
,in_row_data             IN  varchar2 --sys.xmltype
,out_TYPE_row            OUT TYPE%ROWTYPE
);

/*********************************
updates
*********************************/

PROCEDURE ADDRESS_CAN_U_SP (
/*****************************************************************************
	ADDRESS_CAN_U_SP

	This procedure is intended to Update ADDRESS_CAN records

	CostCenter     - Cost Center that changed
  Address Type   - Address Type that changed
  Effective Date - Effective Date of ADDRESS_CAN table that changed
	OracleTableName -Table name for row (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 07/19/2012 mdh CCN Project....
*****************************************************************************/
in_COST_CENTER          IN  ADDRESS_CAN.COST_CENTER_CODE%TYPE,
in_ADDRESS_TYPE         IN  ADDRESS_CAN.ADDRESS_TYPE%TYPE,
in_EFFECTIVE_DATE       IN  ADDRESS_CAN.EFFECTIVE_DATE%TYPE,
in_TABLE_NAME           IN  VARCHAR2,
in_ROW_DATE             IN  DATE,
in_Row_data             IN  varchar2--sys.xmltype
);

PROCEDURE ADDRESS_MEX_U_SP (
/****************************************************************************
	ADDRESS_MEX_U_SP

	This procedure is intended to Update ADDRESS_MEX records

	CostCenter     - Cost Center that changed
  Address Type   - Address Type that changed
  Effective Date - Effective Date of ADDRESS_MEX table that changed
	OracleTableName -Table name for row (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 07/19/2012 mdh CCN Project....
*****************************************************************************/
in_COST_CENTER          IN  ADDRESS_MEX.COST_CENTER_CODE%TYPE,
in_ADDRESS_TYPE         IN  ADDRESS_MEX.ADDRESS_TYPE%TYPE,
in_EFFECTIVE_DATE       IN  ADDRESS_MEX.EFFECTIVE_DATE%TYPE,
in_TABLE_NAME           IN  VARCHAR2,
in_ROW_DATE             IN  DATE,
in_Row_data             IN  varchar2 --sys.xmltype
);

PROCEDURE ADDRESS_OTHER_U_SP (
/****************************************************************************
	ADDRESS_OTHER_U_SP

	This procedure is intended to Update ADDRESS_OTHER records

	CostCenter     - Cost Center that changed
  Address Type   - Address Type that changed
  Effective Date - Effective Date of ADDRESS_OTHER table that changed
	OracleTableName -Table name for row (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 07/19/2012 mdh CCN Project....
*****************************************************************************/
in_COST_CENTER          IN  ADDRESS_OTHER.COST_CENTER_CODE%TYPE,
in_ADDRESS_TYPE         IN  ADDRESS_OTHER.ADDRESS_TYPE%TYPE,
in_EFFECTIVE_DATE       IN  ADDRESS_OTHER.EFFECTIVE_DATE%TYPE,
in_TABLE_NAME           IN  VARCHAR2,
in_ROW_DATE             IN  DATE,
in_Row_data             IN  varchar2--sys.xmltype
);


PROCEDURE ADDRESS_USA_U_SP (
/*****************************************************************************
	ADDRESS_USA_U_SP

	This procedure is intended to Update ADDRESS_USA records

	CostCenter - Cost Center that changed
  Address Type   - Address Type that changed
  Effective Date - Effective Date of ADDRESS_OTHER table that changed
	OracleTableName -Table name for row (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 07/20/2012 mdh CCN Project....
******************************************************************************/
in_COST_CENTER          IN  ADDRESS_USA.COST_CENTER_CODE%TYPE,
in_ADDRESS_TYPE         IN  ADDRESS_USA.ADDRESS_TYPE%TYPE,
in_EFFECTIVE_DATE       IN  ADDRESS_USA.EFFECTIVE_DATE%TYPE,
in_TABLE_NAME           IN  VARCHAR2,
in_ROW_DATE             IN  DATE,
in_Row_data             IN  varchar2--sys.xmltype
);

PROCEDURE ADMINISTRATION_U_SP (
/*****************************************************************************
	ADMINISTRATION_U_SP

	This procedure is intended to Update ADMINISTRATION records

	CostCenter - Cost Center that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 07/18/2012 mdh CCN Project....
******************************************************************************/
in_COST_CENTER          IN  ADMINISTRATION.COST_CENTER_CODE%TYPE,
in_TABLE_NAME           IN  VARCHAR2,
in_ROW_DATE             IN  DATE,
in_ROW_DATA             IN  varchar2 
);

PROCEDURE BANK_CARD_U_SP (
/*****************************************************************************
	BANK_CARD_U_SP

	This procedure is intended to Update BANK_CARD records

	CostCenter        - Cost Center that changed
  PollingStatusCode - Polling Status Code that changed
  Merchant I.D.     - Merchant I.D. that changed
  Effective Date    - Effective Date of Bank_Card that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 04/24/2012 mdh CCN Project....
******************************************************************************/
in_COST_CENTER          IN  BANK_CARD.COST_CENTER_CODE%TYPE,
in_POLLING_STATUS_CODE  IN  BANK_CARD.POLLING_STATUS_CODE%TYPE,
in_MERCHANT_ID          IN  BANK_CARD.MERCHANT_ID%TYPE,
in_EFFECTIVE_DATE       IN  BANK_CARD.EFFECTIVE_DATE%TYPE,
in_TABLE_NAME           IN  VARCHAR2,
in_ROW_DATE             IN  DATE,
in_ROW_DATA             IN  varchar2 
);

PROCEDURE BATCH_JOB_U_SP (
/***************************************************************
	BATCH_JOB_U_SP

	This procedure is intended to update existing BATCH_JOB records

	BATCH_JOB_NAME    - Batch Job Name   that changed
  BATCH_JOB_NUMBER  - Batch Job Number that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 07/16/2012 tal CCN Project....
***************************************************************/
/***  below are the Primary Key Fields followed by fileds TABLE_NAME, ROW_DATE, Row_data  ***/
in_batch_job_name    IN  batch_job.batch_job_name%type,
in_batch_job_number  IN  batch_job.batch_job_number%type,

in_TABLE_NAME           IN  VARCHAR2,
in_ROW_DATE             IN  DATE,
in_row_data             IN  varchar2--sys.xmltype
);

PROCEDURE CODE_DETAIL_U_SP (
/***************************************************************
	CODE_DETAIL_U_SP

	This procedure is intended to update existing CODE_DETAIL records

	CODE_HEADER_NAME  - Code Header Name  that changed
  CODE_HEADER_TYPE  - Code Header Type  that changed
  CODE_DETAIL_VALUE - Code Detail Value that changed
	OracleTableName   - Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 07/16/2012 tal CCN Project....
***************************************************************/
/***  below are the Primary Key Fields followed by fileds TABLE_NAME, ROW_DATE, Row_data  ***/
in_CODE_HEADER_name   IN  CODE_DETAIL.CODE_HEADER_name%type,
in_code_header_type   IN  code_detail.code_header_type%type,
in_code_detail_value  IN  code_detail.code_detail_value%type, 

in_TABLE_NAME           IN  VARCHAR2,
in_ROW_DATE             IN  DATE,
in_row_data             IN  varchar2--sys.xmltype
);

PROCEDURE CODE_HEADER_U_SP (
/***************************************************************
	CODE_HEADER_U_SP

	This procedure is intended to update existing CODE_HEADER records

	CODE_HEADER_NAME - Code Header Name that changed
  CODE_HEADER_TYPE - Code Header Type that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 07/12/2012 tal CCN Project....
***************************************************************/
/***  below are the Primary Key Fields followed by fileds TABLE_NAME, ROW_DATE, Row_data  ***/
in_code_header_name   IN  code_header.code_header_name%type,
in_code_header_type   IN  CODE_HEADER.code_header_type%type,

in_TABLE_NAME           IN  VARCHAR2,
in_ROW_DATE             IN  DATE,
in_row_data             IN  varchar2--sys.xmltype
);

PROCEDURE COST_CENTER_U_SP (
/******************************************************************************
	COST_CENTER_U_SP

	This procedure is intended to UPDATE cost center records

	CostCenter - Cost Center that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 02/21/2012 kdp CCN Project....
*****************************************************************************/
in_COST_CENTER IN COST_CENTER.COST_CENTER_CODE%TYPE
,in_TABLE_NAME IN VARCHAR2
,in_ROW_DATE   IN DATE
,in_row_data   IN varchar2--sys.xmltype
);

PROCEDURE EMP_DATA_U_SP (
/******************************************************************************
	EMP_DATA_U_SP

	This procedure is intended to update existing EMP_DATA records

	EMPLOYEE_NUMBER - Employee Number than changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 07/12/2012 tal CCN Project....
*******************************************************************************/
/***  below are the Primary Key Fields followed by fileds TABLE_NAME, ROW_DATE, Row_data  ***/
in_employee_number  IN  emp_data.employee_number%type,

in_TABLE_NAME           IN  VARCHAR2,
in_ROW_DATE             IN  DATE,
in_row_data             IN  varchar2--sys.xmltype
);

PROCEDURE MARKETING_U_SP (
/******************************************************************************
	MARKETING_U_SP

	This procedure is intended to insert new MARKETING records

	CostCenter     -  Cost Center      that changed
        MarketingType  -  Marketing Type   that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 05/03/2012 tal CCN Project....
*******************************************************************************/
/***  below are the Primary Key Fields followed by fileds TABLE_NAME, ROW_DATE, Row_data  ***/
in_cost_center          IN  marketing.cost_center_code%type,
in_marketing_type       IN  marketing.marketing_type%type,

in_TABLE_NAME           IN  VARCHAR2,
in_ROW_DATE             IN  DATE,
in_row_data             IN  varchar2--sys.xmltype
);

PROCEDURE OTHER_U_SP (
/******************************************************************************
	OTHER_U_SP

	This procedure is intended to update existing OTHER records

	CostCenter - Cost Center that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 07/12/2012 tal CCN Project....
*******************************************************************************/
/***  below are the Primary Key Fields followed by fileds TABLE_NAME, ROW_DATE, Row_data  ***/
in_COST_CENTER          IN  OTHER.COST_CENTER_CODE%TYPE,

in_TABLE_NAME           IN  VARCHAR2,
in_ROW_DATE             IN  DATE,
in_row_data             IN  varchar2--sys.xmltype
);

PROCEDURE PHONE_U_SP (
/*******************************************************************************
	PHONE_U_SP

	This procedure is intended to update existing PHONE records

	PHONE - Cost Center that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 05/03/2012 tal CCN Project....
*******************************************************************************/
/***  below are the Primary Key Fields followed by fileds TABLE_NAME, ROW_DATE, Row_data  ***/
in_COST_CENTER          IN  PHONE.COST_CENTER_CODE%TYPE,
in_phone_number_type    IN  phone.phone_number_type%type,

in_TABLE_NAME           IN  VARCHAR2,
in_ROW_DATE             IN  DATE,
in_row_data             IN  varchar2--sys.xmltype
);


PROCEDURE POLLING_U_SP (
/*****************************************************************************
	POLLING_U_SP

	This procedure is intended to update existing POLLING records

	CostCenter         -  Cost Center           that changed
  PollingStatusCode  -  Polling Status Code   that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 05/02/2012 tal CCN Project....
changed: 10/02/2012 TAL - modified to call POLLING_ROWTYPE_SP
*******************************************************************************/
/***  below are the fields required for the ROWTYPE call: Table_name, Row_Data, Table_Rowtype ***/
 in_table_name           IN  varchar2 
,in_row_data             IN  varchar2 --sys.xmltype
,out_POLLING_row         OUT POLLING%ROWTYPE
);


PROCEDURE POLLING_DWLD_RSN_HIST_U_SP (
/******************************************************************************
	POLLING_DWLD_RSN_HIST_U_SP

	This procedure is intended to insert new POLLING_DWLD_RSN_HIST records

	CostCenter         -  Cost Center          that changed
  PollingStatusCode  -  Polling Status Code  that changed
  EffectiveDate      -  Effective Date       that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 07/25/2012 tal CCN Project....
******************************************************************************/
/***  below are the Primary Key Fields followed by fileds TABLE_NAME, ROW_DATE, Row_data  ***/
in_cost_center          IN polling_dwld_rsn_hist.cost_center_code%type,
in_polling_status_code  IN polling_dwld_rsn_hist.polling_status_code%type,
in_effective_date       IN polling_dwld_rsn_hist.effective_date%type,

in_table_name IN varchar2,
in_ROW_DATE   IN DATE,
in_row_data   IN varchar2 --sys.xmltype
);


PROCEDURE REAL_ESTATE_U_SP (
/******************************************************************************
	REAL_ESTATE_U_SP

	This procedure is intended to update changes to REAL_ESTATE records

	CostCenter - Cost Center that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 07/11/2012 tal CCN Project....
changed: 10/02/2012 TAL - modified to call REAL_ESTATE_ROWTYPE_SP
*******************************************************************************/
/***  below are the fields required for the ROWTYPE call: Table_name, Row_Data, Table_Rowtype ***/
 in_table_name           IN  varchar2 
,in_row_data             IN  varchar2 --sys.xmltype
,out_REAL_ESTATE_row     OUT REAL_ESTATE%ROWTYPE
);

PROCEDURE SALES_REP_U_SP (
/******************************************************************************
	SALES_REP_U_SP

	This procedure is intended to update changed SALES_REP records

	CostCenter - Cost Center that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 07/11/2012 tal CCN Project....
changed: 10/02/2012 TAL - modified to call SALES_REP_ROWTYPE_SP
*******************************************************************************/
/***  below are the fields required for the ROWTYPE call: Table_name, Row_Data, Table_Rowtype ***/
 in_table_name           IN  varchar2 
,in_row_data             IN  varchar2 --sys.xmltype
,out_SALES_REP_row       OUT SALES_REP%ROWTYPE
);

PROCEDURE STATUS_U_SP (
/*****************************************************************************
	STATUS_U_SP

	This procedure is intended to update changed STATUS records

	CostCenter - Cost Center that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 07/11/2012 tal CCN Project....
changed: 10/02/2012 TAL - modified to call STATUS_ROWTYPE_SP
*******************************************************************************/
/***  below are the fields required for the ROWTYPE call: Table_name, Row_Data, Table_Rowtype ***/
 in_table_name           IN  varchar2 
,in_row_data             IN  varchar2 --sys.xmltype
,out_STATUS_row          OUT STATUS%ROWTYPE
);

PROCEDURE STORE_U_SP (
/******************************************************************************
	STORE_U_SP

	This procedure is intended to update changed STORE records

	CostCenter - Cost Center that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 07/11/2012 tal CCN Project....
changed: 10/02/2012 TAL - modified to call STORE_ROWTYPE_SP
*******************************************************************************/
/***  below are the fields required for the ROWTYPE call: Table_name, Row_Data, Table_Rowtype ***/
 in_table_name           IN  varchar2 
,in_row_data             IN  varchar2 --sys.xmltype
,out_STORE_row           OUT STORE%ROWTYPE
);

PROCEDURE DISPATCH_TERMINAL_U_SP(
/*****************************************************************/
--DISPATCH_TERMINAL_U_SP
--This procedure is intended to update changed DISPATCH_TERMINAL records
--CostCenter - Cost Center that changed
--OracleTableName -Table name for row -varible (based on the table that was updated)
--in_row_data - xml file - the data being inserted
--created : 04/14/2017 ASP-763 CCN Project....
/*****************************************************************/
/***  below are the fields required for the ROWTYPE call: Table_name, Row_Data, Table_Rowtype ***/
in_table_name IN VARCHAR2,
in_row_data   IN VARCHAR2, --sys.xmltype
out_DISPATCH_TERMINAL_row OUT DISPATCH_TERMINAL%ROWTYPE);

PROCEDURE TAXWARE_U_SP (
/******************************************************************************
	TAXWARE_U_SP

	This procedure is intended to update changed TAXWARE records

	CostCenter - Cost Center that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 08/24/2012 tal CCN Project....
changed: 10/02/2012 TAL - modified to call TAXWARE_ROWTYPE_SP
*******************************************************************************/
/***  below are the fields required for the ROWTYPE call: Table_name, Row_Data, Table_Rowtype ***/
 in_table_name           IN  varchar2 
,in_row_data             IN  varchar2 --sys.xmltype
,out_TAXWARE_row         OUT TAXWARE%ROWTYPE
);

PROCEDURE TERMINAL_U_SP 
(
/*****************************************************************************
	TERMINAL_U_SP

	This procedure is intended to update changed terminal records

	TERMINAL - Cost Center that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 07/11/2012 BLR CCN Project....
changed: 10/02/2012 TAL - modified to call TERMINAL_ROWTYPE_SP
*******************************************************************************/
/***  below are the fields required for the ROWTYPE call: Table_name, Row_Data, Table_Rowtype ***/
 in_table_name           IN  varchar2 
,in_row_data             IN  varchar2 --sys.xmltype
,out_TERMINAL_row        OUT TERMINAL%ROWTYPE
);

PROCEDURE TERRITORY_U_SP (
/*****************************************************************************
	TERRITORY_U_SP

	This procedure is intended to update changed TERRITORY records

	TERRITORY - Cost Center that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 07/11/2012 BLR CCN Project....
changed: 10/02/2012 TAL - modified to call TERRITORY_ROWTYPE_SP
*******************************************************************************/
/***  below are the fields required for the ROWTYPE call: Table_name, Row_Data, Table_Rowtype ***/
 in_table_name           IN  varchar2 
,in_row_data             IN  varchar2 --sys.xmltype
,out_TERRITORY_row       OUT TERRITORY%ROWTYPE
);

PROCEDURE TYPE_U_SP (
/*****************************************************************************
	TYPE_U_SP

	This procedure is intended to update changed TYPE records

	TYPE - Cost Center that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 07/11/2012 BLR CCN Project....
changed: 10/02/2012 TAL - modified to call TYPE_ROWTYPE_SP
*******************************************************************************/
/***  below are the fields required for the ROWTYPE call: Table_name, Row_Data, Table_Rowtype ***/
 in_table_name           IN  varchar2 
,in_row_data             IN  varchar2 --sys.xmltype
,out_TYPE_row         OUT TYPE%ROWTYPE
);                                     

--PROCEDURES TO HANDLE INSERTS & UPDATES OF TABLES (ROWTYPES)
--AS OF 10/04/2012   BLR

PROCEDURE ADDRESS_CAN_ROWTYPE_SP ( 
/*******************************************************************************
	 ADDRESS_CAN_ROWTYPE_SP

	This procedure is intended to Insert/Update  Canadian address records

	CostCenter      - Cost Center that changed
  Address Type    - Address Type that changed
  Effective Date  - Effective Date of ADDRESS_CAN table that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 09/21/2012 blr CCN Project....
*******************************************************************************/
 in_cost_center     IN  address_can.cost_center_code%type 
,in_address_type    IN  address_can.address_type%type 
,in_effective_date  IN  address_can.effective_date%type
,in_TABLE_NAME IN VARCHAR2
,in_ROW_DATE   IN DATE
,in_Row_data   IN varchar2 --sys.xmltype
,out_address_type  OUT address_can%ROWTYPE
);

PROCEDURE ADDRESS_MEX_ROWTYPE_SP ( 
 /******************************************************************************
	ADDRESS_MEX_ROWTYPE_SP

	This procedure is intended to Insert new Mexico address records

	CostCenter      - Cost Center that changed
  Address Type    - Address Type that changed
  Effective Date  - Effective Date of ADDRESS_CAN table that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 09/21/2012 blr CCN Project....
*******************************************************************************/
in_COST_CENTER    IN ADDRESS_MEX.COST_CENTER_CODE%TYPE
,in_ADDRESS_TYPE   IN ADDRESS_MEX.ADDRESS_TYPE%TYPE
,in_EFFECTIVE_DATE IN ADDRESS_MEX.EFFECTIVE_DATE%TYPE
,in_TABLE_NAME IN VARCHAR2
,in_ROW_DATE   IN DATE
,in_Row_data   IN varchar2 --sys.xmltype
,out_address_type  OUT address_mex%ROWTYPE
);

PROCEDURE ADDRESS_OTHER_ROWTYPE_SP ( 
/*******************************************************************************
	ADDRESS_OTHER_ROWTYPE_SP

	This procedure is intended to Insert new OTHER address records

	CostCenter      - Cost Center that changed
  Address Type    - Address Type that changed
  Effective Date  - Effective Date of ADDRESS_OTHER table that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 09/21/2012 blr CCN Project....
*******************************************************************************/
 in_COST_CENTER    IN ADDRESS_OTHER.COST_CENTER_CODE%TYPE
,in_ADDRESS_TYPE   IN ADDRESS_OTHER.ADDRESS_TYPE%TYPE
,in_EFFECTIVE_DATE IN ADDRESS_OTHER.EFFECTIVE_DATE%TYPE
,in_TABLE_NAME IN VARCHAR2
,in_ROW_DATE   IN DATE
,in_Row_data   IN varchar2 --sys.xmltype
,out_address_type  OUT address_other%ROWTYPE
);

PROCEDURE ADDRESS_USA_ROWTYPE_SP (
/*******************************************************************************
	ADDRESS_USA_ROWTYPE_SP

	This procedure is intended to insert new ADDRESS_USA records

	CostCenter - Cost Center that changed
  Address Type    - Address Type that changed
  Effective Date  - Effective Date of ADDRESS_OTHER table that changed
	OracleTableName -Table name for row (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 09/21/2012 blr CCN Project....
*******************************************************************************/

 in_COST_CENTER          IN  ADDRESS_USA.COST_CENTER_CODE%TYPE 
,in_ADDRESS_TYPE         IN  ADDRESS_USA.ADDRESS_TYPE%TYPE 
,in_EFFECTIVE_DATE       IN  ADDRESS_USA.EFFECTIVE_DATE%TYPE 
,in_TABLE_NAME           IN  VARCHAR2 
,in_ROW_DATE             IN  DATE 
,in_Row_data             IN  varchar2--sys.xmltype
,out_address_type        OUT address_usa%ROWTYPE
);

PROCEDURE ADMINISTRATION_ROWTYPE_SP (
/*******************************************************************************
	ADMINISTRATION_ROWTYPE_SP

	This procedure is intended to Insert new ADMINISTRATION records

	CostCenter - Cost Center that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 09/21/2012 blr CCN Project....
*******************************************************************************/
 in_COST_CENTER    IN ADMINISTRATION.COST_CENTER_CODE%TYPE 
,in_TABLE_NAME IN VARCHAR2
,in_ROW_DATE   IN DATE
,in_Row_data   IN varchar2 --sys.xmltype
,out_administration_type  OUT ADMINISTRATION%ROWTYPE
);
 
PROCEDURE BANK_CARD_ROWTYPE_SP (
/*******************************************************************************
	BANK_CARD_ROWTYPE_SP

	This procedure is intended to Insert new BANK CARD records

	CostCenter          - Cost Center that changed
  Polling_Status_Code - Polling Status of the Cost Center
  Merchant I.D.       - Merchant I.D. of the Cost Center 
  Effective Date      - Effective Date of BANK_CARD table that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 09/21/2012 blr CCN Project....
*******************************************************************************/
 in_COST_CENTER          IN BANK_CARD.COST_CENTER_CODE%TYPE 
,in_POLLING_STATUS_CODE  IN BANK_CARD.POLLING_STATUS_CODE%type 
,in_MERCHANT_ID          IN BANK_CARD.MERCHANT_ID%TYPE 
,in_EFFECTIVE_DATE       IN BANK_CARD.EFFECTIVE_DATE%type

,in_TABLE_NAME IN VARCHAR2
,in_ROW_DATE   IN DATE
,in_Row_data   IN varchar2 --sys.xmltype
,out_bank_card_row  OUT  bank_card%ROWTYPE
);

PROCEDURE COST_CENTER_ROWTYPE_SP (
/*******************************************************************************
	COST_CENTER_ROWTYPE_SP

	This procedure is intended to insert new cost center records

	CostCenter - Cost Center that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 09/21/2012 blr CCN Project....
revised:
*******************************************************************************/
 in_COST_CENTER IN COST_CENTER.COST_CENTER_CODE%TYPE
,in_TABLE_NAME IN VARCHAR2
,in_ROW_DATE   IN DATE
,in_Row_data   IN VARCHAR2--sys.xmltype
,out_cost_center_type  OUT cost_center%ROWTYPE
);

PROCEDURE MARKETING_ROWTYPE_SP (
/*******************************************************************************
	MARKETING_ROWTYPE_SP

	This procedure is intended to insert new MARKETING records

	CostCenter     -  Cost Center      that changed
        MarketingType  -  Marketing Type   that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 09/21/2012 blr CCN Project....
*******************************************************************************/
/***  below are the Primary Key Fields followed by fileds TABLE_NAME, ROW_DATE, Row_data  ***/
 in_cost_center          IN  marketing.cost_center_code%type 
,in_marketing_type       IN  marketing.marketing_type%type 

,in_TABLE_NAME           IN  VARCHAR2 
,in_ROW_DATE             IN  DATE 
,in_Row_data             IN  varchar2--sys.xmltype
,out_marketing_type  OUT marketing%ROWTYPE

);

PROCEDURE OTHER_ROWTYPE_SP (
/*******************************************************************************
	OTHER_ROWTYPE_SP

	This procedure is intended to insert new OTHER records

	CostCenter - Cost Center that changed
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 09/21/2012 blr CCN Project....
revised : 
*******************************************************************************/
/***  below are the Primary Key Fields followed by fileds TABLE_NAME, ROW_DATE, Row_data  ***/

 in_COST_CENTER          IN  OTHER.COST_CENTER_CODE%TYPE 
,out_other_type              OUT OTHER%ROWTYPE

,in_TABLE_NAME           IN  VARCHAR2 
,in_ROW_DATE             IN  DATE 
,in_Row_data             IN  varchar2--sys.xmltype
 
);

PROCEDURE PHONE_ROWTYPE_SP (
/*******************************************************************************
	PHONE_ROWTYPE_SP

	This procedure is intended to insert new PHONE records

	CostCenter       -  Cost Center        that changed
  PhoneNumberType  -  Phone Number Type  that changed
  
	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
        current date - 
        xml file - the data being inserted

created : 09/21/2012 blr CCN Project....
*******************************************************************************/
/***  below are the Primary Key Fields followed by fileds TABLE_NAME, ROW_DATE, Row_data  ***/

 in_COST_CENTER          IN  PHONE.COST_CENTER_CODE%TYPE 
,in_phone_number_type    IN  phone.phone_number_type%type 
,out_phone_type              OUT PHONE%ROWTYPE 

,in_TABLE_NAME           IN  VARCHAR2 
,in_ROW_DATE             IN  DATE 
,in_Row_data             IN  varchar2--sys.xmltype
);

PROCEDURE POLLING_ROWTYPE_SP (
/*******************************************************************************
	POLLING_ROWTYPE_SP

	This procedure Build a POLLING Rowtype ROW

	OracleTableName  -  Table name for row -varible
      xml file     -  the data being inserted
  Polling_ROWTYPE  -  Polling Data Row

created : 09/26/2012 TAL -- CCN Project....
*******************************************************************************/
/***  below are the fields required for the ROWTYPE call: Table_name, Row_Data, Table_Rowtype ***/
 in_table_name           IN  varchar2 
,in_row_data             IN  varchar2 --sys.xmltype
,out_polling_rowtype     OUT polling%ROWTYPE
);

PROCEDURE REAL_ESTATE_ROWTYPE_SP (
/******************************************************************************
	REAL_ESTATE_ROWTYPE_SP

	This procedure Build a REAL_ESTATE Rowtype ROW

	OracleTableName  -  Table name for row -varible
      xml file     -  the data being inserted
  REAL_ESTATE_ROWTYPE  -  REAL_ESTATE Data Row

created : 09/26/2012 TAL -- CCN Project....
******************************************************************************/
/***  below are the fields required for the ROWTYPE call: Table_name, Row_Data, Table_Rowtype ***/
 IN_TABLE_NAME           IN  VARCHAR2 
,in_row_data             IN  varchar2 --sys.xmltype
,OUT_REAL_ESTATE_ROWTYPE     OUT REAL_ESTATE%ROWTYPE
);

PROCEDURE SALES_REP_ROWTYPE_SP (
/******************************************************************************
	SALES_REP_ROWTYPE_SP

	This procedure Build a SALES_REP Rowtype ROW

	OracleTableName  -  Table name for row -varible
      xml file     -  the data being inserted
  Sales_Rep_ROWTYPE  -  Sales_Rep Data Row

created : 09/26/2012 TAL -- CCN Project....
******************************************************************************/
/***  below are the fields required for the ROWTYPE call: Table_name, Row_Data, Table_Rowtype ***/
 IN_TABLE_NAME           IN  VARCHAR2 
,in_row_data             IN  varchar2 --sys.xmltype
,OUT_SALES_REP_ROWTYPE   OUT SALES_REP%ROWTYPE
);

PROCEDURE STATUS_ROWTYPE_SP (
/******************************************************************************
	STATUS_ROWTYPE_SP

	This procedure Build a STATUS Rowtype ROW

	OracleTableName  -  Table name for row -varible
      xml file     -  the data being inserted
  Status_ROWTYPE   -  Status Data Row

created: 09/26/2012 TAL -- CCN Project....
******************************************************************************/
/***  below are the fields required for the ROWTYPE call: Table_name, Row_Data, Table_Rowtype ***/
 in_table_name           IN  varchar2 
,in_row_data             IN  varchar2 --sys.xmltype
,OUT_STATUS_ROWTYPE   OUT STATUS%ROWTYPE
);

PROCEDURE STORE_ROWTYPE_SP (
/******************************************************************************
	STORE_ROWTYPE_SP

	This procedure Build a STORE Rowtype ROW

	OracleTableName  -  Table name for row -varible
      xml file     -  the data being inserted
  Store_ROWTYPE    -  Store Data Row

created : 09/26/2012 TAL -- CCN Project....
******************************************************************************/
/***  below are the fields required for the ROWTYPE call: Table_name, Row_Data, Table_Rowtype ***/
 in_table_name           IN  varchar2 
,in_row_data             IN  varchar2 --sys.xmltype
,OUT_STORE_ROWTYPE       OUT STORE%ROWTYPE
);

PROCEDURE DISPATCH_TERMINAL_ROWTYPE_SP(
    /******************************************************************************/
    --DISPATCH_TERMINAL_ROWTYPE_SP
    --This procedure is convert xml and return rowtype data for DISPATCH_TERMINAL table.
    --created : 04/13/2017 tal CCN Project.... rxa457-asp-763
    /******************************************************************************/
    /***  below are the fields required for the ROWTYPE call: Table_name, Row_Data, Table_Rowtype ***/
    in_table_name IN VARCHAR2,
    in_row_data   IN VARCHAR2, --sys.xmltype
    OUT_DISPATCH_TERMINAL_ROWTYPE OUT DISPATCH_TERMINAL%ROWTYPE);

PROCEDURE TAXWARE_ROWTYPE_SP (
/******************************************************************************
	TAXWARE_ROWTYPE_SP

	This procedure Build a TAXWARE Rowtype ROW

	OracleTableName  -  Table name for row -varible
      xml file     -  the data being inserted
  Taxware_ROWTYPE  -  Taxware Data Row

created : 09/26/2012 TAL -- CCN Project....
******************************************************************************/
/***  below are the fields required for the ROWTYPE call: Table_name, Row_Data, Table_Rowtype ***/
 IN_TABLE_NAME           IN  VARCHAR2 
,in_row_data             IN  varchar2 --sys.xmltype
,OUT_TAXWARE_ROWTYPE   OUT TAXWARE%ROWTYPE
);

PROCEDURE TERMINAL_ROWTYPE_SP (
/******************************************************************************
	TERMINAL_ROWTYPE_SP

	This procedure Build a TERMINAL Rowtype ROW

	OracleTableName  -  Table name for row -varible
      xml file     -  the data being inserted
  Territory_ROWTYPE  -  Territory Data Row

created : 09/26/2012 TAL -- CCN Project....
******************************************************************************/
/***  below are the fields required for the ROWTYPE call: Table_name, Row_Data, Table_Rowtype ***/
 IN_TABLE_NAME           IN  VARCHAR2 
,IN_ROW_DATA             IN  VARCHAR2 --sys.xmltype
,OUT_TERMINAL_ROWTYPE   OUT TERMINAL%ROWTYPE
);

PROCEDURE TERRITORY_ROWTYPE_SP (
/******************************************************************************
	TERRITORY_ROWTYPE_SP

	This procedure Build a TERRITORY Rowtype ROW

	OracleTableName  -  Table name for row -varible
      xml file     -  the data being inserted
  Territory_ROWTYPE  -  Territory Data Row

created : 09/26/2012 TAL -- CCN Project....
changed : 07/17/2014 CCN Project, prod issue : territory vs close date
          Added a paramater to distinguish between business rule validation calls 
          and database update calls
******************************************************************************/
/***  below are the fields required for the ROWTYPE call: Table_name, Row_Data, Table_Rowtype ***/
 IN_TABLE_NAME           IN  VARCHAR2 
,in_row_data             IN  varchar2 --sys.xmltype
,OUT_TERRITORY_ROWTYPE   OUT TERRITORY%ROWTYPE
,in_validation_flag      IN varchar2 DEFAULT 'N'
);

PROCEDURE TYPE_ROWTYPE_SP (
/******************************************************************************
	TYPE_ROWTYPE_SP

	This procedure Build a TYPE Rowtype ROW

	OracleTableName  -  Table name for row -varible
      xml file     -  the data being inserted
  Type_ROWTYPE     -  Type Data Row

created : 09/26/2012 TAL -- CCN Project....
******************************************************************************/
/***  below are the fields required for the ROWTYPE call: Table_name, Row_Data, Table_Rowtype ***/
 in_table_name           IN  varchar2 
,in_row_data             IN  varchar2 --sys.xmltype
,OUT_TYPE_ROWTYPE        OUT TYPE%ROWTYPE
);
   

--TESTING FOR JAVACODE WITH MULTIPLE CURSORS......REMOVE

PROCEDURE TEST_COST_CENTER_S_SP(
/******************************************************************************
	TEST_COST_CENTER_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the cost center table.  

created : 
*******************************************************************************/
 in_COST_CENTER IN COST_CENTER.COST_CENTER_CODE%TYPE
, out_COST_CENTER_REF_CUR OUT REF_CURSOR
, out_STORE_REF_CUR OUT REF_CURSOR);
--TESTING DELETE LATER....

PROCEDURE CC_ADDTL_TABLES_UI_SP ( 
 /******************************************************************************
    CC_ADDTL_TABLES_UI_SP  --   create/update tables
	 impacted by cost center table changes/inserts VIA
   COST_CENTER_UI_UPSERT_SP.
        Procedure

	This procedure is intended to insert/update the database
	 for the following tables when creating/updating the
	 Cost_Center associated tables.
	Tables are as follows: 
            , ADMINISTRATION
            , STORE
            , OTHER
            , REAL_ESTATE
            , TERRITORY
            tables.  

created:   12/13/2012 BLR  CCN Project....
*******************************************************************************/
 
   in_table_name          IN  varchar2   
  ,in_row_data           IN  varchar2  --sys.xmltype
  );
  
PROCEDURE CC_ADDRESS_TABLES_UI_SP ( 
 /******************************************************************************
    CC_ADDRESS_TABLES_UI_SP   --   create/update tables
	 impacted by cost center table changes/inserts via 
   COST_CENTER_UI_UPSERT_SP.
        Procedure

	This procedure will add one address row singular
	for the following tables depending on category type : 
               ADDRESS_USA
            ,  ADDRESS_CAN
            ,  ADDRESS_MEX
            ,  ADDRESS_OTHER
           
            tables.  

created:   12/13/2012 BLR  CCN Project....
*******************************************************************************/
 
 
in_table_name          IN  varchar2 
,in_row_data            IN  varchar2  --sys.xmltype
);  

PROCEDURE ADDRESS_BRB_ROWTYPE_SP(
 /******************************************************************************
This procedure is intended to Insert new Barbados address records

created : 05/16/2016 jxc517 CCN Project Team....
changed : 
*******************************************************************************/
    in_cost_center    IN     ADDRESS_BRB.COST_CENTER_CODE%TYPE,
    in_address_type   IN     ADDRESS_BRB.ADDRESS_TYPE%TYPE,
    in_effective_date IN     ADDRESS_BRB.EFFECTIVE_DATE%TYPE,
    in_table_name     IN     VARCHAR2,
    in_row_date       IN     DATE,
    in_row_data       IN     VARCHAR2,
    out_address_type     OUT ADDRESS_BRB%ROWTYPE);

PROCEDURE ADDRESS_BRB_S_SP(
/*******************************************************************************
This procedure is intended to return a ref cursor with data from ADDRESS_BRB table

created : 05/16/2016 jxc517 CCN Project Team....
changed : 
*******************************************************************************/
    in_cost_center          IN     ADDRESS_BRB.COST_CENTER_CODE%TYPE,
    in_address_type         IN     ADDRESS_BRB.ADDRESS_TYPE%TYPE,
    out_address_brb_ref_cur    OUT REF_CURSOR);

PROCEDURE ADDRESS_BRB_I_SP(
/*******************************************************************************
This procedure is intended to insert new ADDRESS_BRB records

created : 05/16/2016 jxc517 CCN Project Team....
changed : 
*******************************************************************************/
    in_cost_center          IN       ADDRESS_BRB.COST_CENTER_CODE%TYPE,
    in_address_type         IN       ADDRESS_BRB.ADDRESS_TYPE%TYPE,
    in_effective_date       IN       ADDRESS_BRB.EFFECTIVE_DATE%TYPE,
    in_table_name           IN       VARCHAR2,
    in_row_date             IN       DATE,
    in_row_data             IN       VARCHAR2);

PROCEDURE ADDRESS_BRB_U_SP(
/*******************************************************************************
This procedure is intended to Update Barbados address records

created : 05/16/2016 jxc517 CCN Project Team....
changed : 
*******************************************************************************/
    in_cost_center    IN        ADDRESS_BRB.COST_CENTER_CODE%TYPE,
    in_address_type   IN        ADDRESS_BRB.ADDRESS_TYPE%TYPE,
    in_effective_date IN        ADDRESS_BRB.EFFECTIVE_DATE%TYPE,
    in_table_name     IN        VARCHAR2,
    in_row_date       IN        DATE,
    in_row_data       IN        VARCHAR2);
	
PROCEDURE HIERARCHY_TRANSFER_I_SP(
/*******************************************************************************
This procedure is intended to insert new HIERARCHY_TRANSFER_MAIL records
created : 04/19/2017 pxb712 CCN Project Team....
changed :
*******************************************************************************/
IN_HIERARCHY_TRANSFER_ROW IN HIERARCHY_TRANSFER_MAIL%ROWTYPE);

PROCEDURE PCI_TERMINAL_I_SP(
/*******************************************************************************
This procedure is intended to insert new PCI_TERMINAL_MAIL records
created : 04/19/2017 pxb712 CCN Project Team....
changed :
*******************************************************************************/
IN_PCI_TERMINAL_MAIL_ROW IN PCI_TERMINAL_MAIL%ROWTYPE);	
	
PROCEDURE HIERARCHY_ERROR_LOG_U_SP(
/*******************************************************************************
This procedures takes updates the re-run exception flag
after a cost center that errored out is re-run

created : 05/24/2017 sxh487 -- CCN Project Team
*******************************************************************************/
IN_HIERARCHY_DETAIL_ROW IN     HIERARCHY_DETAIL%ROWTYPE);

END CCN_TABLE_IU_PKG;