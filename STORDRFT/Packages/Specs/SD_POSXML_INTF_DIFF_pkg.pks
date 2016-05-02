create or replace PACKAGE SD_POSXML_INTF_DIFF_pkg
/**************************************************************** 
      This package is used to Compare the Legacy Flat file data load and 
      the POSXML table driven data load and get the Differance files created.
          
created : 04/14/2016 AXD783 POS XML Conversion
changed :
*****************************************************************/
AS

FUNCTION Get_Filepath_fnc RETURN VARCHAR2
/**************************************************************** 
          This Function is used to get the UTL_FILE path for the 
          Current user.

created : 04/14/2016 AXD783 POS XML Conversion
changed :
*****************************************************************/
;

PROCEDURE GEN_DELTA_FILES_sp
/*********************************************************************** 
        This Procedure is Wrapper procedure, which is used to generate
        all difference files in server.
        
created : 04/14/2016 AXD783 POS XML Conversion
changed :
************************************************************************/

;

PROCEDURE STORE_DRAFTS_DIFF_sp
/**************************************************************** 
        This Procedure is used compare the legacy Store drafts load and 
        POSXML Store drafts load and creats a Difference file on the server.
        
created : 04/14/2016 AXD783 POS XML Conversion
changed :
*****************************************************************/
;

PROCEDURE STORE_DRAFT_INSTLR_DIFF_sp
/**************************************************************** 
        This Procedure is used compare the legacy Store drafts Installer lines details load 
        and the POSXML Store drafts Installer lines details load and creats a Difference file.
        
created : 04/14/2016 AXD783 POS XML Conversion
changed :
*****************************************************************/
;

PROCEDURE STORE_DRAFT_DISBRSMT_DIFF_sp
/**************************************************************** 
        This Procedure is used compare the legacy Store drafts disbusement load 
        and the POSXML Store drafts disbusement load and creats a Difference file.
        
created : 04/14/2016 AXD783 POS XML Conversion
changed :
*****************************************************************/
;

PROCEDURE CUSTOMER_DIFF_sp
/**************************************************************** 
        This Procedure is used compare the legacy customer load 
        and the POSXML customer load and creats a Difference file.
        
created : 04/14/2016 AXD783 POS XML Conversion
changed :
*****************************************************************/
;

PROCEDURE CSTMR_DETAILS_DIFF_sp
/*********************************************************************** 
        This Procedure is used compare the legacy customer details load 
        and the POSXML customer details load and creats a Difference file.
        
created : 04/14/2016 AXD783 POS XML Conversion
changed :
************************************************************************/
;

PROCEDURE CSTMR_LINE_ITEM_DIFF_sp
/*********************************************************************** 
        This Procedure is used compare the legacy customer Line details load 
        and the POSXML customer Line details load and creats a Difference file.
        
created : 04/14/2016 AXD783 POS XML Conversion
changed :
************************************************************************/
;

PROCEDURE CSTMR_SALES_TAX_DIFF_sp
/*********************************************************************** 
        This Procedure is used compare the legacy customer sales tax load 
        and the POSXML customer sales tax load and creats a Difference file.
        
created : 04/14/2016 AXD783 POS XML Conversion
changed :
************************************************************************/
;

PROCEDURE CSTMR_FORM_OF_PAY_DIFF_sp
/*********************************************************************** 
        This Procedure is used compare the legacy customer form of pay load 
        and the POSXML customer form of pay load and creats a Difference file.
        
created : 04/14/2016 AXD783 POS XML Conversion
changed :
************************************************************************/
;

PROCEDURE CSTMR_BANK_CARD_DIFF_sp
/*********************************************************************** 
        This Procedure is used compare the legacy customer bank card load 
        and the POSXML customer bank card load and creats a Difference file.
        
created : 04/14/2016 AXD783 POS XML Conversion
changed :
************************************************************************/
;

PROCEDURE BANK_PAID_DATA_DIFF_sp
/*********************************************************************** 
        This Procedure is used compare the legacy customer bank paid data load 
        and the POSXML customer bank paid data load and creats a Difference file.
        
created : 04/14/2016 AXD783 POS XML Conversion
changed :
************************************************************************/
;

END SD_POSXML_INTF_DIFF_pkg;