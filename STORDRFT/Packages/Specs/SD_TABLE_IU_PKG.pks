create or replace PACKAGE          SD_TABLE_IU_PKG 
AS
/**********************************************************
	SD_TABLE_IU_PKG

	This Package is intended to process the DMLs and DRLs on all the
  tables related to stare draft

created : 04/30/2013 jxc517 CCN Project....
changed :
**********************************************************/

TYPE REF_CURSOR IS REF CURSOR;

---------------------------ROWTYPE PROCEDURES---------------------------
PROCEDURE CUSTOMER_SALES_TAX_ROWTYPE_SP (
/*******************************************************************************
	CUSTOMER_SALES_TAX_ROWTYPE_SP

	This procedure is intended to build the CUSTOMER_SALES_TAX record type

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME  IN     VARCHAR2
,IN_ROW_DATA   IN     CLOB
,OUT_ROW_TYPE     OUT CUSTOMER_SALES_TAX%ROWTYPE);

PROCEDURE CUSTOMER_FOP_ROWTYPE_SP (
/*******************************************************************************
	CUSTOMER_FOP_ROWTYPE_SP

	This procedure is intended to build the CUSTOMER_FORM_OF_PAY record type

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME  IN     VARCHAR2
,IN_ROW_DATA   IN     CLOB
,OUT_ROW_TYPE     OUT CUSTOMER_FORM_OF_PAY%ROWTYPE);

PROCEDURE CUSTOMER_BANK_CARD_ROWTYPE_SP (
/*******************************************************************************
	CUSTOMER_BANK_CARD_ROWTYPE_SP

	This procedure is intended to build the CUSTOMER_BANK_CARD record type

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME  IN     VARCHAR2
,IN_ROW_DATA   IN     CLOB
,OUT_ROW_TYPE     OUT CUSTOMER_BANK_CARD%ROWTYPE);


PROCEDURE CUSTOMER_DETAILS_ROWTYPE_SP (
/*******************************************************************************
	CUSTOMER_DETAILS_ROWTYPE_SP

	This procedure is intended to build the CUSTOMER_DETAILS record type

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME  IN     VARCHAR2
,IN_ROW_DATA   IN     CLOB
,OUT_ROW_TYPE     OUT CUSTOMER_DETAILS%ROWTYPE);

PROCEDURE CUSTOMER_ROWTYPE_SP (
/*******************************************************************************
	CUSTOMER_ROWTYPE_SP

	This procedure is intended to build the CUSTOMER record type

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME  IN     VARCHAR2
,IN_ROW_DATA   IN     CLOB
,OUT_ROW_TYPE     OUT CUSTOMER%ROWTYPE);

PROCEDURE STORE_DRAFTS_DETAIL_ROWTYPE_SP (
/*******************************************************************************
	STORE_DRAFTS_DETAIL_ROWTYPE_SP

	This procedure is intended to build the STORE_DRAFTS_DETAIL record type

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME  IN     VARCHAR2
,IN_ROW_DATA   IN     CLOB
,OUT_ROW_TYPE     OUT STORE_DRAFTS_DETAIL%ROWTYPE);

PROCEDURE STORE_DRAFTS_ROWTYPE_SP (
/*******************************************************************************
	STORE_DRAFTS_ROWTYPE_SP

	This procedure is intended to build the STORE_DRAFTS record type

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME  IN     VARCHAR2
,IN_ROW_DATA   IN     CLOB
,OUT_ROW_TYPE     OUT STORE_DRAFTS%ROWTYPE);

PROCEDURE UNATHED_MNL_D_DTL_ROWTYPE_SP (
/*******************************************************************************
	UNATTACHED_MNL_DRFT_DTL_ROWTYPE_SP

	This procedure is intended to build the UNATTACHED_MNL_DRFT_DTL record type

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME  IN     VARCHAR2
,IN_ROW_DATA   IN     CLOB
,OUT_ROW_TYPE     OUT UNATTACHED_MNL_DRFT_DTL%ROWTYPE);

PROCEDURE HST_STORE_DRAFTS_ROWTYPE_SP (
/*******************************************************************************
	HST_STORE_DRAFTS_ROWTYPE_SP

	This procedure is intended to build the HST_STORE_DRAFTS record type

Created : 09/16/2014 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME  IN     VARCHAR2
,IN_ROW_DATA   IN     CLOB
,OUT_ROW_TYPE     OUT HST_STORE_DRAFTS%ROWTYPE);

PROCEDURE HST_STR_DRFTS_DTL_ROWTYPE_SP (
/*******************************************************************************
	HST_STR_DRFTS_DTL_ROWTYPE_SP

	This procedure is intended to build the HST_STORE_DRAFTS_DETAIL record type

Created : 09/16/2014 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME  IN     VARCHAR2
,IN_ROW_DATA   IN     CLOB
,OUT_ROW_TYPE     OUT HST_STORE_DRAFTS_DETAIL%ROWTYPE);
---------------------------SELECT PROCEDURES---------------------------
PROCEDURE CUSTOMER_SALES_TAX_S_SP (
/*******************************************************************************
	CUSTOMER_SALES_TAX_S_SP

	This procedure is intended to select records from CUSTOMER_SALES_TAX table

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);


PROCEDURE CUSTOMER_S_SP (
/*******************************************************************************
	CUSTOMER_S_SP

	This procedure is intended to select records from CUSTOMER table

Created : 05/21/2014 nxk927 CCN Project....
Changed : 06/16/2014 AXK326/SXT410 Added new filters(Transaction data filter tag
          and Issue date filter tag).
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);


PROCEDURE CUSTOMER_FORM_OF_PAY_S_SP (
/*******************************************************************************
	CUSTOMER_FORM_OF_PAY_S_SP

	This procedure is intended to select records from CUSTOMER_FORM_OF_PAY table

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);

PROCEDURE CUSTOMER_BANK_CARD_S_SP (
/*******************************************************************************
	CUSTOMER_BANK_CARD_S_SP

	This procedure is intended to select records from CUSTOMER_BANK_CARD table

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);

PROCEDURE STORE_DRAFTS_DETAIL_S_SP (
/*******************************************************************************
	STORE_DRAFTS_DETAIL_S_SP

	This procedure is intended to select records from STORE_DRAFTS_DETAIL table

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);

PROCEDURE CUSTOMER_DETAILS_S_SP (
/*******************************************************************************
	CUSTOMER_DETAILS_S_SP

	This procedure is intended to select records from CUSTOMER_DETAILS table

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);


PROCEDURE STORE_DRAFTS_S_SP (
/*******************************************************************************
	STORE_DRAFTS_S_SP

	This procedure is intended to select records from STORE_DRAFTS table

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);

PROCEDURE UNATTACHED_MNL_DRFT_DTL_S_SP (
/*******************************************************************************
	UNATTACHED_MNL_DRFT_DTL_S_SP

	This procedure is intended to select records from UNATTACHED_MNL_DRFT_DTL table

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);

PROCEDURE HST_STORE_DRAFTS_S_SP (
/*******************************************************************************
	HST_STORE_DRAFTS_S_SP

	This procedure is intended to select records from HST_STORE_DRAFTS table

Created : 09/16/2014 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);

PROCEDURE HST_STORE_DRAFTS_DETAIL_S_SP (
/*******************************************************************************
	HST_STORE_DRAFTS_DETAIL_S_SP

	This procedure is intended to select records from HST_STORE_DRAFTS_DETAIL table

Created : 09/16/2014 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);
---------------------------UPDATE PROCEDURES---------------------------

PROCEDURE STORE_DRAFTS_DETAIL_U_SP (
/*******************************************************************************
	STORE_DRAFTS_DETAIL_U_SP

	This procedure is intended to updates records in STORE_DRAFTS_DETAIL table

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB);

PROCEDURE CUSTOMER_BANK_CARD_U_SP (
/*******************************************************************************
	CUSTOMER_BANK_CARD_U_SP

	This procedure is intended to updates records in CUSTOMER_BANK_CARD table

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB);

PROCEDURE CUSTOMER_SALES_TAX_U_SP (
/*******************************************************************************
	CUSTOMER_SALES_TAX_U_SP

	This procedure is intended to updates records in CUSTOMER_SALES_TAX table

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB);

PROCEDURE CUSTOMER_FORM_OF_PAY_U_SP (
/*******************************************************************************
	CUSTOMER_FORM_OF_PAY_U_SP

	This procedure is intended to updates records in CUSTOMER_FORM_OF_PAY table

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB);


PROCEDURE CUSTOMER_DETAILS_U_SP (
/*******************************************************************************
	CUSTOMER_DETAILS_U_SP

	This procedure is intended to updates records in CUSTOMER_DETAILS table

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB);

PROCEDURE CUSTOMER_U_SP (
/*******************************************************************************
	CUSTOMER_U_SP

	This procedure is intended to updates records in CUSTOMER table

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB);

PROCEDURE STORE_DRAFTS_U_SP (
/*******************************************************************************
	STORE_DRAFTS_U_SP

	This procedure is intended to updates records in STORE_DRAFTS table

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB);


PROCEDURE UNATTACHED_MNL_DRFT_DTL_U_SP (
/*******************************************************************************
	UNATTACHED_MNL_DRFT_DTL_U_SP

	This procedure is intended to updates records in UNATTACHED_MNL_DRFT_DTL table

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB);



---------------------------INSERT PROCEDURES---------------------------
PROCEDURE CUSTOMER_FORM_OF_PAY_I_SP (
/*******************************************************************************
	CUSTOMER_FORM_OF_PAY_I_SP

	This procedure is intended to insert records into CUSTOMER_FORM_OF_PAY table

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB);

PROCEDURE CUSTOMER_BANK_CARD_I_SP (
/*******************************************************************************
	CUSTOMER_BANK_CARD_I_SP

	This procedure is intended to insert records into CUSTOMER_BANK_CARD table

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB);

PROCEDURE CUSTOMER_SALES_TAX_I_SP (
/*******************************************************************************
	CUSTOMER_SALES_TAX_I_SP

	This procedure is intended to insert records into CUSTOMER_SALES_TAX table

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB);

PROCEDURE STORE_DRAFTS_DETAIL_I_SP (
/*******************************************************************************
	STORE_DRAFTS_DETAIL_I_SP

	This procedure is intended to insert records into STORE_DRAFTS_DETAIL table

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB);

PROCEDURE CUSTOMER_DETAILS_I_SP (
/*******************************************************************************
	CUSTOMER_DETAILS_I_SP

	This procedure is intended to insert records into CUSTOMER_DETAILS table

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB);


PROCEDURE CUSTOMER_I_SP (
/*******************************************************************************
	CUSTOMER_I_SP

	This procedure is intended to insert records into CUSTOMER table

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB);


PROCEDURE STORE_DRAFTS_I_SP (
/*******************************************************************************
	STORE_DRAFTS_I_SP

	This procedure is intended to insert records into STORE_DRAFTS table

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB);


PROCEDURE UNATTACHED_MNL_DRFT_DTL_I_SP (
/*******************************************************************************
	UNATTACHED_MNL_DRFT_DTL_I_SP

	This procedure is intended to insert records into UNATTACHED_MNL_DRFT_DTL table

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB);


---------------------------DELETE PROCEDURES---------------------------

PROCEDURE CUSTOMER_SALES_TAX_D_SP (
/*******************************************************************************
	CUSTOMER_SALES_TAX_D_SP

	This procedure is intended to delete records from CUSTOMER_SALES_TAX table

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB);


PROCEDURE STORE_DRAFTS_DETAIL_D_SP (
/*******************************************************************************
	STORE_DRAFTS_DETAIL_D_SP

	This procedure is intended to delete records from STORE_DRAFTS_DETAIL table

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB);

PROCEDURE CUSTOMER_FORM_OF_PAY_D_SP (
/*******************************************************************************
	CUSTOMER_FORM_OF_PAY_D_SP

	This procedure is intended to delete records from CUSTOMER_FORM_OF_PAY table

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB);

PROCEDURE CUSTOMER_BANK_CARD_D_SP (
/*******************************************************************************
	CUSTOMER_BANK_CARD_D_SP

	This procedure is intended to delete records from CUSTOMER_BANK_CARD table

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB);

PROCEDURE STORE_DRAFTS_D_SP (
/*******************************************************************************
	STORE_DRAFTS_D_SP

	This procedure is intended to delete records from STORE_DRAFTS table

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB);


PROCEDURE CUSTOMER_D_SP (
/*******************************************************************************
	CUSTOMER_D_SP

	This procedure is intended to delete records from CUSTOMER table

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB);

PROCEDURE CUSTOMER_DETAILS_D_SP (
/*******************************************************************************
	CUSTOMER_DETAILS_D_SP

	This procedure is intended to delete records from CUSTOMER_DETAILS table

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB);

PROCEDURE UNATTACHED_MNL_DRFT_DTL_D_SP (
/*******************************************************************************
	UNATTACHED_MNL_DRFT_DTL_D_SP

	This procedure is intended to delete records from UNATTACHED_MNL_DRFT_DTL table

Created : 05/21/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB);


END SD_TABLE_IU_PKG;

