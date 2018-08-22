create or replace PACKAGE TABLE_IU_PKG
   AS
-- package spec
/******************************************************************************
This package is intended to control access to the core customer_deposit_details table.

created : 09/08/2017 sxp130 -- ccn coding project
*******************************************************************************/
TYPE ref_cursor IS REF CURSOR;

PROCEDURE CUSTOMER_DEPOSIT_ROWTYPE_SP(
/******************************************************************************
CUSTOMER_DEPOSIT_ROWTYPE_SP

This procedure is intended to build the customer_deposit_details record type
created : 01/16/2018 sxh487 ccn project....
changed :

*******************************************************************************/
   IN_TABLE_NAME                 IN     VARCHAR2,
   IN_ROW_DATA                   IN     VARCHAR2,
   OUT_CUSTOMER_DEPOSIT_TYPE         OUT    CUSTOMER_DEPOSIT%ROWTYPE);

PROCEDURE CUST_DEPOSIT_HDR_ROWTYPE_SP(
/******************************************************************************
CUST_DEPOSIT_HDR_ROWTYPE_SP

This procedure is intended to build the customer_deposit_details record type
created : 01/16/2018 sxh487 ccn project....
changed : 
*******************************************************************************/
   IN_TABLE_NAME                     IN     VARCHAR2,
   IN_ROW_DATA                       IN     VARCHAR2,
   OUT_CUSTOMER_DEPOSIT_HDR_TYPE     OUT    CUSTOMER_DEPOSIT_HEADER%ROWTYPE);
   
PROCEDURE CUST_DEP_DETAILS_ROWTYPE_SP(
/******************************************************************************
CUST_CUST_DEP_DETAILS_ROWTYPE_SP

This procedure is intended to build the customer_deposit_details record type
created : 01/16/2018 sxh487 ccn project....
changed :

*******************************************************************************/
   IN_TABLE_NAME                 IN     VARCHAR2,
   IN_ROW_DATA                   IN     VARCHAR2,
   OUT_CUST_DEP_DET_TYPE         OUT    CUSTOMER_DEPOSIT_DETAILS%ROWTYPE);

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

PROCEDURE CUST_DEPOSIT_CREDIT_I_SP(
/*******************************************************************************
CUST_DEPOSIT_CREDIT_I_SP

This procedure is intended to insert into  CUST_DEP_CREDIT_DETAILS
created : 02/27/2018 SXH487 -- ccn project
changed :

*******************************************************************************/
IN_CUST_DEP_CREDIT_rec   IN     CUST_DEP_CREDIT_DETAILS%ROWTYPE
);

PROCEDURE CUST_DEPOSIT_REDEMPTION_I_SP(
/*******************************************************************************
CUST_DEPOSIT_REDEMPTION_I_SP

This procedure is intended to insert into  CUST_DEP_REDEMPTION_DETAILS
created : 02/27/2018 SXH487 -- ccn project
changed :

*******************************************************************************/
IN_CUST_DEP_REDEMPTION_rec   IN     CUST_DEP_REDEMPTION_DETAILS%ROWTYPE
);

PROCEDURE CUST_DEP_DET_I_SP(
/*******************************************************************************
CUST_DEP_DET_I_SP

This procedure is intended to insert new customer_deposit_details records
created : 02/27/2018 SXH487 -- ccn project
changed :

*******************************************************************************/
IN_CUST_DEPOSIT_DETAILS_rec   IN     CUSTOMER_DEPOSIT_DETAILS%ROWTYPE
);

PROCEDURE CUST_DEP_DET_HST_I_SP (
/*******************************************************************************
 This procedure is intended to insert records into CUSTOMER_DEPOSIT_DETAILS_HIST table
created : 02/27/2018 SXH487 -- ccn project
changed :
*******************************************************************************/
IN_ROW     IN     CUSTOMER_DEPOSIT_DETAILS_HIST%ROWTYPE
);

END TABLE_IU_PKG;