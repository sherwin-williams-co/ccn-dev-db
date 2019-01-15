create or replace PACKAGE TABLE_IU_PKG
   AS
-- package spec
/******************************************************************************
This package is intended to control access to the core customer_deposit_details table.

created  : 02/27/2018 sxh487 -- ccn coding project
Modified : 01/15/2019 pxa852 CCN Project Team...
           Removed following process from this package
           customer deposit detail update process
           customer deposit detail history records creation process
           Customer deposit credit details insert process
           Customer deposit redemption detail insert process
*******************************************************************************/
TYPE ref_cursor IS REF CURSOR;
TYPE CUST_DETAILS_TAB_TYPE IS TABLE OF CUSTOMER_DEPOSIT_DETAILS%ROWTYPE INDEX BY BINARY_INTEGER;

PROCEDURE CUSTOMER_DEPOSIT_HDR_S_SP (
/*******************************************************************************
	CUSTOMER_DEPOSIT_HDR_S_SP

	This procedure is intended to select records from CUSTOMER_DEPOSIT table
    
Created : 03/06/2018 sxh487 CCN Project....
*******************************************************************************/
    IN_CUSTOMER_ACCOUNT_NUMBER   IN     CUSTOMER_DEPOSIT_HEADER.CUSTOMER_ACCOUNT_NUMBER%TYPE,
       OUT_REF_CUR                  OUT REF_CURSOR);

PROCEDURE CUST_DEP_DETAILS_S_SP (
/*******************************************************************************
	CUST_DEP_DETAILS_S_SP

This procedure is intended to select records from CUSTOMER_DEPOSIT_DETAILS table
Created : 01/16/2018 sxh487 CCN Project....
*******************************************************************************/
    IN_CUSTOMER_ACCOUNT_NUMBER   IN     CUSTOMER_DEPOSIT_DETAILS.CUSTOMER_ACCOUNT_NUMBER%TYPE,
    IN_TABLE_NAME                IN     VARCHAR2,
    IN_ROW_DATA                  IN     CLOB,
       OUT_REF_CUR                  OUT REF_CURSOR);

PROCEDURE CUST_DEPOSIT_HDR_ROWTYPE_SP(
/******************************************************************************
CUST_DEPOSIT_HDR_ROWTYPE_SP

This procedure is intended to build the customer_deposit_details record type
created : 01/16/2018 sxh487 ccn project....
changed : 
*******************************************************************************/
    IN_TABLE_NAME                     IN     VARCHAR2,
    IN_ROW_DATA                       IN     VARCHAR2,
       OUT_CUSTOMER_DEPOSIT_HDR_TYPE     OUT CUSTOMER_DEPOSIT_HEADER%ROWTYPE);
   
PROCEDURE CUST_DEP_DETAILS_ROWTYPE_SP(
/******************************************************************************
CUST_CUST_DEP_DETAILS_ROWTYPE_SP

This procedure is intended to build the customer_deposit_details record type
created : 01/16/2018 sxh487 ccn project....
changed :

*******************************************************************************/
    IN_TABLE_NAME                 IN     VARCHAR2,
    IN_ROW_DATA                   IN     VARCHAR2,
       OUT_CUST_DEP_DET_TYPE         OUT CUSTOMER_DEPOSIT_DETAILS%ROWTYPE);

PROCEDURE CUST_DEPOSIT_HEADER_U_SP (
/*******************************************************************************
    This procedure is intended to updates records in CUST_DEP_CREDIT_DETAILS table

Created : 04/23/2018 sxh487
Changed : 
*******************************************************************************/
    IN_ROW IN     CUSTOMER_DEPOSIT_HEADER%ROWTYPE);

PROCEDURE CUST_DEPOSIT_HDR_HIST_I_SP (
/*******************************************************************************
    This procedure is intended to insert records into CUSTOMER_DEPOSIT_HEADER_HST table

Created : 04/23/2018 sxh487 CCN Project....
Changed : 
*******************************************************************************/
    IN_ROW     IN     CUSTOMER_DEPOSIT_HEADER_HST%ROWTYPE);

PROCEDURE CUST_DEPOSIT_HEADER_I_SP(
/*******************************************************************************
CUST_DEPOSIT_HEADER_I_SP

This procedure is intended to insert into  CUSTOMER_DEPOSIT_HEADER
created : 02/27/2018 SXH487 -- ccn project
changed :

*******************************************************************************/
    IN_ROW   IN     CUSTOMER_DEPOSIT_HEADER%ROWTYPE
);

PROCEDURE CUST_DEPOSIT_CRD_RED_I_SP(
/*******************************************************************************
CUST_DEPOSIT_CRD_RED_I_SP

This procedure is intended to insert new customer_deposit_details records
created : 01/11/2019 SXH487 -- ccn project
changed :

*******************************************************************************/
    IN_CUST_DEP_CRD_RED_DET_rec   IN     CUST_DEP_CRD_RED_DETAILS%ROWTYPE);

PROCEDURE CUST_DEP_DET_I_SP(
/*******************************************************************************
CUST_DEP_DET_I_SP

This procedure is intended to insert new customer_deposit_details records
created : 02/27/2018 SXH487 -- ccn project
changed :

*******************************************************************************/
    IN_CUST_DEPOSIT_DETAILS_rec   IN     CUSTOMER_DEPOSIT_DETAILS%ROWTYPE
);

END TABLE_IU_PKG;