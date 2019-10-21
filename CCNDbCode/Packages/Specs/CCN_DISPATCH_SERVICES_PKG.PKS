create or replace PACKAGE CCN_DISPATCH_SERVICES_PKG
AS
/**********************************************************
    CCN_DISPATCH_SERVICES_PKG

    This Package is intended to be the wrapper for the Dispatch Services related UI exchange.

Created : 09/04/2019 sxc403/akj899 CCNA2-55 CCN Project....
Changed :
**********************************************************/
PROCEDURE DISPATCH_SERVICES_S_SP(
/******************************************************************************
This procedure is intended to return ref cursors for store data, address data
and dispatch terminal data for the paased cost center code.

Created : 09/04/2019 akj899 CCNA2-55 CCN Project Team....
Modified:
******************************************************************************/
    IN_COST_CENTER_CODE             IN   STORE.COST_CENTER_CODE%TYPE,
    OUT_STORE_REF_CUR               OUT  SYS_REFCURSOR,
    OUT_ADDRESS_REF_CUR             OUT  SYS_REFCURSOR,
    OUT_DSPTCH_TRMNL_REF_CUR        OUT  SYS_REFCURSOR);

PROCEDURE DISPATCH_SERVICES_RPRT_SP(
/******************************************************************************
This procedure is intended to return ref cursors for store data for given
division, area nad district

Created : 09/05/2019 akj899 CCNA2-55 CCN Project Team....
Modified:
******************************************************************************/
    IN_DIVISION          IN      GLOBAL_HIERARCHY_DETAIL_VIEW.DIVISION%TYPE,
    IN_AREA              IN      GLOBAL_HIERARCHY_DETAIL_VIEW.AREA%TYPE,
    IN_DISTRICT          IN      GLOBAL_HIERARCHY_DETAIL_VIEW.DISTRICT%TYPE,
    OUT_STORE_REF_CUR    OUT     SYS_REFCURSOR);

PROCEDURE CCN_DISPATCH_SERVICES_UPSERT_SP (
/**********************************************************
This procedure will update the STORE table.

    <CCN_STORE_DISPATCH_SERVICES_UI>
      <STORE>
        <COST_CENTER_CODE>701001</COST_CENTER_CODE>
        <CATEGORY>S</CATEGORY>
        <PERP_INV_START_DATE></PERP_INV_START_DATE>
        <CLASSIFICATION_CODE></CLASSIFICATION_CODE>
        <INVENTORY_INDICATOR>Y</INVENTORY_INDICATOR>
        <RURAL_METRO_ZONE_CODE></RURAL_METRO_ZONE_CODE>
        <SELLING_STORE_FLAG>Y</SELLING_STORE_FLAG>
        <SALES_VOL_CLASS_CODE></SALES_VOL_CLASS_CODE>
        <SELLING_STORE_FLAG_MARK_DT>04-APR_2019</SELLING_STORE_FLAG_MARK_DT>
        <POTENTIAL_OPEN_DATE>04-APR_2019</POTENTIAL_OPEN_DATE>
        <POS_VERSION_NBR></POS_VERSION_NBR>
        <POS_VERSION_NBR_APPLIED_DATE></POS_VERSION_NBR_APPLIED_DATE>
        <DESCARTES_DELIVERY_CODE>S</DESCARTES_DELIVERY_CODE>
        <DISPATCH_SERVICE_TYPE_CODE>1</DISPATCH_SERVICE_TYPE_CODE>
        <DESIGNATED_TERMINAL_NUMBER>13532</DESIGNATED_TERMINAL_NUMBER>
        <GO_LIVE_DATE>02-13-2019</GO_LIVE_DATE>
        <PICKUP_BUFFER>20</PICKUP_BUFFER>
        <MIN_RMNG_DLVRY_TIME>2</MIN_RMNG_DLVRY_TIME>
      </STORE>
    </CCN_STORE_DISPATCH_SERVICES_UI>

Created : 9/23/2019 sxc403/akj899 CCNA2-55 CCN Project Team....
Changed :
**********************************************************/
    IN_XML      IN CLOB);
    
PROCEDURE STORE_DISPATCH_SERVICES_LOAD_PROCESS(
/******************************************************************************
This procedure is the core process for updating the store dispatch services column values.
This process is involked by UI for bulk update of store dispatch services fields.

IN_BLOB          - blob value delimited by , and termianted by new line character

Created : 08/01/2018 akj899 CCNA2-55 CCN Project Team....
Modified:
******************************************************************************/
    IN_BLOB            IN       BLOB);
    
PROCEDURE BUILD_STR_DSPTCH_SRV_UPD_XML(
/******************************************************************************
This procedure is to build the XML with updated values  of descartes dispatch services fields 
fetched from csv file in order to update the Store table.

Created : 10/07/2019 akj899 CCN Project Team....
Modified:
******************************************************************************/
    IN_COST_CENTER_CODE  IN     STORE.COST_CENTER_CODE%TYPE,
    OUT_XML              OUT    CLOB);

END CCN_DISPATCH_SERVICES_PKG;