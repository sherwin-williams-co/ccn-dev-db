PACKAGE CCN_HIERARCHY
    AS
	
	 	TYPE REF_CURSOR IS REF CURSOR;

FUNCTION CHECK_PREVIOUS_LEVELS (
/***********************************************************
      CHECK_DETAIL_LEVELS 
      This Procedure will check if the previous Hierarchy levels 
      exists in HIERARCHY_DETAIL or HIERARCHY_DETAIL_HST in
      HRCHY_DTL_CURR_LVL_VAL before the insert of the next level
      
Created : 02/27/2013 SH CCN Project
************************************************************/
            in_IND IN VARCHAR2 DEFAULT NULL,
            in_HRCHY_HDR_NAME  IN HIERARCHY_DETAIL_HST.HRCHY_HDR_NAME%TYPE,
            in_HRCHY_DTL_LEVEL IN HIERARCHY_DETAIL_HST.HRCHY_DTL_LEVEL%TYPE,
            in_CURR_VAL        IN HIERARCHY_DETAIL_HST.HRCHY_DTL_CURR_LVL_VAL%TYPE
            )
             RETURN VARCHAR2;
            
PROCEDURE hierarchy_insert_wrapper
( in_ind IN VARCHAR2,
  in_hierarchy_detail_row IN hierarchy_detail%rowtype);
  
FUNCTION HIERARCHY_DESC_RETURN (
/***********************************************************
      HIERARCHY_DESC_RETURN 
      This Procedure will return the Hierarchy level DESC 
      from HIERARCHY_DETAIL for any curr val passed and for any
      level. This is used for the insert into hist for Transfer 
      process.
input param : in_HRCHY_DTL_CURR_LVL_VAL
Created : 03/19/2013 SH CCN Project
************************************************************/
            in_HRCHY_DTL_CURR_LVL_VAL IN HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE
            ,in_HRCHY_HDR_NAME IN HIERARCHY_DETAIL.HRCHY_HDR_NAME%TYPE
            )
             RETURN VARCHAR2;
             
/**********************************************************
	RETURN_HIERARCHY

	This procedure will return a ref cursor with data from 
	from the hierarchy_detail table based on header name, current value , traverse ( UP or DOWN DEFAULT is UP)
	and level
	ex. CCN_HIERARCHY.RETURN_HIERARCHY('DAD Structure','703252','DOWN',OUT_DEFINED_REF_CURSOR)

created : 03/22/2012 OD CCN Project....
**********************************************************/
		PROCEDURE RETURN_HIERARCHY (	
						IN_HEADER_NAME 		IN HIERARCHY_DETAIL.HRCHY_HDR_NAME%TYPE
			    , 	IN_CURR_ROW_VAL	IN HIERARCHY_DETAIL.HRCHY_DTL_CURR_ROW_VAL%TYPE
			    ,	IN_LEVEL		IN HIERARCHY_DETAIL.HRCHY_DTL_LEVEL%TYPE
			    ,	IN_TRAVERSE		IN VARCHAR2 DEFAULT 'UP'
			    ,   OUT_HIERARCHY_REF_CUR IN OUT REF_CURSOR
         --    ,   OUT_HIERARCHY_REF_CUR IN OUT SYS_REFCURSOR
					   );


PROCEDURE RETURN_HIERARCHY_LAST_LVL (	
/**********************************************************
	RETURN_HIERARCHY

	This procedure will return a ref cursor with data from 
	from the hierarchy_detail lowest level table based on header name, current value , t
	

created : 06/22/2012 kdp CCN Project....
**********************************************************/

				IN_HEADER_NAME 			IN HIERARCHY_DETAIL.HRCHY_HDR_NAME%TYPE
			    ,	IN_LEVEL			IN HIERARCHY_DETAIL.HRCHY_DTL_LEVEL%TYPE
			    ,	IN_COMPOSITE_KEY	IN HIERARCHY_DETAIL.HRCHY_DTL_PREV_LVL_VAL%TYPE
			    ,   OUT_HIERARCHY_REF_CUR IN OUT REF_CURSOR
			   );


/**********************************************************
	RETURN_HIERARCHY

	This procedure will return a ref cursor with data from 
	from the hierarchy_detail table based on header name, current value , traverse ( UP or DOWN DEFAULT is UP)
	and structure as of history date (NULL if you want current structure which is also the DEFAULT)
	ex. CCN_HIERARCHY.RETURN_HIERARCHY('DAD Structure','703252','DOWN',TO_DATE(03/24/2011','MM/DD/YYYY'),OUT_DEFINED_REF_CURSOR)

created : 03/22/2012 OD CCN Project....
**********************************************************/
		PROCEDURE RETURN_HIERARCHY_HIST (	
						IN_HEADER_NAME 	IN HIERARCHY_DETAIL.HRCHY_HDR_NAME%TYPE
					    , 	IN_CURR_ROW_VAL	IN HIERARCHY_DETAIL.HRCHY_DTL_CURR_ROW_VAL%TYPE
					    ,	IN_LEVEL	IN HIERARCHY_DETAIL.HRCHY_DTL_LEVEL%TYPE
					    ,	IN_TRAVERSE	IN VARCHAR2 DEFAULT 'UP'
					    ,	IN_HIST_DATE	IN HIERARCHY_DETAIL.HRCHY_DTL_EFF_DATE%TYPE DEFAULT NULL
					    ,   OUT_HIERARCHY_REF_CUR OUT REF_CURSOR
					   );
		PROCEDURE RETURN_HIERARCHY_UP (	
/**********************************************************
	RETURN_DAD

	This procedure will return a ref cursor with DAD data from 
	from the hierarchy_detail table based on just the header name, cost center or last level value
	ex. CCN_HIERARCHY.RETURN_HIERARCHY('DAD Structure','703252','DOWN',OUT_DEFINED_REF_CURSOR)

created : 07/22/2012 OD CCN Project....
**********************************************************/
						IN_HEADER_NAME 	IN HIERARCHY_DETAIL.HRCHY_HDR_NAME%TYPE
					    , 	IN_ROW_VAL	IN HIERARCHY_DETAIL.HRCHY_DTL_CURR_ROW_VAL%TYPE
					    ,   OUT_HIERARCHY_REF_CUR IN OUT REF_CURSOR
					   );
               PROCEDURE HIERARCHY_PICKLIST(	
/**********************************************************
	HIERARCHY_PICKLIST

	This procedure will return data in ref_cursor 
        from HIERARCHY_DETAIL depending on the input params
        Ex - If all the Areas need to be returned for a Given 
        Division then the XML from the UI will have Hierarchy Name
        and Hierarchy Detail level '2' and current division ='04'
        
<HIERARCHY_DETAIL>
  <row_data>
      <HRCHY_HDR_NAME>DAD STRUCTURE</HRCHY_HDR_NAME> 
      <HRCHY_DTL_LVL>4</HRCHY_DTL_LVL> 
      <HRCHY_LEVEL1>04</HRCHY_LEVEL1> 
      <HRCHY_LEVEL2>02</HRCHY_LEVEL2>
      <HRCHY_LEVEL3>35</HRCHY_LEVEL3>
      <HRCHY_LEVEL4>708113</HRCHY_LEVEL4>
  </row_data>
</HIERARCHY_DETAIL>

created : 02/13/2013 SH CCN Project....
**********************************************************/
  in_XML                VARCHAR2,
  OUT_HIERARCHY_REF_CUR OUT REF_CURSOR);

PROCEDURE HIERARCHY_STMNT_TYPE_PICKLIST(	
/**********************************************************
	HIERARCHY_STMNT_TYPE_PICKLIST

	This procedure will return data in ref_cursor 
        for statement type from HIERARCHY_DETAIL depending 
        on the input params
        Ex - If all the Areas need to be returned for a Given 
        Division then the XML from the UI will have Hierarchy Name
        and Hierarchy Detail level '2' and current division ='04'
        
<HIERARCHY_DETAIL>
  <row_data>
      <HRCHY_HDR_NAME>DAD STRUCTURE</HRCHY_HDR_NAME> 
      <HRCHY_DTL_LEVEL>4</HRCHY_DTL_LEVEL> 
      <HRCHY_LEVEL1>04</HRCHY_LEVEL1> 
      <HRCHY_LEVEL2>02</HRCHY_LEVEL2>
      <HRCHY_LEVEL3>35</HRCHY_LEVEL3>
      <HRCHY_LEVEL4>708113</HRCHY_LEVEL4>
  </row_data>
</HIERARCHY_DETAIL>

created : 02/13/2013 SH CCN Project....
**********************************************************/
  in_XML                VARCHAR2,--XMLTYPE,
  OUT_HIERARCHY_REF_CUR OUT REF_CURSOR);
  
PROCEDURE HIERARCHY_HDR_DESC_PICKLIST(	
/**********************************************************
	HIERARCHY_HDR_DESC_PICKLIST

	This procedure will return the data in ref cursor
        from HIERARCHY_HEADER and HIERARCHY_DESCRIPTION

<HIERARCHY_DETAIL>
  <row_data>
      <HRCHY_HDR_NAME>DAD STRUCTURE</HRCHY_HDR_NAME> 
  </row_data>
</HIERARCHY_DETAIL>
created : 02/13/2013 SH CCN Project....
**********************************************************/
  in_XML                VARCHAR2,
  OUT_HIERARCHY_REF_CUR OUT REF_CURSOR
  );
 
PROCEDURE HIERARCHY_HEADER_INSERT(
/**********************************************************
	HIERARCHY_HEADER_INSERT

	This procedure will insert into the table HIERARCHY_HEADER
        
<HIERARCHY_HEADER>
  <row_data>
      <HRCHY_HDR_NAME>DAD STRUCTURE</HRCHY_HDR_NAME> 
      <HRCHY_HDR_LEVELS>04</HRCHY_HDR_LEVELS> 
      <HRCHY_HDR_DESC>Div Area Dist Structure</HRCHY_HDR_DESC> 
      <UPPER_LVL_VER_DESC>Statement Type</UPPER_LVL_VER_DESC>
  </row_data>
</HIERARCHY_HEADER>

created : 02/13/2013 SH CCN Project....
**********************************************************/
    in_XML                VARCHAR2);

PROCEDURE HIERARCHY_DESCRIPTION_INSERT(
/**********************************************************
	HIERARCHY_DESCRIPTION_INSERT

	This procedure will insert into the table HIERARCHY_DESCRIPTION 
        
<HIERARCHY_DESCRIPTION>
  <row_data>
      <HRCHY_HDR_NAME>DAD STRUCTURE</HRCHY_HDR_NAME> 
      <HRCHY_HDR_LEVEL_NBR>04</HRCHY_HDR_LEVELS> 
      <HRCHY_HDR_LVL_DESC>Div Area Dist Structure</HRCHY_HDR_DESC> 
  </row_data>
</HIERARCHY_DESCRIPTION>

created : 02/13/2013 SH CCN Project....
**********************************************************/
    IN_XML                VARCHAR2);

PROCEDURE HIERARCHY_DETAIL_INSERT(
/**********************************************************
	HIERARCHY_DETAIL_INSERT

	This procedure will insert into the table HIERARCHY_DETAIL 
        
<HIERARCHY_DETAIL>
  <row_data>
      <HRCHY_HDR_NAME>DAD STRUCTURE</HRCHY_HDR_NAME> 
      <HRCHY_DTL_LEVEL>4</HRCHY_DTL_LEVEL> 
      <HRCHY_LEVEL1>05</HRCHY_LEVEL1> 
      <HRCHY_LEVEL2>04</HRCHY_LEVEL2> 
      <HRCHY_LEVEL3>86</HRCHY_LEVEL3>
      <HRCHY_LEVEL4>785900</HRCHY_LEVEL4>
      <HRCHY_DTL_DESC>PF WEST REGION</HRCHY_DTL_DESC>
      <HRCHY_DTL_EFF_DATE>01-JAN-2013</HRCHY_DTL_EFF_DATE>
      <HRCHY_DTL_EXP_DATE>01-JAN-9999</HRCHY_DTL_EXP_DATE>
      <UPPER_LVL_VER_VALUE>01</UPPER_LVL_VER_VALUE>
  </row_data>
</HIERARCHY_DETAIL>

created : 02/13/2013 SH CCN Project....
**********************************************************/
    in_XML                VARCHAR2);
    
PROCEDURE HIERARCHY_TRANSFER_PROCESS(
 in_XML                VARCHAR2);

PROCEDURE HIERARCHY_HDR_PICKLIST(	
/**********************************************************
	HIERARCHY_HDR_DESC_PICKLIST

	This procedure will return the data in ref cursor
        from HIERARCHY_HEADER and HIERARCHY_DESCRIPTION
        

created : 04/25/2013 kdp CCN Project....
**********************************************************/
  OUT_HIERARCHY_REF_CUR OUT REF_CURSOR
  );
 
END CCN_HIERARCHY;

