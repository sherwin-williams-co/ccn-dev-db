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
Changed : 
********************************************************************************/
    O_PROCESSORS           OUT      SYS_REFCURSOR,
    O_PROCESSOR_STATES     OUT      SYS_REFCURSOR);

PROCEDURE PROCESSOR_UI_UPSERT_SP (
/******************************************************************************
This procedure is intended to insert/update/delete data from 
from the PROCESSORS, PROCESSOR_PHONE, and PROCESSOR_STATES tables.

Created : 04/08/2016 jxc517 CCN Project....
Changed : 
********************************************************************************/
    IN_XML         IN            CLOB);

END CCN_PROCESSORS_PKG;

