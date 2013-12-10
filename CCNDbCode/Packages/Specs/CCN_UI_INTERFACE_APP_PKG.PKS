CREATE OR REPLACE package CCN_UI_INTERFACE_APP_PKG
    as
-- PACKAGE SPEC
/****************************************************************************** 
This package is intended will return data for the cost_center table

created : 09/18/2012 TAL -- CCN coding project
changed : 09/21/2012 TAL -- Split into Table_UI and Interface_UI
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


PROCEDURE SECURITY_S_SP(
/******************************************************************************
	SECURITY_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the SECURITY table.  

created : 
*******************************************************************************/
in_user_id IN SECURITY_MATRIX.USER_ID%TYPE 
,out_USER_REF_CUR OUT REF_CURSOR);

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
					, out_polling_refcur        out sys_refcursor
 					, out_bank_card_refcur      out sys_refcursor
			    , OUT_TERMINAL_REFCUR       OUT SYS_REFCURSOR
          );   
          

PROCEDURE ADDRESS_UI_UPSERT_SP (
/*******************************************************************************
	ADDRESS_UI_UPSERT_SP   --    ADDRESS User Interface Update/Insert Procedure

	This procedure is intended to update the database for the following tables 
       used in the Address UI.

	Tables: 
            ADDRESS_CAN, 
            ADDRESS_USA, 
            ADDRESS_MEX, 
            ADDRESS_OTHER
  
created : 12/12/2012 TAL CCN Project....
revised :
*******************************************************************************/
 					in_row_data                in  varchar2 
          );  
          

PROCEDURE POLLING_UI_UPSERT_SP (
/*******************************************************************************
	POLLING_UI_UPSERT_SP   --    POLLING User Interface Update/Insert Procedure

	This procedure is intended to update the database for the following tables 
       used in the Polling UI.

	Tables: 
            POLLING
          , BANK_CARD
          , TERMINAL
  
created : 11/09/2012 MDH CCN Project....
revised :
*******************************************************************************/
 					in_row_data                in  varchar2 
          );  
          
PROCEDURE COST_CENTER_UI_UPSERT_SP ( 
 /******************************************************************************
	COST_CENTER_UI_UPSERT_SP   --    Cost Center User Interface Update delete
        Procedure

	This procedure is intended to update the database for the following tables used in
        Cost Center UI.
	Tables: 
              COST_CENTER
           ,  ADMINISTRATION, STORE, OTHER, REAL_ESTATE, TERRITORY,
            , STATUS
            , TYPE
            , MARKETING
            , PHONE
            , TAXWARE
            , ADDRESS tables.  

created : 10/26/2012 KDP CCN Project....
revised:   12/03/2012 BLR  CCN Project....
*******************************************************************************/

 in_row_data  in varchar2);
 
 PROCEDURE VALIDATE_BUSINESS_RULES(
 /******************************************************************************
	VALIDATE_BUSINESS_RULES   --    User Interface Update delete business rules validator

	This procedure is intended to validate the business rules based on the flag sent using
  the input XML fragment.

created : 08/26/2013 CCN Project....
*******************************************************************************/
IN_FLAG      IN VARCHAR2,
IN_ROW_DATA  IN VARCHAR2);

FUNCTION TERMINAL_NUMBER_S
/*********************************************************************
TERMINAL_NUMBER_S
This function will return the next terminal number from the sequence 
terminal_number_seq
*************************************************************************/

RETURN NUMBER ;

end CCN_UI_INTERFACE_APP_PKG;

