package TEST_CCN_UI_INTERFACE_TEST_PKG
    as
-- PACKAGE SPEC
/****************************************************************************** 
This package is intended will return data for the cost_center table

created : 09/18/2012 TAL -- CCN coding project
changed : 
******************************************************************************/
	 	TYPE REF_CURSOR IS REF CURSOR;
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


  PROCEDURE ADDRESS_UI_SP ( inCost_center in COST_CENTER.cost_center_code%type
                           ,inCountry_code in COST_CENTER.country_code%type
                           ,inAddressType	in ADDRESS_USA.address_type%type DEFAULT NULL                                                 
                           ,out_ADDRESS_REF_CUR out sys_refcursor)
/*******************************************************************************
	ADDRESS_UI_SP

	This procedure is intended to return a ref cursor with data from 
	from the ADDRESS_USA,or ADDRESS_MEX or ADDRESS_CAN or ADDRESS_OTHER table.  

created :  09/05/2012 BLR CCN UI Project....
*******************************************************************************/
;


  PROCEDURE COST_CENTER_UI_SP ( IN_Cost_center in COST_CENTER.cost_center_code%type
                 , OUT_COST_CENTER_REF_CUR  out sys_refcursor      
 	               , OUT_CC_CATEGORY_REF_CUR  out sys_refcursor         
                 , OUT_STATUS_REF_CUR       out sys_refcursor         
                 , OUT_TYPE_REF_CUR         out sys_refcursor        
                 , OUT_MARKETING_REF_CUR    out sys_refcursor        
                 , OUT_TAXWARE_REF_CUR      out sys_refcursor          
                 , OUT_PHONE_REF_CUR        out sys_refcursor          
                 , OUT_ADDRESS_REF_CUR      out sys_refcursor)                           
 /******************************************************************************
	COST_CENTER_UI_SP   --    Cost Center User Interface Procedure

	This procedure is intended to return a ref cursor with data from 
	from the COST_CENTER, ADMINISTRATION, STORE, OTHER, REAL_ESTATE, TERRITORY,
  STATUS, TYPE, MARKETING, PHONE, TAXWARE, and ADDRESS tables.  

created : 09/06/2012 MDH CCN Project....
*******************************************************************************/
;

PROCEDURE POLLING_UI_SP (
/*******************************************************************************
	POLLING_UI_SP   --    Polling User Interface Stored Procedure

	This procedure is intended to return a ref cursor with data from 
	from the POLLING, BANK_CARD, and TERMINAL tables.  

created : 09/05/2012 TAL CCN Project....
*******************************************************************************/
            in_cost_center            in  polling.cost_center_code%type
 					, in_polling_status_code    in  polling.polling_status_code%type
          , in_merchant_id_code       in  bank_card.merchant_id%type
          , in_terminal_number        in  terminal.terminal_number%type
          , in_effective_date         in  bank_card.effective_date%type   
					, out_polling_refcur        out sys_refcursor
 					, out_bank_card_refcur      out sys_refcursor
			    , OUT_TERMINAL_REFCUR       OUT SYS_REFCURSOR
          );  
          

end TEST_CCN_UI_INTERFACE_TEST_PKG;
/

