package CCN_BACKfill_PKG
    as
	
	 	TYPE REF_CURSOR IS REF CURSOR;

PROCEDURE Build_File_SP (
/**********************************************************
	Build_File_SP

	This procedure is intended to build a file based on the table layout
	in order to be consumed by the Mainframe to backfill Legacy MainFrame

	CostCenter - Cost Center that changed
	OracleTableName -Table name for row
	varible (based on the table that was updated)


created : 02/21/2012 kdp CCN Project....
**********************************************************/
in_COST_CENTER IN COST_CENTER.COST_CENTER_CODE%TYPE
,in_TABLE_NAME IN VARCHAR2
,in_ROW_DATE   IN sys.XMLTYPE)
;

--**********************************************************
end CCN_BACKfill_PKG;
/

