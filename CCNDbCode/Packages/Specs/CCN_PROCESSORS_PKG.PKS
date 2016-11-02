create or replace PACKAGE          CCN_PROCESSORS_PKG
AS

/*********************************************************** 
This package contains procedures/functions to deal with processors

Created : 04/08/2016 jxc517 CCN Project....
Modified:
************************************************************/

TYPE REF_CURSOR IS REF CURSOR;

PROCEDURE ALL_PROCESSOR_DTLS_S_SP (
/******************************************************************************
This procedure is intended to return a ref cursor with data from 
from the PROCESSORS, PROCESSOR_PHONE, and PROCESSOR_STATES tables.  

Created : 04/08/2016 jxc517 CCN Project....
Changed : 10/18/2016 jxc517 CCN Project....
          Added/Modified the parameters as per new model
********************************************************************************/
    O_PROCESSORS                  OUT      SYS_REFCURSOR,
    O_PROCESSOR_GROUPS            OUT      SYS_REFCURSOR,
    O_PRCSR_STR_GRP_DTLS          OUT      SYS_REFCURSOR,
    O_PRCSR_STR_ADMN_GRP_DTLS     OUT      SYS_REFCURSOR,
    O_PRCSR_CANADA_GRP_DTLS       OUT      SYS_REFCURSOR,
    O_PRCSR_HEADQRTS_GRP_DTLS     OUT      SYS_REFCURSOR,
    O_PRCSR_RETIREES_GRP_DTLS     OUT      SYS_REFCURSOR,
    O_PRCSR_AUTO_GRP_DTLS         OUT      SYS_REFCURSOR,
    O_PRCSR_INTRNTL_GRP_DTLS      OUT      SYS_REFCURSOR);

PROCEDURE PROCESSORS_UI_UPSERT_SP (
/******************************************************************************
This procedure is intended to insert/update/delete data from 
from the PROCESSORS tables

Created : 10/18/2016 jxc517 CCN Project....
Changed : 
********************************************************************************/
    IN_XML         IN            CLOB);

PROCEDURE PRCSR_GRP_DTLS_UI_UPSERT_SP (
/******************************************************************************
This procedure is intended to insert/update/delete data from 
from the below group detail tables.

PRCSR_STR_ADMN_GRP_DTLS
PRCSR_CANADA_GRP_DTLS
PRCSR_HEADQRTS_GRP_DTLS
PRCSR_RETIREES_GRP_DTLS
PRCSR_AUTO_GRP_DTLS
PRCSR_INTRNTL_GRP_DTLS

Created : 10/18/2016 jxc517 CCN Project....
Changed : 
********************************************************************************/
    IN_XML         IN            CLOB);

END CCN_PROCESSORS_PKG;