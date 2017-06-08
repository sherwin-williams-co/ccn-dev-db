create or replace PACKAGE          SD_RECONCILE_DIFF_REPORT_PKG
/**************************************************************** 
The package is used to compare the reconcile the storedrafts data.
      
created : 12/21/2016 MXK766/NXK927 POS XML Conversion
changed : 
*****************************************************************/
AS

FUNCTION GET_DISC_AMT_TYPE
/******************************************************************
This function will return the hexadecimal conversion of the value passed in
based on the transaction type passed in

created : 11/10/2014 jxc517 CCN Project....
changed :
******************************************************************/
(IN_TRAN_GUID        IN   VARCHAR2
,IN_SEQNBR           IN   VARCHAR2
,IN_RUNCYCLE         IN   VARCHAR2
,IN_IND              IN   VARCHAR2) RETURN VARCHAR2;

PROCEDURE SD_MF_FF_DATA_LOAD_SP(
/**************************************************************** 
        This Procedure is used to build the data required for the 
        reconciliation of data for the STOREDRAFTS feed. 
        
created : 12/16/2016 MXK766 CCN PROJECT....
changed : 
*****************************************************************/
IN_DATE DATE);

PROCEDURE LOAD_POS_CCN_ACCUMS(
/****************************************************************************
This procedure is used to load the POSXML store drafts temp table
"POS_CCN_LOAD_STATUS" with data extracted from new interface tables
created : 03/02/2017 nxk927 CCN Project....
changed : 
*****************************************************************************/
IN_DATE     IN DATE);

PROCEDURE LOAD_POS_CSTMR_FORM_OF_PAY(
/****************************************************************************
This procedure is used to load the POSXML store drafts temp table
"POS_CSTMR_FRM_OF_PAY_TMP" with data extracted from new interface tables
created : 06/02/2016 axk326 CCN Project....
changed : Added padding to the TRANNBR Field
*****************************************************************************/
IN_DATE     IN DATE);

PROCEDURE GEN_DELTA_FILES_SP(
/*********************************************************************** 
        This Procedure is Wrapper procedure, which is used to generate
        all difference files in server.
        
created : 12/16/2016 MXK766/NXK927 POS XML Conversion
changed :
************************************************************************/
IN_LOADDATE IN DATE);

PROCEDURE STORE_DRAFTS_DIFF_SP(
/**************************************************************** 
        This Procedure is used compare the legacy Store drafts load and 
        POSXML Store drafts load and creats a Difference file on the server.
        
created : 12/16/2016 MXK766/NXK927 POS XML Conversion
changed :
*****************************************************************/
IN_DATE IN DATE);

PROCEDURE STORE_DRAFT_INSTLR_DIFF_SP(
/**************************************************************** 
        This Procedure is used compare the legacy Store drafts Installer lines details load 
        and the POSXML Store drafts Installer lines details load and creats a Difference file.
        
created : 12/16/2016 MXK766/NXK927 POS XML Conversion
changed :
*****************************************************************/
IN_DATE IN DATE);

PROCEDURE STORE_DRAFT_DISBRSMT_DIFF_SP(
/**************************************************************** 
        This Procedure is used compare the legacy Store drafts disbusement load 
        and the POSXML Store drafts disbusement load and creats a Difference file.
        
created : 12/16/2016 MXK766/NXK927 POS XML Conversion
changed :
*****************************************************************/
IN_DATE IN DATE);

PROCEDURE CUSTOMER_DIFF_SP(
/**************************************************************** 
        This Procedure is used compare the legacy customer load 
        and the POSXML customer load and creats a Difference file.
        
created : 12/16/2016 MXK766/NXK927 POS XML Conversion
changed :
*****************************************************************/
IN_DATE IN DATE);

PROCEDURE CSTMR_DETAILS_DIFF_SP(
/*********************************************************************** 
        This Procedure is used compare the legacy customer details load 
        and the POSXML customer details load and creats a Difference file.
        
created : 12/16/2016 MXK766/NXK927 POS XML Conversion
changed :
************************************************************************/
IN_DATE IN DATE);

PROCEDURE LOAD_ISSUE_CHANGE_DATA_SP(
/**************************************************************** 
        This Procedure is used to LOAD LOAD_POS_ISSUE_CHANGE_SP
        
created : 12/21/2016 nxk927
changed : 
*****************************************************************/
IN_DATE IN DATE);

PROCEDURE LOAD_INSR_LNITEM_RCNCL_DATA_SP(
/**************************************************************** 
        This Procedure is used to LOAD LOAD_POS_ISSUE_CHANGE_SP
        
created :
changed : 
*****************************************************************/
IN_DATE IN DATE);

PROCEDURE LOAD_DISBRSMT_LNITEM_DATA_SP(
/**************************************************************** 
        This Procedure is used to LOAD LOAD_POS_ISSUE_CHANGE_SP
        
created :
changed : 
*****************************************************************/
IN_DATE IN DATE);

PROCEDURE LOAD_CUSTOMER_DATA_SP(
/**************************************************************** 
        This Procedure is used to LOAD LOAD_POS_ISSUE_CHANGE_SP
        
created :
changed : 
*****************************************************************/
IN_DATE IN DATE);

PROCEDURE LOAD_CUSTOMER_DTLS_DATA_SP(
/**************************************************************** 
        This Procedure is used to LOAD LOAD_POS_ISSUE_CHANGE_SP
        
created :
changed : 
*****************************************************************/
IN_DATE IN DATE)
;

PROCEDURE LOAD_CSTMR_LINE_ITEM_DATA_SP(
/**************************************************************** 
        This Procedure is used to LOAD LOAD_POS_ISSUE_CHANGE_SP
        
created :
changed : 
*****************************************************************/
IN_DATE IN DATE);


PROCEDURE LOAD_CSTMR_SALES_TAX_DATA_SP(
/**************************************************************** 
        This Procedure is used to LOAD LOAD_POS_ISSUE_CHANGE_SP
        
created :
changed : 
*****************************************************************/
IN_DATE IN DATE);

PROCEDURE LOAD_CSTMR_FORM_OF_PAY_SP(
/**************************************************************** 
        This Procedure is used to LOAD LOAD_POS_ISSUE_CHANGE_SP
        
created :
changed : 
*****************************************************************/
IN_DATE IN DATE);

PROCEDURE LOAD_CSTMR_BANK_CARD_SP(
/**************************************************************** 
        This Procedure is used to LOAD LOAD_POS_ISSUE_CHANGE_SP
        
created :
changed : 
*****************************************************************/
IN_DATE IN DATE);

PROCEDURE LOAD_BANK_PAID_DATA_SP(
/**************************************************************** 
        This Procedure is used to LOAD LOAD_POS_ISSUE_CHANGE_SP
        
created :
changed : 
*****************************************************************/
IN_DATE IN DATE);

PROCEDURE CSTMR_LINE_ITEM_DIFF_SP(
/*********************************************************************** 
        This Procedure is used compare the legacy customer Line details load 
        and the POSXML customer Line details load and creats a Difference file.
        
created : 12/16/2016 MXK766/NXK927 POS XML Conversion
changed :
************************************************************************/
IN_DATE IN DATE);

PROCEDURE CSTMR_SALES_TAX_DIFF_SP(
/*********************************************************************** 
        This Procedure is used compare the legacy customer sales tax load 
        and the POSXML customer sales tax load and creats a Difference file.
        
created : 12/16/2016 MXK766/NXK927 POS XML Conversion
changed :
************************************************************************/
IN_DATE IN DATE);

PROCEDURE CSTMR_FORM_OF_PAY_DIFF_SP(
/*********************************************************************** 
        This Procedure is used compare the legacy customer form of pay load 
        and the POSXML customer form of pay load and creats a Difference file.
        
created : 12/16/2016 MXK766/NXK927 POS XML Conversion
changed :
************************************************************************/
IN_DATE IN DATE);

PROCEDURE CSTMR_BANK_CARD_DIFF_SP(
/*********************************************************************** 
        This Procedure is used compare the legacy customer bank card load 
        and the POSXML customer bank card load and creats a Difference file.
        
created : 12/16/2016 MXK766/NXK927 POS XML Conversion
changed :
************************************************************************/
IN_DATE IN DATE);

PROCEDURE BANK_PAID_DATA_DIFF_SP(
/*********************************************************************** 
        This Procedure is used compare the legacy customer bank paid data load 
        and the POSXML customer bank paid data load and creats a Difference file.
        
created : 12/16/2016 MXK766/NXK927 POS XML Conversion
changed :  
************************************************************************/
IN_DATE IN DATE); 

FUNCTION RETURN_SUMMARY_STRING(
/**************************************************************** 
The function is used to return the summary data for the given tablename and date.

created : 12/21/2016 MXK766/NXK927
changed : 
*****************************************************************/
    IN_TABLE_NAME      IN VARCHAR2, 
    IN_DATE            IN DATE,
    IN_UNMATCHED_COUNT IN NUMBER,
    IN_ORPHAN_COUNT    IN NUMBER) RETURN VARCHAR2;
    
END SD_RECONCILE_DIFF_REPORT_PKG;