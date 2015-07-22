CREATE OR REPLACE PACKAGE         TABLE_IU_PKG 
AS
/**********************************************************
    This Package is intended to process the DMLs and DDLs on all the
  tables related to stare draft

created : 03/13/2015 nxk927 CCN BANKING PROJECT
changed :
**********************************************************/
TYPE BANK_MICR_FORMAT_TAB_TYPE IS TABLE OF BANK_MICR_FORMAT%ROWTYPE INDEX BY BINARY_INTEGER;
TYPE BANK_MICR_FORMAT_FTR_TAB_TYPE IS TABLE OF BANK_MICR_FORMAT_FUTURE%ROWTYPE INDEX BY BINARY_INTEGER;

TYPE MEMBER_BANK_CC_TAB_TYPE IS TABLE OF MEMBER_BANK_CC%ROWTYPE INDEX BY BINARY_INTEGER;
TYPE MEMBER_BANK_CC_FUTURE_TAB_TYPE IS TABLE OF MEMBER_BANK_CC_FUTURE%ROWTYPE INDEX BY BINARY_INTEGER;

---------------------------CURRENT ROWTYPE PROCEDURES---------------------------
PROCEDURE BANK_ACCOUNT_ROWTYPE_SP (
/*******************************************************************************
    This procedure is intended to build the BANK_ACCOUNT record type

Created : 03/12/2015 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME  IN     VARCHAR2
,IN_ROW_DATA   IN     CLOB
,OUT_ROW_TYPE     OUT BANK_ACCOUNT%ROWTYPE);

PROCEDURE BANK_MICR_FORMAT_ROWTYPE_SP (
/*******************************************************************************
    This procedure is intended to build the BANK_MICR_FORMAT record type

Created : 03/19/2015 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME  IN     VARCHAR2
,IN_ROW_DATA   IN     CLOB
,OUT_ROW_TYPE     OUT BANK_MICR_FORMAT%ROWTYPE);

PROCEDURE LEAD_BANK_CC_ROWTYPE_SP (
/*******************************************************************************
    This procedure is intended to build the LEAD_BANK_CC record type

Created : 03/12/2015 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME  IN     VARCHAR2
,IN_ROW_DATA   IN     CLOB
,OUT_ROW_TYPE     OUT LEAD_BANK_CC%ROWTYPE);

PROCEDURE MEMBER_BANK_CC_ROWTYPE_SP (
/*******************************************************************************
    This procedure is intended to build the MEMBER_BANK_CC record type

Created : 03/12/2015 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME  IN     VARCHAR2
,IN_ROW_DATA   IN     CLOB
,OUT_ROW_TYPE     OUT MEMBER_BANK_CC%ROWTYPE);

PROCEDURE BANK_PRCCNTR_ROWTYPE_SP (
/*******************************************************************************
    This procedure is intended to build the BANK_PRCCNTR record type

Created : 03/12/2015 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME  IN     VARCHAR2
,IN_ROW_DATA   IN     CLOB
,OUT_ROW_TYPE     OUT BANK_PRCCNTR%ROWTYPE);

PROCEDURE BANK_PRCDIST_ROWTYPE_SP (
/*******************************************************************************
    This procedure is intended to build the BANK_PRCDIST record type

Created : 03/12/2015 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME  IN     VARCHAR2
,IN_ROW_DATA   IN     CLOB
,OUT_ROW_TYPE     OUT BANK_PRCDIST%ROWTYPE);

PROCEDURE BANK_DEP_TICK_ROWTYPE_SP (
/*******************************************************************************
    This procedure is intended to build the BANK_DEP_TICK record type

Created : 03/12/2015 nxk927 CCN Project....
Changed : 04/23/2015 Added REORDER_SWITCH column.
*******************************************************************************/
IN_TABLE_NAME  IN     VARCHAR2
,IN_ROW_DATA   IN     CLOB
,OUT_ROW_TYPE     OUT BANK_DEP_TICK%ROWTYPE);

PROCEDURE BANK_DEP_TICKOAK_ROWTYPE_SP (
/*******************************************************************************
    This procedure is intended to build the BANK_DEP_TICKOAK record type

Created : 03/19/2015 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME  IN     VARCHAR2
,IN_ROW_DATA   IN     CLOB
,OUT_ROW_TYPE     OUT BANK_DEP_TICKOAK%ROWTYPE);

PROCEDURE BANK_DEP_TICKORD_ROWTYPE_SP (
/*******************************************************************************
    This procedure is intended to build the BANK_DEP_TICKORD record type

Created : 03/12/2015 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME  IN     VARCHAR2
,IN_ROW_DATA   IN     CLOB
,OUT_ROW_TYPE     OUT BANK_DEP_TICKORD%ROWTYPE);

PROCEDURE BANK_DEP_BAG_TICK_ROWTYPE_SP (
/*******************************************************************************
	This procedure is intended to build the BANK_DEP_BAG_TICK record type

Created : 04/08/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME  IN     VARCHAR2
,IN_ROW_DATA   IN     CLOB
,OUT_ROW_TYPE     OUT BANK_DEP_BAG_TICK%ROWTYPE);

---------------------------FUTURE ROWTYPE PROCEDURES---------------------------
PROCEDURE BANK_ACCOUNT_FUTURE_ROWTYPE_SP (
/*******************************************************************************
	This procedure is intended to build the BANK_ACCOUNT_FUTURE record type

Created : 04/09/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME  IN     VARCHAR2
,IN_ROW_DATA   IN     CLOB
,OUT_ROW_TYPE     OUT BANK_ACCOUNT_FUTURE%ROWTYPE);

PROCEDURE BANK_MICR_FRMT_FTR_ROWTYPE_SP (
/*******************************************************************************
	This procedure is intended to build the BANK_MICR_FORMAT_FUTURE record type

Created : 04/09/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME  IN     VARCHAR2
,IN_ROW_DATA   IN     CLOB
,OUT_ROW_TYPE     OUT BANK_MICR_FORMAT_FUTURE%ROWTYPE);

PROCEDURE LEAD_BANK_CC_FUTURE_ROWTYPE_SP (
/*******************************************************************************
	This procedure is intended to build the LEAD_BANK_CC_FUTURE record type

Created : 05/22/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME  IN     VARCHAR2
,IN_ROW_DATA   IN     CLOB
,OUT_ROW_TYPE     OUT LEAD_BANK_CC_FUTURE%ROWTYPE);

PROCEDURE MEMBER_BNK_FTRE_ROWTYPE_SP (
/*******************************************************************************
    This procedure is intended to build the MEMBER_BANK_CC_FUTURE record type

Created : 03/13/2015 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME  IN     VARCHAR2
,IN_ROW_DATA   IN     CLOB
,OUT_ROW_TYPE     OUT MEMBER_BANK_CC_FUTURE%ROWTYPE);

---------------------------HISTORY INSERT PROCEDURES----------------------------
PROCEDURE BANK_ACCOUNT_HIST_I_SP (
/*******************************************************************************
    This procedure is intended to insert records into BANK_ACCOUNT_HIST table

Created : 07/13/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW     IN     BANK_ACCOUNT%ROWTYPE);

PROCEDURE BANK_MICR_FORMAT_HIST_I_SP (
/*******************************************************************************
    This procedure is intended to insert records into BANK_MICR_FORMAT_HIST table

Created : 07/13/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW     IN     BANK_MICR_FORMAT%ROWTYPE);

PROCEDURE LEAD_BANK_CC_HIST_I_SP (
/*******************************************************************************
    This procedure is intended to insert records into LEAD_BANK_CC_HIST table

Created : 07/13/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW     IN     LEAD_BANK_CC%ROWTYPE);

PROCEDURE MEMBER_BANK_CC_HIST_I_SP (
/*******************************************************************************
    This procedure is intended to insert records into MEMBER_BANK_CC_HIST table

Created : 07/13/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW     IN     MEMBER_BANK_CC%ROWTYPE);

PROCEDURE BANK_DEP_TICK_HIST_I_SP (
/*******************************************************************************
    This procedure is intended to insert records into BANK_DEP_TICK_HIST table

Created : 03/24/2015 SXT410 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW     IN     BANK_DEP_TICK%ROWTYPE);

PROCEDURE BANK_DEP_BAG_TICK_HIST_I_SP (
/*******************************************************************************
	This procedure is intended to insert records into BANK_DEP_BAG_TICK_HIST table

Created : 04/08/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW     IN     BANK_DEP_BAG_TICK%ROWTYPE);

---------------------------CURRENT INSERT PROCEDURES----------------------------
PROCEDURE BANK_ACCOUNT_I_SP (
/*******************************************************************************
    This procedure is intended to insert records into BANK_ACCOUNT table

Created : 07/09/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW IN     BANK_ACCOUNT%ROWTYPE);

PROCEDURE BANK_MICR_FORMAT_I_SP (
/*******************************************************************************
    This procedure is intended to insert records into BANK_MICR_FORMAT table

Created : 07/09/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW IN     BANK_MICR_FORMAT%ROWTYPE);

PROCEDURE LEAD_BANK_CC_I_SP (
/*******************************************************************************
    This procedure is intended to insert records into LEAD_BANK_CC table

Created : 07/09/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW IN     LEAD_BANK_CC%ROWTYPE);

PROCEDURE MEMBER_BANK_CC_I_SP (
/*******************************************************************************
    This procedure is intended to insert records into MEMBER_BANK_CC table

Created : 07/10/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW IN     MEMBER_BANK_CC%ROWTYPE);

PROCEDURE BANK_DEP_TICK_I_SP (
/*******************************************************************************
    This procedure is intended to insert records into BANK_DEP_TICK table

Created : 03/12/2015 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW IN     BANK_DEP_TICK%ROWTYPE);

PROCEDURE BANK_DEP_BAG_TICK_I_SP (
/*******************************************************************************
	This procedure is intended to insert records into BANK_DEP_BAG_TICK table

Created : 04/08/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW  IN   BANK_DEP_BAG_TICK%ROWTYPE);

---------------------------FUTURE INSERT PROCEDURES----------------------------
PROCEDURE BANK_ACCOUNT_FUTURE_I_SP (
/*******************************************************************************
    This procedure is intended to insert records into BANK_ACCOUNT_FUTURE table

Created : 07/09/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW IN     BANK_ACCOUNT_FUTURE%ROWTYPE);

PROCEDURE BANK_MICR_FORMAT_FUTURE_I_SP(
/*******************************************************************************
    This procedure is intended to insert records into BANK_MICR_FORMAT_FUTURE table

Created : 07/09/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW IN     BANK_MICR_FORMAT_FUTURE%ROWTYPE);

PROCEDURE LEAD_BANK_CC_FUTURE_I_SP (
/*******************************************************************************
    This procedure is intended to insert records into LEAD_BANK_CC_FUTURE table

Created : 07/09/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW IN     LEAD_BANK_CC_FUTURE%ROWTYPE);

PROCEDURE MEMBER_BANK_CC_FUTURE_I_SP (
/*******************************************************************************
    This procedure is intended to insert records into MEMBER_BANK_CC_FUTURE table

Created : 07/10/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW IN     MEMBER_BANK_CC_FUTURE%ROWTYPE);

---------------------------HISTORY UPDATE PROCEDURES----------------------------
PROCEDURE BANK_ACCOUNT_HIST_U_SP(
/*******************************************************************************
    This procedure is intended to updates records in BANK_ACCOUNT_HIST table

Created : 07/21/2015 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW IN     BANK_ACCOUNT_HIST%ROWTYPE);

PROCEDURE BANK_MICR_FORMAT_HIST_U_SP(
/*******************************************************************************
    This procedure is intended to updates records in BANK_MICR_FORMAT_HIST table

Created : 07/21/2015 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW IN     BANK_MICR_FORMAT_HIST%ROWTYPE);

PROCEDURE LEAD_BANK_CC_HIST_U_SP (
/*******************************************************************************
    This procedure is intended to updates records in LEAD_BANK_CC_HIST table

Created : 07/21/2015 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW IN     LEAD_BANK_CC_HIST%ROWTYPE);

PROCEDURE MEMBER_BANK_CC_HIST_U_SP (
/*******************************************************************************
    This procedure is intended to updates records in MEMBER_BANK_CC table

Created : 07/21/2015 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW IN     MEMBER_BANK_CC_HIST%ROWTYPE);

---------------------------CURRENT UPDATE PROCEDURES----------------------------
PROCEDURE BANK_ACCOUNT_U_SP (
/*******************************************************************************
    This procedure is intended to updates records in BANK_ACCOUNT table

Created : 07/09/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW IN     BANK_ACCOUNT%ROWTYPE);

PROCEDURE BANK_MICR_FORMAT_U_SP (
/*******************************************************************************
    This procedure is intended to updates records in BANK_MICR_FORMAT table

Created : 07/09/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW IN     BANK_MICR_FORMAT%ROWTYPE);

PROCEDURE LEAD_BANK_CC_U_SP (
/*******************************************************************************
    This procedure is intended to updates records in LEAD_BANK_CC table

Created : 07/09/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW IN     LEAD_BANK_CC%ROWTYPE);

PROCEDURE MEMBER_BANK_CC_U_SP (
/*******************************************************************************
    This procedure is intended to updates records in MEMBER_BANK_CC table

Created : 07/10/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW IN     MEMBER_BANK_CC%ROWTYPE);

PROCEDURE BANK_DEP_BAG_TICK_U_SP (
/*******************************************************************************
	This procedure is intended to updates records in BANK_DEP_BAG_TICK table

Created : 04/08/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW  IN   BANK_DEP_BAG_TICK%ROWTYPE);

PROCEDURE BANK_DEP_TICK_U_SP (
/*******************************************************************************
    This procedure is intended to updates records in BANK_DEP_TICK table

Created : 03/12/2015 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW IN     BANK_DEP_TICK%ROWTYPE);

---------------------------FUTURE UPDATE PROCEDURES----------------------------
PROCEDURE BANK_ACCOUNT_FUTURE_U_SP (
/*******************************************************************************
    This procedure is intended to updates records in BANK_ACCOUNT_FUTURE table

Created : 07/09/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW IN     BANK_ACCOUNT_FUTURE%ROWTYPE);

PROCEDURE BANK_MICR_FORMAT_FUTURE_U_SP (
/*******************************************************************************
    This procedure is intended to updates records in BANK_MICR_FORMAT_FUTURE table

Created : 07/09/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW IN     BANK_MICR_FORMAT_FUTURE%ROWTYPE);

PROCEDURE LEAD_BANK_CC_FUTURE_U_SP (
/*******************************************************************************
    This procedure is intended to updates records in LEAD_BANK_CC_FUTURE table

Created : 07/09/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW IN     LEAD_BANK_CC_FUTURE%ROWTYPE);

PROCEDURE MEMBER_BANK_CC_FUTURE_U_SP (
/*******************************************************************************
    This procedure is intended to updates records in MEMBER_BANK_CC_FUTURE table

Created : 07/10/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW IN     MEMBER_BANK_CC_FUTURE%ROWTYPE);

---------------------------CURRRENT DELETE PROCEDURES----------------------------
PROCEDURE BANK_ACCOUNT_D_SP (
/*******************************************************************************
	This procedure is intended to delete records from BANK_ACCOUNT table

Created : 07/13/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW IN     BANK_ACCOUNT%ROWTYPE);

PROCEDURE BANK_MICR_FORMAT_D_SP (
/*******************************************************************************
	This procedure is intended to delete records from BANK_MICR_FUTURE table

Created : 07/13/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW     IN     BANK_MICR_FORMAT%ROWTYPE);

PROCEDURE LEAD_BANK_CC_D_SP (
/*******************************************************************************
	This procedure is intended to delete records from LEAD_BANK_CC table

Created : 07/13/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW     IN     LEAD_BANK_CC%ROWTYPE);

PROCEDURE MEMBER_BANK_CC_D_SP (
/*******************************************************************************
	This procedure is intended to delete records from MEMBER_BANK_CC table

Created : 07/13/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW     IN     MEMBER_BANK_CC%ROWTYPE);

---------------------------FUTURE DELETE PROCEDURES----------------------------
PROCEDURE BANK_ACCOUNT_FUTURE_D_SP (
/*******************************************************************************
	This procedure is intended to delete records from BANK_ACCOUNT_FUTURE table

Created : 07/13/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW IN     BANK_ACCOUNT_FUTURE%ROWTYPE);

PROCEDURE BANK_MICR_FORMAT_FUTURE_D_SP (
/*******************************************************************************
	This procedure is intended to delete records from BANK_MICR_FORMAT_FUTURE table

Created : 07/13/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW IN     BANK_MICR_FORMAT_FUTURE%ROWTYPE);

PROCEDURE LEAD_BANK_CC_FUTURE_D_SP (
/*******************************************************************************
	This procedure is intended to delete records from LEAD_BANK_CC_FUTURE table

Created : 07/13/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW IN     LEAD_BANK_CC_FUTURE%ROWTYPE);

PROCEDURE MEMBER_BANK_CC_FUTURE_D_SP (
/*******************************************************************************
	This procedure is intended to delete records from MEMBER_BANK_CC_FUTURE table

Created : 07/13/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW IN     MEMBER_BANK_CC_FUTURE%ROWTYPE);

---------------------------EXPIRE PROCEDURES----------------------------
PROCEDURE EXPIRE_PREV_BANK_ACCOUNT(
/*******************************************************************************
    This procedure is intended to check and expire previous records
    before inserting new record

Created : 07/09/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW IN     BANK_ACCOUNT_FUTURE%ROWTYPE);

PROCEDURE EXPIRE_PREV_LEAD_BANK_CC(
/*******************************************************************************
    This procedure is intended to check and expire previous records
    before inserting new record

Created : 07/09/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW IN     LEAD_BANK_CC_FUTURE%ROWTYPE);

PROCEDURE EXPIRE_PREV_BANK_MICR_FORMAT(
/*******************************************************************************
    This procedure is intended to check and expire previous records
    before inserting new record

Created : 07/09/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW IN     BANK_MICR_FORMAT_FUTURE%ROWTYPE);

PROCEDURE EXPIRE_PREV_MEMBER_BANK_CC(
/*******************************************************************************
    This procedure is intended to check and expire previous records
    before inserting new record

Created : 07/09/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW IN     MEMBER_BANK_CC_FUTURE%ROWTYPE);

END TABLE_IU_PKG;

