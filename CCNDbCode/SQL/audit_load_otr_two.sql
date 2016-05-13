/*
Created: AXK326 CCN Project Team....
         Script to force records that had rec_upd_flag as NULL to make it through AUDIT
*/
DECLARE

CURSOR SEL_AUDIT_LOG IS
        SELECT *
          FROM AUDIT_LOG 
         WHERE AUDIT_REC_FLAG IS NULL
           AND (TRANSACTION_DATE <= (SELECT MAX(BATCH_JOB_LAST_RUN_DATE)
                                       FROM BATCH_JOB
                                      WHERE BATCH_JOB_NAME = 'BACKFEED_AUDIT_LOG')
            OR NVL(GLOBAL_HIERARCHY_SKIP_FLAG,'N') = 'Y')
           AND TABLE_NAME IN ('TERRITORY_EMPLOYEE', 'MANAGER_EMPLOYEE')
ORDER BY 2, 3 DESC;

V_CONTEXT	        VARCHAR2(200);
SQ		            INTEGER;
SE		            VARCHAR2(1000);
v_code              NUMBER;
v_errm              varchar2(500);  
V_CC_CODE           COST_CENTER.COST_CENTER_CODE%TYPE;
V_BATCH_NUMBER      BATCH_JOB.BATCH_JOB_NUMBER%TYPE;
V_TRANS_STATUS      BATCH_JOB.TRANS_STATUS%TYPE := 'SUCCESSFUL';
V_BATCH_JOB_STATUS  BATCH_JOB.BATCH_JOB_STATUS%TYPE := 'PROCESSING';

V_ATRIBUTE_TAG_VALUE       VARCHAR2(100) := 'attributes';-- 'ATTRIBUTES';

FUNCTION XML_EXTRACT_NO_EXCEPTION
/**********************************************************
This function returns null if XPATH does not exist within xmltype, 
oracle throws an exception if not handled this way

**********************************************************/
( p_xml IN XMLTYPE
, p_xpath IN VARCHAR2
) RETURN VARCHAR2 

IS

BEGIN

    RETURN 
	    CASE WHEN P_XML.EXTRACT(P_XPATH) IS NOT NULL THEN
	      p_xml.extract(p_xpath || '/text()').getstringval()
	    ELSE 
	       NULL
	    END;

END XML_EXTRACT_NO_EXCEPTION;

FUNCTION REQUIRED_TABLE_CHECK
/**********************************************************
this function checks for the table to be excluded or included
by checking the excluded indicator and the table name from the 
'CCN_AUDIT_EXCLUDED_TABLES' table

created : 08/20/2012
**********************************************************/
(IN_TABLE_NAME   IN   VARCHAR2)
RETURN VARCHAR2
IS
  L_RETURN_VALUE VARCHAR2(1) := 'Y';
BEGIN

  SELECT CASE WHEN COUNT(*) > 0 THEN
                    'N'
                   ELSE
                    'Y'
                   END CASE
    INTO L_RETURN_VALUE
    FROM CCN_AUDIT_EXCLUDED_TABLES
   WHERE TABLE_NAME         = UPPER(IN_TABLE_NAME)
     AND EXCLUDED_INDICATOR = 'Y';

  RETURN L_RETURN_VALUE;

EXCEPTION
  WHEN OTHERS THEN
    RETURN L_RETURN_VALUE;
END REQUIRED_TABLE_CHECK;

FUNCTION HANDLE_SPECIAL_CHRCTRS(
/**********************************************************
This function will replace special characters while writing
it to Audit Backfeed file

parameters:

IO_TEXT_STRING  IN OUT

created : 11/02/2015 axk326 CCN Project Team....
**********************************************************/
IO_TEXT_STRING    IN    VARCHAR2) RETURN VARCHAR2
IS
   V_TEXT_STRING VARCHAR2(32000) := IO_TEXT_STRING;
BEGIN
   --Replaces &lt; with <
   V_TEXT_STRING := REPLACE(V_TEXT_STRING,'&lt;','<');
   --Replaces &gt; with >
   V_TEXT_STRING := REPLACE(V_TEXT_STRING,'&gt;','>');
   --Replaces &amp; with &
   V_TEXT_STRING := REPLACE(V_TEXT_STRING,'&amp;','&');
   --Replaces &quot; with "
   V_TEXT_STRING := REPLACE(V_TEXT_STRING,'&quot;','"');
   --Replaces &apos; with '
   V_TEXT_STRING := REPLACE(V_TEXT_STRING,'&apos;','''');
   --Replaces &ô; with ô
   V_TEXT_STRING := REPLACE(V_TEXT_STRING,'&ô;','ô');
   --Replaces &é; with é
   V_TEXT_STRING := REPLACE(V_TEXT_STRING,'&é;','é');
   RETURN V_TEXT_STRING;
END HANDLE_SPECIAL_CHRCTRS;

PROCEDURE GET_HIERARCHY_HEADER_NAME_LVL(
/**********************************************************
	IS_COSTCNTR_IN_GLOBAL_HRCHY

	This function returns true if the hierarchy level is in last 2 levels of that hierarchy

in_TRANSACTION_ID - inpupt Key Value
in_TABLE_NAME     - Input Table Name

created : 03/06/2014 jxc517 CCN Project....
**********************************************************/
in_TRANSACTION_ID     IN        VARCHAR2,
OUT_HRCHY_HDR_NAME       OUT    HIERARCHY_DESCRIPTION.HRCHY_HDR_NAME%TYPE,
OUT_HRCHY_HDR_LVL_NBR    OUT    HIERARCHY_DESCRIPTION.HRCHY_HDR_LVL_NBR%TYPE) IS
BEGIN

    --ADMIN_TO_SALES_DIVISION|3|0101|010112|~~~|05-MAR-14
    OUT_HRCHY_HDR_NAME    := substr(in_TRANSACTION_ID,1,INSTR(in_TRANSACTION_ID,'|',1)-1);
    OUT_HRCHY_HDR_LVL_NBR := substr(in_TRANSACTION_ID,
                                  INSTR(in_TRANSACTION_ID,'|',1)+1,
                                  (INSTR(in_TRANSACTION_ID,'|',1,2)-(INSTR(in_TRANSACTION_ID,'|',1)+1)));

EXCEPTION
   WHEN OTHERS THEN
      NULL;
END GET_HIERARCHY_HEADER_NAME_LVL;

FUNCTION IS_IN_LAST_TWO_LVLS_OF_HRCHY(
/**********************************************************
	IS_COSTCNTR_IN_GLOBAL_HRCHY

	This function returns true if the hierarchy level is in last 2 levels of that hierarchy

in_TRANSACTION_ID - inpupt Key Value
in_TABLE_NAME     - Input Table Name

created : 03/06/2014 jxc517 CCN Project....
**********************************************************/
in_TRANSACTION_ID    IN     VARCHAR2,
in_TABLE_NAME        IN     VARCHAR2) RETURN BOOLEAN IS
   V_HRCHY_HDR_LVL_NBR    HIERARCHY_DESCRIPTION.HRCHY_HDR_LVL_NBR%TYPE;
   V_HRCHY_HDR_NAME       HIERARCHY_DESCRIPTION.HRCHY_HDR_NAME%TYPE;
   V_RETURN_VALUE         BOOLEAN := TRUE;
   V_COUNT                NUMBER  := 0;
BEGIN
    --This validation is applicable only for HIERARCHY_DETAIL table
    --For all other tables this function should return true
    IF in_TABLE_NAME = 'HIERARCHY_DETAIL' THEN
        GET_HIERARCHY_HEADER_NAME_LVL(in_TRANSACTION_ID,V_HRCHY_HDR_NAME,V_HRCHY_HDR_LVL_NBR); 

        SELECT COUNT(*)
          INTO  V_COUNT
          FROM HIERARCHY_HEADER HH
         WHERE HH.HRCHY_HDR_NAME       = UPPER(V_HRCHY_HDR_NAME)
           AND HH.HRCHY_HDR_LEVELS - 1 > UPPER(V_HRCHY_HDR_LVL_NBR);

        IF V_COUNT > 0 THEN
            V_RETURN_VALUE := FALSE;
        END IF;
    END IF;
    
    RETURN V_RETURN_VALUE;

EXCEPTION
   WHEN OTHERS THEN
      RETURN V_RETURN_VALUE;
END IS_IN_LAST_TWO_LVLS_OF_HRCHY;

FUNCTION IS_COSTCNTR_IN_GLOBAL_HRCHY(
/**********************************************************
	IS_COSTCNTR_IN_GLOBAL_HRCHY

	This function returns true if the cost center is associated with global hierarchy

in_TRANSACTION_ID - inpupt Key Value
in_TABLE_NAME     - Input Table Name

created : 09/10/2013 kdp CCN Project....
**********************************************************/
in_TRANSACTION_ID    IN     VARCHAR2,
in_TABLE_NAME        IN     VARCHAR2) RETURN BOOLEAN IS
   V_COUNT             NUMBER := 0;
   V_COST_CENTER_CODE  VARCHAR2(10);
   V_HRCHY_HDR_LVL_NBR    HIERARCHY_DESCRIPTION.HRCHY_HDR_LVL_NBR%TYPE;
   V_HRCHY_HDR_NAME       HIERARCHY_DESCRIPTION.HRCHY_HDR_NAME%TYPE;
BEGIN
   --For Hierarchy_Detail, the key will of any two below formats
   IF in_TABLE_NAME = 'HIERARCHY_DETAIL' THEN
      --If 3 digits prior to last '|' is ~~~ meaning its last level
      IF SUBSTR(in_TRANSACTION_ID,INSTR(in_TRANSACTION_ID,'|',-1)-3,3) = '~~~' THEN
         GET_HIERARCHY_HEADER_NAME_LVL(in_TRANSACTION_ID,V_HRCHY_HDR_NAME,V_HRCHY_HDR_LVL_NBR);

         SELECT COUNT(*)
           INTO  V_COUNT
           FROM HIERARCHY_HEADER HH
          WHERE HH.HRCHY_HDR_NAME   = UPPER(V_HRCHY_HDR_NAME)
            AND HH.HRCHY_HDR_LEVELS = UPPER(V_HRCHY_HDR_LVL_NBR);

         IF V_COUNT > 0 THEN --Last Level of the hierarchy => Get the cost center value to validate completeness
             --GLOBAL_HIERARCHY|9|0101010106510101|0101010106510101888842|~~~|11-SEP-13
             --Extract prior 6 characters from SECOND LAST '|' for cost center, in example 888842
             V_COST_CENTER_CODE := SUBSTR(in_TRANSACTION_ID,INSTR(in_TRANSACTION_ID,'|',-1,2)-6,6);
         ELSE --Not the last Level of the hierarchy => Send it to Audit, irrespective of hierarchy
            RETURN TRUE;
         END IF;
      ELSE--If 3 digits prior to last '|' is NOT ~~~ meaning its NOT the last level
         --GLOBAL_HIERARCHY|8|01010101065101|0101010106510101|0101010106510101888842|11-SEP-13
         --Extract prior 6 characters from LAST '|' for cost center, in example 888842
         V_COST_CENTER_CODE := SUBSTR(in_TRANSACTION_ID,INSTR(in_TRANSACTION_ID,'|',-1)-6,6);
      END IF;
   ELSE
      IF in_TABLE_NAME = 'TERRITORY' THEN
	       V_COST_CENTER_CODE := SUBSTR(in_TRANSACTION_ID,INSTR(in_TRANSACTION_ID,'|',-1,2)-6,6);
	      
      	 --|02295B|755547|T|
      	 --Getting last cost center after 2nd '|' from the end
      ELSE   
         --Transaction Id input will have format as |888826|S|AA|05-SEP-13| for all other tables apart from Hierarchy_Detail
         --i.e.., from 2nd character till 7th character its the cost center code = 888826 in above example
         V_COST_CENTER_CODE := SUBSTR(in_TRANSACTION_ID,2,6);
      END IF;
   END IF;
   CCN_HIERARCHY.update_cc_global_hrchy_ind(V_COST_CENTER_CODE);
   
   --Below query will check if cost center is part of global hierarchy
   SELECT COUNT(*) INTO V_COUNT
     FROM COST_CENTER
    WHERE COST_CENTER_CODE              = V_COST_CENTER_CODE
      AND NVL(GLOBAL_HIERARCHY_IND,'N') = 'Y';

   IF V_COUNT = 1 THEN
      RETURN TRUE;
   ELSE
      RETURN FALSE;
   END IF;
EXCEPTION
   WHEN OTHERS THEN
      RETURN FALSE;
END IS_COSTCNTR_IN_GLOBAL_HRCHY;

FUNCTION IS_COLUMN_PART_OF_KEY(
/**********************************************************
	IS_COLUMN_DT_PART_OF_PK

	This function returns true if the passed input column part of key specified(as input)
  in the passed input table

in_TABLE_NAME - specifies the table name that needs to be verified for
in_COLUMN_NAME - specifies the column name that needs to be verified for
in_KEY_TYPE - specifies the key that needs to be verified for - 'P' => Primary Key

created : 09/04/2012 kdp CCN Project....
**********************************************************/
in_TABLE_NAME  IN VARCHAR2,
in_COLUMN_NAME IN VARCHAR2,
in_KEY_TYPE    IN VARCHAR2) RETURN BOOLEAN IS
   V_COUNT NUMBER := 0;
BEGIN
   SELECT COUNT(*) INTO V_COUNT
     FROM all_constraints cons,
          all_cons_columns cols
    WHERE cons.constraint_type = upper(in_KEY_TYPE)
      AND cols.table_name      = upper(in_TABLE_NAME)
      AND cols.column_name     = upper(in_COLUMN_NAME)
      AND cons.constraint_name = cols.constraint_name
      AND cons.owner           = cols.owner
      AND cols.owner           = 'COSTCNTR';

   IF V_COUNT = 1 THEN
      RETURN TRUE;
   ELSE
      RETURN FALSE;
   END IF;
EXCEPTION
   WHEN OTHERS THEN
      RETURN FALSE;
END IS_COLUMN_PART_OF_KEY;

FUNCTION GET_HRCHY_DTL_LEVEL
/**********************************************************
this function gets the hierarchy detail level based on header value passed 
using 'HIERARCHY_DESCRIPTION' table

created : 08/21/2012
**********************************************************/
(IN_HRCHY_HDR_NAME   IN   VARCHAR2)
RETURN VARCHAR2
IS
  L_RETURN_VALUE VARCHAR2(2) := 'XX';
BEGIN

  SELECT SUBSTR('00', 1,2 - LENGTH(HRCHY_HDR_LEVELS)) || HRCHY_HDR_LEVELS
    INTO L_RETURN_VALUE
    FROM HIERARCHY_HEADER
   WHERE UPPER(HRCHY_HDR_NAME) = UPPER(IN_HRCHY_HDR_NAME);

  RETURN L_RETURN_VALUE;

EXCEPTION
  WHEN OTHERS THEN
    RETURN L_RETURN_VALUE;
END GET_HRCHY_DTL_LEVEL;

PROCEDURE EXTRACT_ATTRIBUTES_XML(
/**********************************************************
EXTRACT_ATTRIBUTES_XML

This procedure will accept the XMLTYPE Previous Table_Row & Current Table_Row values
Then start extracting the attributes from those and compare before assigning those
to the in out parameters

created : 02/05/2014 jxc517 CCN Project Team
Changed : 11/03/2015 axk326 CCN Project Team
          Replaced call to COMMON_TOOLS.ELIMINATE_SPECIAL_CHRCTRS with HANDLE_SPECIAL_CHRCTRS 
          to handle special characters while writing into audit backfeed file
**********************************************************/
    IN_XMLSTRING              IN     XMLTYPE,
    OUT_ATTRIBUTE_XML            OUT XMLTYPE)
IS
BEGIN
    --Below code should not fail as historical data prior to CCN 2.0 release 
    --doesn't contain <ATTRIBUTES> tag in which case below code throws exception
    --Extract the attribute values from the input XMLTYPE Previous Table_Row
    IF IN_XMLSTRING.EXTRACT('//'||V_ATRIBUTE_TAG_VALUE) IS NOT NULL THEN
        OUT_ATTRIBUTE_XML := SYS.XMLTYPE(HANDLE_SPECIAL_CHRCTRS(
                                       IN_XMLSTRING.extract('//'||V_ATRIBUTE_TAG_VALUE).GETSTRINGVAL()));
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        OUT_ATTRIBUTE_XML := NULL;
END EXTRACT_ATTRIBUTES_XML;

PROCEDURE EXTRACT_ATTRIBUTE_NAME_VALUE(
/**********************************************************
EXTRACT_ATTRIBUTE_NAME_VALUE

This procedure will accept the XMLTYPE and estracts the name and value out of it

created : 02/05/2014 jxc517 CCN Project Team

**********************************************************/
    IN_HRCHY_HDR_NAME         IN     HIERARCHY_DETAIL.HRCHY_HDR_NAME%TYPE,
    IN_XMLSTRING              IN     XMLTYPE,
    IN_ATTRIBUTE_COUNT        IN     NUMBER,
    OUT_ATTRIBUTE_NAME           OUT VARCHAR2,
    OUT_ATTRIBUTE_VALUE          OUT VARCHAR2)
IS
BEGIN

    --check if the attribute name exists
    IF (IN_XMLSTRING.EXISTSNODE('/'||V_ATRIBUTE_TAG_VALUE||'/upper_lvl_ver_desc' || '[' || IN_ATTRIBUTE_COUNT || ']/Name/text()') = 1) THEN
        --Get the attribute name
        OUT_ATTRIBUTE_NAME := IN_XMLSTRING.EXTRACT('/'||V_ATRIBUTE_TAG_VALUE||'/upper_lvl_ver_desc' || '[' || IN_ATTRIBUTE_COUNT || ']/Name/text()').GETSTRINGVAL();
        OUT_ATTRIBUTE_NAME := UPPER(REPLACE(OUT_ATTRIBUTE_NAME,' ','_'));
    END IF;

    --check if the attribute value exists
    IF (IN_XMLSTRING.EXISTSNODE('/'||V_ATRIBUTE_TAG_VALUE||'/upper_lvl_ver_desc' || '[' || IN_ATTRIBUTE_COUNT || ']/Value/text()') = 1) THEN
        --Get the attribute value
        OUT_ATTRIBUTE_VALUE := TRIM(IN_XMLSTRING.EXTRACT('/'||V_ATRIBUTE_TAG_VALUE||'/upper_lvl_ver_desc' || '[' || IN_ATTRIBUTE_COUNT || ']/Value/text()').GETSTRINGVAL());
    END IF;

    --Special conditions for existing attributes before CCN 2.0 release
    IF OUT_ATTRIBUTE_NAME IN ('MANAGERNAME')  
        AND IN_HRCHY_HDR_NAME IN ('ADMIN_TO_SALES_AREA','ADMIN_TO_SALES_DISTRICT','ADMIN_TO_SALES_DIVISION')THEN
        OUT_ATTRIBUTE_NAME := 'EMPLOYEE_NAME';
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        OUT_ATTRIBUTE_NAME  := NULL;
        OUT_ATTRIBUTE_VALUE := NULL;
END EXTRACT_ATTRIBUTE_NAME_VALUE;

PROCEDURE EXTRACT_HST_ATTRIBUTE_VALUE(
/**********************************************************
EXTRACT_HST_ATTRIBUTE_VALUE

This procedure will accept the XMLTYPE Previous Table_Row & Current Table_Row values
Then start extracting the attributes from those and compare before assigning those
to the in out parameters

created : 02/05/2014 jxc517 CCN Project Team

**********************************************************/
    IN_CURRENT_ATTRIBUTE_NAME IN     VARCHAR2,
    IN_XMLSTRING              IN     XMLTYPE,
    OUT_ATTRIBUTE_VALUE          OUT VARCHAR2)
IS
BEGIN
    --Prior to CCN 2.0 release we used to store the extracted attributes in audit_log table
    --As part of CCN 2.0 release we will be storing the entire attribute values itseld in audit_log table
    --So if the new extraction didn't fetch anything we need to go for the old extraction as well
    IF IN_XMLSTRING IS NOT NULL THEN
        --Logic to extract old Statement Type or statement_type and old Manager Id or managername attributes
        IF CCN_AUDIT_PKG.XML_EXTRACT_NO_EXCEPTION(IN_XMLSTRING,'//'||IN_CURRENT_ATTRIBUTE_NAME) IS NOT NULL THEN
            OUT_ATTRIBUTE_VALUE := TRIM(CCN_AUDIT_PKG.XML_EXTRACT_NO_EXCEPTION(IN_XMLSTRING,'//'||IN_CURRENT_ATTRIBUTE_NAME));
        END IF;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        OUT_ATTRIBUTE_VALUE := NULL;
END EXTRACT_HST_ATTRIBUTE_VALUE;

FUNCTION GET_MANAGER_NAME(
/**********************************************************
GET_MANAGER_NAME

This function will return the manager name for the passed gems id as required by backfeed

created : 10/08/2014 jxc517 CCN Project Team
modified: 
**********************************************************/
IN_GEMS_ID        EMPLOYEE_DETAILS.EMPLOYEE_NUMBER%TYPE) RETURN VARCHAR2
IS
    V_RETURN_VALUE VARCHAR2(400) := RPAD(' ', 362, ' ');
BEGIN
    SELECT RPAD(NVL(LAST_NAME,' '),150,' ') 
           || ' ' ||
           RPAD(NVL(FIRST_NAME,' '),150,' ') 
           || ' ' || 
           RPAD(NVL(MIDDLE_INITIAL,' '),60,' ')
      INTO V_RETURN_VALUE
      FROM EMPLOYEE_DETAILS
     WHERE EMPLOYEE_NUMBER = IN_GEMS_ID;
    RETURN V_RETURN_VALUE;
EXCEPTION
    WHEN OTHERS THEN
        RETURN V_RETURN_VALUE;
END GET_MANAGER_NAME;

FUNCTION GET_JOB_TITLE(
/**********************************************************
GET_JOB_TITLE

This function will return the Job Title for the passed gems id as required by backfeed

created : 07/23/2015 CCN Project Team....
modified: 
**********************************************************/
IN_GEMS_ID        EMPLOYEE_DETAILS.EMPLOYEE_NUMBER%TYPE) RETURN VARCHAR2
IS
    V_RETURN_VALUE VARCHAR2(20);
BEGIN
    SELECT UPPER(JOB_TITLE)
      INTO V_RETURN_VALUE
      FROM EMPLOYEE_DETAILS
     WHERE EMPLOYEE_NUMBER = IN_GEMS_ID;
    RETURN V_RETURN_VALUE;
EXCEPTION
    WHEN OTHERS THEN
        RETURN V_RETURN_VALUE;
END GET_JOB_TITLE;

FUNCTION IS_GLBL_SIX_LVL_SPCL_ATTRBTS(
/**********************************************************
IS_GLBL_SIX_LVL_SPCL_ATTRBTS

This function will specify if the passed record is of GLOBAL_HIERARCHY
with 6th level and the current iterating attribute is MANAGERNAME or GEMS_ID

created : 10/10/2014 jxc517 CCN Project Team
modified: 
**********************************************************/
IN_HRCHY_HDR_NAME        VARCHAR2,
IN_HRCHY_DTL_LEVEL       VARCHAR2,
IN_CURR_ATTRIBUTE_NAME   VARCHAR2) RETURN VARCHAR2
IS
    V_RETURN_VALUE VARCHAR2(1) := 'N';
BEGIN
    IF IN_HRCHY_HDR_NAME                 = 'GLOBAL_HIERARCHY'
       AND IN_HRCHY_DTL_LEVEL            = '06'
       AND UPPER(IN_CURR_ATTRIBUTE_NAME) IN ('MANAGERNAME','GEMS_ID') THEN
        V_RETURN_VALUE := 'Y';
    END IF;
    RETURN V_RETURN_VALUE;
EXCEPTION
    WHEN OTHERS THEN
        RETURN V_RETURN_VALUE;
END IS_GLBL_SIX_LVL_SPCL_ATTRBTS;

PROCEDURE GLBL_SIX_LVL_SPCL_ATTRBS_HNDLN(
/**********************************************************
GLBL_SIX_LVL_SPCL_ATTRBS_HNDLN

This proedure handles the GLOBAL_HIERARCHY
with 6th level and the current iterating attribute is MANAGERNAME or GEMS_ID

created : 10/13/2014 jxc517 CCN Project Team
modified: 03/12/2015 jxc517 CCN Project Team
          GEMS_ID should be left padded with 0's instead of right padded with spaces
        : 03/16/2015 jxc517 CCN Project Team
          GEMS_ID should be left padded with 9's for records without GEMS_ID
**********************************************************/
    IN_CURRENT_ATTRIBUTE_NAME   IN     VARCHAR2,
    IN_COMP_CURR_ATTRIBUTES     IN     XMLTYPE,
    IN_COMP_PREV_ATTRIBUTES     IN     XMLTYPE,
    IN_OUT_XMLSTRING            IN OUT LONG)
IS
    V_CURR_ATTRIBUTE_VALUE     VARCHAR2(1000);
    V_PREV_GEMS_ID             EMPLOYEE_DETAILS.EMPLOYEE_NUMBER%TYPE;
    V_CURR_GEMS_ID             EMPLOYEE_DETAILS.EMPLOYEE_NUMBER%TYPE;
BEGIN
    --If GEMS_ID changes, ManagerName should change, so skip GEMS_ID attribute completely for global 6th evel
    IF UPPER(IN_CURRENT_ATTRIBUTE_NAME) <> 'GEMS_ID' THEN
        CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(IN_COMP_CURR_ATTRIBUTES,
                                                'GEMS_ID',
                                                V_CURR_GEMS_ID);
        IF IN_COMP_PREV_ATTRIBUTES IS NOT NULL THEN
            CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(IN_COMP_PREV_ATTRIBUTES,
                                                    'GEMS_ID',
                                                    V_PREV_GEMS_ID);
        END IF;
        IF V_CURR_GEMS_ID IS NULL THEN --gems id is not set-up => pass gems_id left padded with 9's and manager name as 362 spaces
            V_CURR_ATTRIBUTE_VALUE := LPAD(NVL(V_CURR_GEMS_ID,'9'),7,'9') || ' ' || GET_MANAGER_NAME(V_CURR_GEMS_ID);
        ELSE
            IF NVL(V_CURR_GEMS_ID,'A') <> NVL(V_PREV_GEMS_ID,'A') THEN --gems id is changed => pass gems_id left padded with 0's + manager name
                V_CURR_ATTRIBUTE_VALUE := LPAD(NVL(V_CURR_GEMS_ID,'0'),7,'0') || ' ' || GET_MANAGER_NAME(V_CURR_GEMS_ID);
            ELSE --gems id is NOT changed => pass gems_id as 7 spaces + manager name
                V_CURR_ATTRIBUTE_VALUE := LPAD(' ',7,' ') || ' ' || GET_MANAGER_NAME(V_CURR_GEMS_ID);
            END IF;
        END IF;
        IN_OUT_XMLSTRING := IN_OUT_XMLSTRING || '<EMPLOYEE_NAME>' || NVL(V_CURR_ATTRIBUTE_VALUE,'~') ||'</EMPLOYEE_NAME>';
    END IF;
END GLBL_SIX_LVL_SPCL_ATTRBS_HNDLN;

PROCEDURE PARSE_DIFFERENCE_ATTRBTS_XML(
/**********************************************************
PARSE_DIFFERENCE_ATTRBTS_XML

This procedure will accept the XMLTYPE Previous Table_Row & Current Table_Row values
Then start extracting the attributes from those and compare before assigning those
to the in out xml string

created : 02/05/2014 jxc517 CCN Project Team
modified: 10/08/2014 jxc517 CCN Project Team
          GEMS_ID should be used to get the manager name for 6th level of global_hierarchy
**********************************************************/
    IN_COMP_CURR     IN     XMLTYPE,
    IN_COMP_PREV     IN     XMLTYPE,
    IN_OUT_XMLSTRING IN OUT LONG)
IS
    V_COMP_CURR_ATTRIBUTES     XMLTYPE;
    V_COMP_PREV_ATTRIBUTES     XMLTYPE;
    V_CURR_COUNT               NUMBER := 1;
    V_PREV_COUNT               NUMBER := 1;
    V_CURR_ATTRIBUTE_NAME      VARCHAR2(200);
    V_PREV_ATTRIBUTE_NAME      VARCHAR2(200);
    V_CURR_ATTRIBUTE_VALUE     VARCHAR2(1000);
    V_PREV_ATTRIBUTE_VALUE     VARCHAR2(1000);
    V_HRCHY_HDR_NAME           HIERARCHY_DETAIL.HRCHY_HDR_NAME%TYPE;
    V_HRCHY_DTL_LEVEL          HIERARCHY_DETAIL.HRCHY_DTL_LEVEL%TYPE;
BEGIN

    --Get the Hierarchy Header Name used later in EXTRACT_ATTRIBUTE_NAME_VALUE procedure
    V_HRCHY_HDR_NAME  := NVL(XML_EXTRACT_NO_EXCEPTION(IN_COMP_CURR,'//HRCHY_HDR_NAME'),'~');
    V_HRCHY_DTL_LEVEL := NVL(XML_EXTRACT_NO_EXCEPTION(IN_COMP_CURR,'//HRCHY_DTL_LEVEL'),'~');
    
    EXTRACT_ATTRIBUTES_XML(IN_COMP_CURR, V_COMP_CURR_ATTRIBUTES);

    IF V_COMP_CURR_ATTRIBUTES IS NOT NULL THEN
        --Loop through the Current record attributes
        WHILE V_COMP_CURR_ATTRIBUTES.EXISTSNODE('/'||V_ATRIBUTE_TAG_VALUE||'/upper_lvl_ver_desc' || '[' || V_CURR_COUNT || ']') = 1 LOOP
            EXTRACT_ATTRIBUTE_NAME_VALUE(V_HRCHY_HDR_NAME, V_COMP_CURR_ATTRIBUTES, V_CURR_COUNT, V_CURR_ATTRIBUTE_NAME, V_CURR_ATTRIBUTE_VALUE);

            EXTRACT_ATTRIBUTES_XML(IN_COMP_PREV, V_COMP_PREV_ATTRIBUTES);

            --Get previous attribute name and value, if one exists
            IF V_COMP_PREV_ATTRIBUTES IS NOT NULL THEN
                --Loop through the Previous record attributes
                WHILE V_COMP_PREV_ATTRIBUTES.EXISTSNODE('/'||V_ATRIBUTE_TAG_VALUE||'/upper_lvl_ver_desc' || '[' || V_PREV_COUNT || ']') = 1 LOOP
                    EXTRACT_ATTRIBUTE_NAME_VALUE(V_HRCHY_HDR_NAME, V_COMP_PREV_ATTRIBUTES, V_PREV_COUNT, V_PREV_ATTRIBUTE_NAME, V_PREV_ATTRIBUTE_VALUE);

                    IF V_CURR_ATTRIBUTE_NAME = V_PREV_ATTRIBUTE_NAME THEN
                        --Exit out the loop if a match is found, as we got required previoius attribute value
                        EXIT;
                    END IF;
                    
                    --Increment the loop count to avoid INFINITE loop
                    V_PREV_COUNT := V_PREV_COUNT + 1;

                    --If came here => attribute name doesn't match for this iteration
                    --If not set this, then the final iteration attribute value will be used in below comparision which is wrong
                    V_PREV_ATTRIBUTE_VALUE := NULL;
                END LOOP;
                
                --Reset the previous count to 1 for next outer iteration
                V_PREV_COUNT := 1;
            ELSE
                --Extracts attribute name and value if not found using CCN 2.0 release logic
                EXTRACT_HST_ATTRIBUTE_VALUE(V_CURR_ATTRIBUTE_NAME, IN_COMP_PREV, V_PREV_ATTRIBUTE_VALUE);
            END IF;

            --Compare current attribute value with previous attribute value
            --If different then only it should go into audit file
            IF IS_GLBL_SIX_LVL_SPCL_ATTRBTS(V_HRCHY_HDR_NAME, V_HRCHY_DTL_LEVEL, V_CURR_ATTRIBUTE_NAME) = 'Y' THEN
                GLBL_SIX_LVL_SPCL_ATTRBS_HNDLN(V_CURR_ATTRIBUTE_NAME, V_COMP_CURR_ATTRIBUTES, V_COMP_PREV_ATTRIBUTES, IN_OUT_XMLSTRING);
            ELSE        
                IF NVL(V_CURR_ATTRIBUTE_VALUE,'A') <> NVL(V_PREV_ATTRIBUTE_VALUE,'A') 
                   AND V_CURR_ATTRIBUTE_NAME IS NOT NULL THEN
                    IN_OUT_XMLSTRING := IN_OUT_XMLSTRING || '<' || V_CURR_ATTRIBUTE_NAME || '>' || NVL(V_CURR_ATTRIBUTE_VALUE,'~') ||'</' || V_CURR_ATTRIBUTE_NAME || '>';
                END IF;
            END IF;
            
            --Increment the loop count to avoid INFINITE loop
            V_CURR_COUNT := V_CURR_COUNT + 1;
        END LOOP;
    ELSE
        --Old method of extraction [prior to CCN 2.0 release logic]
        FOR REC IN (SELECT COLUMN_NAME 
                     FROM CCN_ADDITIONAL_AUDIT_FIELDS
                    WHERE TABLE_NAME = 'HIERARCHY_DETAIL'
                      AND COLUMN_NAME IN ('STATEMENT_TYPE','EMPLOYEE_NAME')) LOOP

            EXTRACT_HST_ATTRIBUTE_VALUE(REC.COLUMN_NAME, IN_COMP_CURR, V_CURR_ATTRIBUTE_VALUE);

            EXTRACT_HST_ATTRIBUTE_VALUE(REC.COLUMN_NAME, IN_COMP_PREV, V_PREV_ATTRIBUTE_VALUE);

            --Compare current attribute value with previous attribute value
            --If different then only it should go into audit file
            IF NVL(V_CURR_ATTRIBUTE_VALUE,'A') <> NVL(V_PREV_ATTRIBUTE_VALUE,'A') THEN
                IN_OUT_XMLSTRING := IN_OUT_XMLSTRING || '<' || REC.COLUMN_NAME || '>' || NVL(V_CURR_ATTRIBUTE_VALUE,'~') ||'</' || REC.COLUMN_NAME || '>';
            END IF;
        END LOOP;
    END IF;
END PARSE_DIFFERENCE_ATTRBTS_XML;

PROCEDURE UPDATE_AUDIT_REC_FLAG(
/*******************************************************
UPDATE_AUDIT_REC_FLAG
Procedure to update AUDIT_REC_FLAG column of AUDIT_LOG tablw

Author   : jxc517 CCN Project Team
created : 02/07/2014
*******************************************************/
IN_TABLE_NAME     IN     VARCHAR2,
IN_KEY            IN     VARCHAR2,
IN_LOG_ID_PREV    IN     AUDIT_LOG.LOG_ID%TYPE,
IN_LOG_ID_CURR    IN     AUDIT_LOG.LOG_ID%TYPE,
OUT_CONTEXT          OUT VARCHAR2)
IS
BEGIN
    OUT_CONTEXT := 'Updating the PREV AUDIT_REC_FLAG to C';
    UPDATE AUDIT_LOG
       SET AUDIT_REC_FLAG     = 'C',
           AUDIT_REC_EFF_DATE = SYSDATE
     WHERE TABLE_NAME     = IN_TABLE_NAME
       AND LOG_ID         = IN_LOG_ID_PREV
       AND TRANSACTION_ID = IN_KEY
       AND AUDIT_REC_FLAG = 'R';

    OUT_CONTEXT := 'Updating the CURR AUDIT_REC_FLAG to R';
    UPDATE AUDIT_LOG
       SET AUDIT_REC_FLAG = 'R'
     WHERE TABLE_NAME     = IN_TABLE_NAME
       AND LOG_ID         = IN_LOG_ID_CURR
       AND TRANSACTION_ID = IN_KEY
       AND AUDIT_REC_FLAG IS NULL;
--Exceptions handled in calling procedure
END UPDATE_AUDIT_REC_FLAG;

PROCEDURE GET_COST_CENTER_CODE(
/*******************************************************
GET_COST_CENTER_CODE
Procedure to get the COST_CENTER_CODE of the iteration

Author   : jxc517 CCN Project Team
created : 02/07/2014
*******************************************************/
IN_COLUMN_NAME          IN     VARCHAR2,
IN_ROW_CURR             IN     AUDIT_LOG.TABLE_ROW_DATA%TYPE,
IN_COMP_CURR            IN     VARCHAR2,
IN_OUT_COST_CENTER_CODE IN OUT VARCHAR2)
IS
    V_HRCHY_DTL_LEVEL   HIERARCHY_DETAIL.HRCHY_DTL_LEVEL%TYPE;
    V_HRCHY_HDR_NAME    HIERARCHY_DETAIL.HRCHY_HDR_NAME%TYPE;
BEGIN
    --Should not over write if the value already fetched
    IF IN_OUT_COST_CENTER_CODE IS NULL THEN
        IF IN_COLUMN_NAME = 'COST_CENTER_CODE' THEN
            IN_OUT_COST_CENTER_CODE := IN_COMP_CURR;
        ELSIF IN_COLUMN_NAME = 'HRCHY_DTL_CURR_ROW_VAL' THEN
            V_HRCHY_DTL_LEVEL := NVL(XML_EXTRACT_NO_EXCEPTION(IN_ROW_CURR,'//HRCHY_DTL_LEVEL'),'~');
            V_HRCHY_HDR_NAME  := NVL(XML_EXTRACT_NO_EXCEPTION(IN_ROW_CURR,'//HRCHY_HDR_NAME'),'~');
            IF V_HRCHY_DTL_LEVEL = GET_HRCHY_DTL_LEVEL(V_HRCHY_HDR_NAME) THEN
                --Only for the final level of the hierarchy header we need to populate the Cost Center
                IN_OUT_COST_CENTER_CODE := IN_COMP_CURR;
            END IF;
        END IF;
    END IF;
--Exceptions handled in calling procedure
END GET_COST_CENTER_CODE;

PROCEDURE EMP_MGR_TERRITORY_AUDIT_SP( 
/*******************************************************
Procedure to create two lines in the Backfeed file for
MANAGER_EMPLOYEE and TERRITORY_EMPLOYEE if a Cost Center
or Employee Status changes

1) If cost center changes send it as delete(D) for old record, add(A) for new record
2) If status changes to TERM (Terminated) send it as delete(D) alone
3) If its a new record send it as add(A) alone, except if the new records status is
TERM(Terminated) in which case exit out of procedure doing/returning nothing
4) All other scenarios it should go as (C)
5) Add(A) should go with TERM_DATE as 00000000

Author  : sxh487 CCN Project Team
created : 09/03/2014
Modified: 02/05/2015 jxc517 CCN Project...
        : 03/03/2015 dxv848 Sending the job_type whenever the employee information changes.
        : 03/11/2015 dxv848 Sending the cost_center_code along with Job_type whenever the employee information changes.
        : 03/31/2015 sxh487 Rules for the Territory and Manager Emps 
            1)For Territory_Employee - If category changes from T to anything else send it as delete(D) for Territory_Employee
            2)For Manager_Employee - If category changes from S to anything else or If job title changes from %Mgr% to anything else
              send it as delete(D) for Manager_Employee
        : 07/13/2015 dxv848 added the rule. If Term_date is updated then send is as delete(D) for the Territory_employee.
        : 08/03/2015 axk326 added the following rules to not to send in the audit backfeed file:
                   1)Do not send an employee for territories with a status of LOA - (leave of absent) 
                   2)Do not send If the 'rep' is terminated previously - and the only cange we get is a change in "TERMINATION date" 
        : 08/07/2015 axk326 added the condition to rule out employees whose status is "Term"
        : 10/27/2015 nxk927 added the condition to rule out employees whose prev EMP_PAYROLL_STATUS and current EMP_PAYROLL_STATUS is "Term"
        : 11/03/2015 axk326 CCN Project Team
          Replaced call to COMMON_TOOLS.ELIMINATE_SPECIAL_CHRCTRS with HANDLE_SPECIAL_CHRCTRS to handle special characters while writing into audit backfeed file
        : 11/24/2015 axk326 CCN Project Team
          Added condition to check if the IN_ROW_PREV is not NULL (If the record comes into AUDIT_LOG table for the first time)
*******************************************************/
IN_COST_CENTER  IN  COST_CENTER.COST_CENTER_CODE%TYPE
,IN_TABLE_NAME   IN  VARCHAR2
,IN_LOG_ID_PREV  IN  NUMBER
,IN_LOG_ID_CURR  IN  NUMBER
,IN_DIFF_XML     IN  SYS.XMLTYPE   --diff xml
,IN_ROW_PREV     IN  SYS.XMLTYPE   --Previous Row from Audit_Log        
,IN_ROW_CURR     IN  SYS.XMLTYPE   --Current Row from Audit_Log
,OUT_CLOB        OUT CLOB
)
AS
V_OUT_CLOB             CLOB;
V_OUT_CLOB1            CLOB;
V_OUT_CLOB2            CLOB;
V_EMP_STATUS_CURR      MANAGER_EMPLOYEE.EMP_PAYROLL_STATUS%TYPE;
V_EMP_STATUS_PREV      MANAGER_EMPLOYEE.EMP_PAYROLL_STATUS%TYPE;
V_CC_PREV              MANAGER_EMPLOYEE.COST_CENTER_CODE%TYPE;
V_CC_CURR              MANAGER_EMPLOYEE.COST_CENTER_CODE%TYPE; 
V_VALUE_PREV           VARCHAR2(32000);
V_VALUE_CURR           VARCHAR2(32000);
V_EXTRD_VAL_PREV       VARCHAR2(32000);
V_EXTRD_VAL_CURR       VARCHAR2(32000);
V_TDATE_CURR           VARCHAR2(8); 
V_TDATE_PREV           VARCHAR2(8); 
V_GEMS_ID_CURR         VARCHAR2(8);

V_CURR_AUD_REC_STATUS  VARCHAR2(1);
V_CONTEXT              VARCHAR2(200);
V_CURR_GEMS_ID         TERRITORY_EMPLOYEE.GEMS_ID_NUMBER%TYPE;

CURSOR table_fields_cur IS
  SELECT COLUMN_NAME,
         DECODE(DATA_TYPE, 'DATE', 8, DATA_LENGTH) COLUMN_SIZE,
         DATA_TYPE,
         COLUMN_ID
    FROM ALL_TAB_COLUMNS
   WHERE TABLE_NAME = IN_TABLE_NAME
   ORDER BY COLUMN_ID ASC;

BEGIN
    
      V_EMP_STATUS_CURR := NVL(XML_EXTRACT_NO_EXCEPTION(IN_ROW_CURR,'//' || 'EMP_PAYROLL_STATUS'), '~');
    IF IN_ROW_PREV IS NOT NULL THEN
      V_EMP_STATUS_PREV := NVL(XML_EXTRACT_NO_EXCEPTION(IN_ROW_PREV,'//' || 'EMP_PAYROLL_STATUS'), '~');
    END IF;       
    IF UPPER(NVL(V_EMP_STATUS_CURR,'~')) IN ('LEAVE') THEN
        --Employee status is Leave(Leave of Absent), exit out
        RETURN;
    END IF;
    IF (UPPER(NVL(V_EMP_STATUS_CURR,'~')) = 'TERM'
       and UPPER(NVL(V_EMP_STATUS_PREV,'~')) = 'TERM') THEN
        --Prevoius and current Employee status is Term(Terminated) then exit out
        RETURN;
    END IF;
	
    V_CC_CURR         := NVL(XML_EXTRACT_NO_EXCEPTION(IN_ROW_CURR,'//' || 'COST_CENTER_CODE'), '~');
    V_TDATE_CURR      := NVL(XML_EXTRACT_NO_EXCEPTION(IN_ROW_CURR,'//' || 'TERM_DATE'), '~');
    V_GEMS_ID_CURR    := NVL(XML_EXTRACT_NO_EXCEPTION(IN_ROW_CURR,'//' || 'GEMS_ID_NUMBER'), '~');
    
    IF IN_ROW_PREV IS NULL THEN --First record, which should go as an Add(A)
        V_CURR_AUD_REC_STATUS := 'A';
    ELSE --NOT the first record, which should go as a Delete(D)/Delete(D) and Add(D)/Change(C)
        --  If the rep is terminated previously - and the only change we get is a change in TERMINATION date, exit out
        V_TDATE_PREV := NVL(XML_EXTRACT_NO_EXCEPTION(IN_ROW_PREV,'//' || 'TERM_DATE'), '~');
        IF(GET_JOB_TITLE(V_GEMS_ID_CURR) = 'REP' AND V_TDATE_CURR IS NOT NULL AND NVL(V_TDATE_PREV,'~') <> NVL(V_TDATE_CURR,'~')) THEN
           RETURN;
        END IF;
        IF UPPER(NVL(V_EMP_STATUS_CURR,'~')) = 'TERM' OR --Status changed to TERM(Terminated), which should go as delete(D)
           ( IN_TABLE_NAME = 'TERRITORY_EMPLOYEE' AND NVL(V_TDATE_CURR,'~') <> '~') OR 
           XML_EXTRACT_NO_EXCEPTION(IN_ROW_CURR,'/'|| IN_TABLE_NAME ||'/UPD_TYPE') IS NOT NULL  THEN --checking if the upd_type tag is present for Delete
            V_CURR_AUD_REC_STATUS := 'D';
        ELSE
            V_CC_PREV := NVL(XML_EXTRACT_NO_EXCEPTION(IN_ROW_PREV,'//' || 'COST_CENTER_CODE'), '~');
            IF NVL(V_CC_PREV,'~') <> NVL(V_CC_CURR,'~') THEN --Cost center changed, which should go as delete(D) and add(A)
                V_OUT_CLOB1 := TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS')
                               || IN_COST_CENTER
                               || RPAD(IN_TABLE_NAME,25)
                               || TRIM(LPAD(IN_LOG_ID_PREV,14,'0'))
                               || 'D';
                 V_CURR_AUD_REC_STATUS := 'A';
             ELSE --Something else, which should go as change(C)
                 V_CURR_AUD_REC_STATUS := 'C';
             END IF;   
         END IF;

     END IF;

        V_OUT_CLOB2 := TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS')
                      || IN_COST_CENTER
                      || RPAD(IN_TABLE_NAME,25)
                      || TRIM(LPAD(IN_LOG_ID_CURR,14,'0'))
                      || V_CURR_AUD_REC_STATUS;

    FOR TABLE_FIELDS_REC IN TABLE_FIELDS_CUR LOOP
        V_CONTEXT        := 'Building V_OUT_CLOB2 with Current Record Data';
        V_EXTRD_VAL_CURR := NVL(XML_EXTRACT_NO_EXCEPTION(IN_ROW_CURR,'//' || TABLE_FIELDS_REC.COLUMN_NAME),'~');   
        IF V_OUT_CLOB1 IS NOT NULL THEN
        --Need to build two records, one with previoius record details and the other with current record details
            V_CONTEXT := 'Building V_OUT_CLOB1 with Previous Record Data';
            V_EXTRD_VAL_PREV := NVL(XML_EXTRACT_NO_EXCEPTION(IN_ROW_PREV,'//' || TABLE_FIELDS_REC.COLUMN_NAME),'~');
            V_EXTRD_VAL_PREV := NVL(HANDLE_SPECIAL_CHRCTRS(V_EXTRD_VAL_PREV), '~');
            V_VALUE_PREV     := UPPER(RPAD(V_EXTRD_VAL_PREV, NVL(TABLE_FIELDS_REC.COLUMN_SIZE,LENGTH(V_EXTRD_VAL_PREV))));
            V_OUT_CLOB1      := V_OUT_CLOB1 || V_VALUE_PREV;
        ELSE 
            IF V_CURR_AUD_REC_STATUS = 'C' THEN
                --EMP_JOB_CODE and COST_CENTER_CODE should go irrespective of any thing
                IF TABLE_FIELDS_REC.COLUMN_NAME IN ('EMP_JOB_CODE','COST_CENTER_CODE') THEN 
                    V_CONTEXT        := 'Building V_OUT_CLOB2 with Difference Record Data along with Job Code and CC code';
                    V_EXTRD_VAL_CURR := NVL(XML_EXTRACT_NO_EXCEPTION(IN_ROW_CURR,'//' || TABLE_FIELDS_REC.COLUMN_NAME),'~');
                ELSE 
                    V_CONTEXT        := 'Building V_OUT_CLOB2 with Difference Record Data along with Primary Key';
                    V_EXTRD_VAL_CURR := NVL(XML_EXTRACT_NO_EXCEPTION(IN_DIFF_XML,'//' || TABLE_FIELDS_REC.COLUMN_NAME),'~');
                END IF;
            END IF;
        END IF;
        V_EXTRD_VAL_CURR := NVL(HANDLE_SPECIAL_CHRCTRS(V_EXTRD_VAL_CURR), '~');
        V_VALUE_CURR     := UPPER(RPAD(V_EXTRD_VAL_CURR, NVL(TABLE_FIELDS_REC.COLUMN_SIZE,LENGTH(V_EXTRD_VAL_CURR))));
        IF V_CURR_AUD_REC_STATUS = 'A'
           AND TABLE_FIELDS_REC.COLUMN_NAME = 'TERM_DATE' THEN --If add(A), send 0's for the TERM_DATE fields
            V_VALUE_CURR := UPPER(RPAD('0',TABLE_FIELDS_REC.COLUMN_SIZE,'0'));
        END IF;
        V_OUT_CLOB2 := V_OUT_CLOB2 || V_VALUE_CURR;
    END LOOP;
    IF V_OUT_CLOB1 IS NOT NULL THEN
        OUT_CLOB := V_OUT_CLOB1 || CHR(10) ||V_OUT_CLOB2;
    ELSE
        OUT_CLOB := V_OUT_CLOB2;
    END IF;
END EMP_MGR_TERRITORY_AUDIT_SP;

PROCEDURE PARSE_DIFFERENCE_XML
/*******************************************************
Procedure to Parse xmls from the audit_log table and 
create an output xml with the differences

Author   : 

versions : 02/22/2012
modified : 02/07/2014 jxc517 CCN Project Team . . . 
modified : 03/06/2015 nxk927 CCN Project Team . . . 
           (sending zero's for closed date in audit if cc reopened)
modified : 08/05/2015 nxk927 CCN Project Team . . . 
           (sending job_type no matter what changes from the employee_admin_details)
*******************************************************/

( IN_TABLE_NAME IN VARCHAR2
, IN_KEY        IN VARCHAR2
, OUT_CC_CODE 	OUT VARCHAR2
, OUT_CHANGE_TYPE OUT VARCHAR2
, OUT_PREV_ROW    OUT XMLTYPE
, OUT_CURR_ROW    OUT XMLTYPE
, OUT_DIFF OUT XMLTYPE
, OUT_LOG_ID_PREV OUT NUMBER
, OUT_LOG_ID OUT NUMBER
)

IS

ROW_CURR	          AUDIT_LOG.TABLE_ROW_DATA%TYPE;
V_LOG_ID_CURR       AUDIT_LOG.LOG_ID%TYPE;
ROW_PREV	          AUDIT_LOG.TABLE_ROW_DATA%TYPE;
PK_CURR             AUDIT_LOG.TABLE_PK_VALUE%TYPE;
V_LOG_ID_PREV       AUDIT_LOG.LOG_ID%TYPE;
V_CONTEXT	          VARCHAR2(200);
V_COSTCENTERCODE    COST_CENTER.COST_CENTER_CODE%TYPE;
v_change_type       VARCHAR2(1);
COMP_CURR           VARCHAR2(1000);
COMP_PREV	          VARCHAR2(1000);
XMLSTRING	          CLOB:='';
SQ		              INTEGER; 
SE		              VARCHAR2(1000);

V_ROW_PREV	           AUDIT_LOG.TABLE_ROW_DATA%TYPE := NULL;
V_ROW_CURR	           AUDIT_LOG.TABLE_ROW_DATA%TYPE := NULL;
V_PREVIOUS_STATUS_CODE STATUS.STATUS_CODE%TYPE;
V_CURRENT_STATUS_CODE  STATUS.STATUS_CODE%TYPE;
V_CC_CODE              COST_CENTER.COST_CENTER_CODE%TYPE;
V_PREV_REC             VARCHAR2(1000);
V_CURR_REC             VARCHAR2(1000); 

CURSOR GET_COLS (IN_TABLE IN VARCHAR2) IS
    SELECT COLUMN_NAME, COLUMN_ID FROM ALL_TAB_COLUMNS WHERE TABLE_NAME = IN_TABLE;

BEGIN

    V_CONTEXT := 'Selecting Previous Row from Audit_Log';
    BEGIN
        SELECT TABLE_ROW_DATA, LOG_ID INTO ROW_PREV, V_LOG_ID_PREV
          FROM AUDIT_LOG AL,
               BATCH_JOB BATCH
         WHERE AL.TABLE_NAME        = IN_TABLE_NAME
           AND BATCH.BATCH_JOB_NAME = 'BACKFEED_AUDIT_LOG'
           --AND TRUNC(BATCH.BATCH_JOB_LAST_RUN_DATE) = TRUNC(AL.AUDIT_REC_EFF_DATE)
           AND AL.AUDIT_REC_FLAG    = 'R'
           AND AL.TRANSACTION_ID    = IN_KEY
           AND AL.TRANSACTION_DATE IN (SELECT MAX(AL1.TRANSACTION_DATE)
                                         FROM AUDIT_LOG AL1
                                        WHERE AL1.TABLE_NAME     = AL.TABLE_NAME
                                          AND AL1.TRANSACTION_ID = IN_KEY
                                          AND AL1.AUDIT_REC_FLAG = 'R')
           AND BATCH.BATCH_JOB_LAST_RUN_DATE IN(SELECT MAX(B1.BATCH_JOB_LAST_RUN_DATE)
                                                  FROM BATCH_JOB B1
                                                 WHERE B1.BATCH_JOB_NAME= 'BACKFEED_AUDIT_LOG')
           AND ROWNUM < 2
         ORDER BY AL.LOG_ID DESC;

        V_CHANGE_TYPE := 'C';
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            v_change_type := 'A';
    END;

    V_CONTEXT := 'Selecting Current Row from Audit_Log';
    SELECT TABLE_ROW_DATA, LOG_ID, TABLE_PK_VALUE INTO ROW_CURR, V_LOG_ID_CURR, PK_CURR -- Added to accomodate population of primary key columns in backFeed files generated
      FROM AUDIT_LOG AL
     WHERE TABLE_NAME        = IN_TABLE_NAME
       AND AL.TRANSACTION_ID = IN_KEY
       AND AL.TRANSACTION_DATE IN (SELECT MAX(AL1.TRANSACTION_DATE)
                                     FROM AUDIT_LOG AL1
                                    WHERE AL1.TABLE_NAME     = AL.TABLE_NAME
                                      AND AL1.TRANSACTION_ID = IN_KEY)
       AND AL.LOG_ID = (SELECT MAX( AL2.LOG_ID)
                          FROM	AUDIT_LOG AL2
                         WHERE AL2.TABLE_NAME = AL.TABLE_NAME
                           AND AL2.TRANSACTION_ID = IN_KEY)
       AND ROWNUM < 2;

    V_CONTEXT := 'Parsing the XMLType';
    --Start building the XML string
    XMLSTRING := '<' || IN_Table_name || ' xmlns:xsi="http://www.w3.org/2001/XMLSchema" xsi:nonamespaceSchemaLocation="http://www.oracle.com/Employee.xsd">';
    FOR GET_COLS_REC IN GET_COLS(IN_TABLE_NAME) LOOP
        /*The function XML_EXTRACT_NO_EXCEPTION is used, it uses the extract function on the xmltype like given below
        p_xml.extract(p_xpath || '/text()').getstringval() */
        IF V_CHANGE_TYPE = 'C' THEN
            COMP_PREV := XML_EXTRACT_NO_EXCEPTION(ROW_PREV,'//' || GET_COLS_REC.COLUMN_NAME);
        END IF; 
        COMP_CURR := NVL(XML_EXTRACT_NO_EXCEPTION(ROW_CURR,'//' || GET_COLS_REC.COLUMN_NAME),'~');
           
        IF IN_TABLE_NAME || ' - ' || GET_COLS_REC.COLUMN_NAME = 'COST_CENTER - CLOSE_DATE'  THEN
           IF V_CHANGE_TYPE = 'C' THEN        
              V_PREV_REC := NVL(XML_EXTRACT_NO_EXCEPTION(ROW_PREV,'//' || 'CLOSE_DATE'), 'ZZ');
           END IF;
           V_CURR_REC := NVL(XML_EXTRACT_NO_EXCEPTION(ROW_CURR,'//' || 'CLOSE_DATE'), 'YY');
           IF V_PREV_REC <> 'ZZ'
              AND V_CURR_REC = 'YY'  THEN 
            COMP_CURR := '00000000';
           END IF;
        END IF;
   
        --Get the cost center code, only if it is not fetched yet [in_out paramater : v_CostCenterCode]
        GET_COST_CENTER_CODE(GET_COLS_REC.COLUMN_NAME, ROW_CURR, COMP_CURR, v_CostCenterCode);

        IF GET_COLS_REC.COLUMN_NAME = 'UPPER_LVL_VER_VALUE' THEN
            --CCN 2.0 release changes to extract attributes dynamically
            --PARSE_DIFFERENCE_ATTRBTS_XML(ROW_CURR, ROW_PREV, XMLSTRING);
            IF ROW_CURR IS NOT NULL THEN
                V_ROW_CURR := SYS.XMLTYPE(REPLACE(ROW_CURR.EXTRACT('//HIERARCHY_DETAIL').GETSTRINGVAL(),'ATTRIBUTES>','attributes>')); 
            END IF;
            IF ROW_PREV IS NOT NULL THEN
                V_ROW_PREV := SYS.XMLTYPE(REPLACE(ROW_PREV.EXTRACT('//HIERARCHY_DETAIL').GETSTRINGVAL(),'ATTRIBUTES>','attributes>'));
            END IF;
            PARSE_DIFFERENCE_ATTRBTS_XML(V_ROW_CURR,
                                         V_ROW_PREV,
                                         XMLSTRING);
        END IF;

        --If the elements have changed OR new row, append them to the XML string
        IF v_change_type = 'A' THEN
            XMLSTRING := XMLSTRING || '<' || GET_COLS_REC.COLUMN_NAME || '>' || COMP_CURR || '</' || GET_COLS_REC.COLUMN_NAME || '>';
        ELSE
            --Populate the XML String only if the value is changed or if particular column is part of primary key
            --Also for Bank_Card table we should always populate below fields with current records value if it's a change
            IF NVL(COMP_CURR,'A') <> NVL(COMP_PREV,'A')
               OR XML_EXTRACT_NO_EXCEPTION(PK_CURR,'//' || GET_COLS_REC.COLUMN_NAME) IS NOT NULL
               OR  (IN_TABLE_NAME || ' - ' || GET_COLS_REC.COLUMN_NAME) IN ('BANK_CARD - MERCHANT_ID',
                                                                            'BANK_CARD - QUALITY_CODE',
                                                                            'BANK_CARD - AMEX_SE_ID',
                                                                            'BANK_CARD - DISCOVER_ID',
                                                                            'EMPLOYEE_ADMIN_DETAILS - JOB_TYPE') THEN  
                XMLSTRING := XMLSTRING || '<' || GET_COLS_REC.COLUMN_NAME || '>' || COMP_CURR || '</' || GET_COLS_REC.COLUMN_NAME || '>';
            END IF;
        END IF;
    END LOOP;

    UPDATE_AUDIT_REC_FLAG(IN_TABLE_NAME,IN_KEY, V_LOG_ID_PREV, V_LOG_ID_CURR, V_CONTEXT);

    V_CONTEXT := 'Final value being set';
    XMLSTRING       := XMLSTRING || '</' || IN_Table_name || '>';

    V_CONTEXT := 'Converting to XMLType';
    --Convert the final XML String to XMLType and set it to the OUT parameter
    OUT_DIFF        := XMLType(XMLSTRING);
    OUT_PREV_ROW    := ROW_PREV;
    OUT_CURR_ROW    := ROW_CURR;
    OUT_CC_CODE     := v_CostCenterCode;
    OUT_CHANGE_TYPE := v_change_type;
    OUT_LOG_ID      := V_LOG_ID_CURR;
    OUT_LOG_ID_PREV := V_LOG_ID_PREV;

EXCEPTION
    WHEN OTHERS THEN
        SQ := SQLCODE;
        SE := SQLERRM;
        V_CONTEXT := V_CONTEXT || ' ' || SQ || ' ' || SE; 
        ERRPKG.RAISE_ERR(-20003,'PARSE_DIFFERENCE_XML for ' || IN_TABLE_NAME || ' ' || IN_KEY || 'at ', V_CONTEXT);
END PARSE_DIFFERENCE_XML; 

PROCEDURE Build_File_SP (
/**********************************************************
	Build_File_SP

	This procedure is intended to build a file based on the table layout
	in order to be consumed by the Mainframe to backfill Legacy MainFrame

	CostCenter - Cost Center that changed
	OracleTableName -Table name for row
	varible (based on the table that was updated)


created : 02/21/2012 kdp CCN Project....
modified: 04/15/2015 jxc517 CCN Project....
          Territory users cannot deal with global hierarchy 6th level with non-alphabets
          the code changes here are to send the dummy YY as @@ for 6th level value of global hierarchy
Modified: 07/28/2015 dxv848 added the condition to remove the space going into the file.   
        : 11/03/2015 axk326 CCN Project Team
          Replaced call to COMMON_TOOLS.ELIMINATE_SPECIAL_CHRCTRS with HANDLE_SPECIAL_CHRCTRS to handle 
          special characters while writing into audit backfeed file
**********************************************************/
IN_COST_CENTER IN COST_CENTER.COST_CENTER_CODE%TYPE
,in_TABLE_NAME IN VARCHAR2
,in_ROW_DATE   IN DATE
,IN_PREV_ROW   IN sys.XMLTYPE
,IN_CURR_ROW   IN sys.XMLTYPE
,in_Row_data    IN sys.XMLTYPE           
,in_CHANGE_TYPE in VARCHAR2
,in_LOG_ID_PREV in NUMBER
,in_LOG_ID      in NUMBER
)
 is 
CURSOR table_fields_cur IS
   SELECT COLUMN_NAME,
          DECODE(DATA_TYPE, 'DATE', 8, DATA_LENGTH) COLUMN_SIZE,
          DATA_TYPE,
          COLUMN_ID
     FROM ALL_TAB_COLUMNS
    WHERE TABLE_NAME = IN_TABLE_NAME
   --For Hierarchy_Detail table alone we need to append 2 more fields at the end - statement_type and emplyee_name
   UNION
   SELECT COLUMN_NAME,
          DECODE(DATA_TYPE, 'DATE', 8, DATA_LENGTH) COLUMN_SIZE,
          DATA_TYPE,
          COLUMN_ID
     FROM CCN_ADDITIONAL_AUDIT_FIELDS
    WHERE TABLE_NAME = IN_TABLE_NAME
    ORDER BY COLUMN_ID ASC;

  PATH        	        VARCHAR2(50) := 'CCN_DATAFILES'; -- directory created in Oracle database UNTIL NEW ONE CREATED
  filename  	          VARCHAR2(50) := in_TABLE_NAME || '_backfeed' ;
  stamp       		      VARCHAR2(50) := TO_CHAR(SYSTIMESTAMP,'HH24:MI:SS:FF6'); -- used to create timestamp for data file 
  v_cost_center		      VARCHAR2(6)  := '      '; --added for spaces with tables that don't use cost center
  V_CHANGE_TYPE         VARCHAR2(1);
  output_file 		      UTL_FILE.FILE_TYPE;
  V_HRCHY_HDR_NAME      HIERARCHY_DETAIL.HRCHY_HDR_NAME%TYPE;
  V_HRCHY_DTL_LEVEL     HIERARCHY_DETAIL.HRCHY_DTL_LEVEL%TYPE;
-------------
  l_out_file            UTL_FILE.FILE_TYPE;
  l_buffer              RAW(32767);
  l_amount              BINARY_INTEGER := 32767;
  l_pos                 INTEGER        := 1;
  L_BLOB_LEN            INTEGER;
  v_out_clob            CLOB;
  v_value               VARCHAR2(32000);
  v_extracted_value     VARCHAR2(32000);
  V_CONTEXT	            VARCHAR2(200);
  SQ		                INTEGER; 
  SE		                VARCHAR2(1000);

BEGIN

   -- working just remove for debbuging un comment for writing file
   V_CONTEXT := 'Creating the file on server';
   output_file := UTL_FILE.FOPEN (path
                                  ,filename|| stamp
                                  , 'w' --binary
                                 , 32767);
   --adding header information for the backload file
   IF IN_COST_CENTER IS NOT NULL THEN
      V_COST_CENTER := IN_COST_CENTER; 
   END IF;

    V_CONTEXT := 'Generating the CLOB Output';
 
   --For a change in cost center or employee status we need to send two records in the backfeed
   --First the Previous value with a 'D'
   --Second with the current value with a "A'
   IF IN_TABLE_NAME IN ('MANAGER_EMPLOYEE', 'TERRITORY_EMPLOYEE') THEN
      --calling the proc for MANAGER_EMPLOYEE or TERRITORY_EMPLOYEE to place two records
      --if an employee changes Cost Center or Status
      EMP_MGR_TERRITORY_AUDIT_SP
                    ( 
                       V_COST_CENTER
                      ,in_TABLE_NAME 
                      ,in_LOG_ID_PREV --PREV log_id
                      ,in_LOG_ID     --CURR log_id
                      ,in_Row_data   --diff xml from PARSE
                      ,IN_PREV_ROW   --Previous Row from Audit_Log        
                      ,IN_CURR_ROW   --Current Row from Audit_Log
                      ,V_OUT_CLOB
                    );
   ELSE
  
   --Getting the Change Type : 
   --For Hierarchy_Detail table it should always be 'A'
   --For all other tables it should be 'C', except for tables that come as 'C' and having effective date 
   -- as part of primary key in which case it should be 'D'
   IF IN_TABLE_NAME = 'HIERARCHY_DETAIL' THEN
      V_CHANGE_TYPE := 'A';
   ELSE
      IF IN_CHANGE_TYPE = 'C'
         AND IS_COLUMN_PART_OF_KEY(IN_TABLE_NAME,'EFFECTIVE_DATE','P') 
         --We should change the indicator from "C" to "D" only if the expiration date is present
         AND NVL(IN_ROW_DATA.EXTRACT('/'|| IN_TABLE_NAME|| '/EXPIRATION_DATE/text()').GETSTRINGVAL(),'~') <> '~' THEN
         V_CHANGE_TYPE := 'D';
      ELSE
         V_CHANGE_TYPE := 'C';
      END IF;
   END IF;
   
   --V_OUT_CLOB := TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') || V_COST_CENTER || RPAD(IN_TABLE_NAME,25) || TO_CHAR (TRUNC(SYSDATE),'YYYYMMDDHH24MISS') ||
   V_OUT_CLOB := TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') || V_COST_CENTER || RPAD(IN_TABLE_NAME,25) || TRIM(LPAD(in_LOG_ID,14,'0')) ||
                 V_CHANGE_TYPE; --IN_CHANGE_TYPE;

   FOR TABLE_FIELDS_REC IN TABLE_FIELDS_CUR LOOP
 
      IF (IN_ROW_DATA.EXISTSNODE('/'|| IN_TABLE_NAME|| '/' || TABLE_FIELDS_REC.COLUMN_NAME ||'/text()') = 1) THEN
         V_CONTEXT := 'Building by extracting the Existing Data';
         v_extracted_value := HANDLE_SPECIAL_CHRCTRS(IN_ROW_DATA.EXTRACT('/'|| IN_TABLE_NAME|| '/' || TABLE_FIELDS_REC.COLUMN_NAME ||'/text()').GETSTRINGVAL());
         IF ((IN_TABLE_NAME||' - '|| TABLE_FIELDS_REC.COLUMN_NAME IN ('COST_CENTER - POS_PROG_VER_NBR',
                                                                      'HIERARCHY_DETAIL - EMPLOYEE_NAME'))) THEN
            V_OUT_CLOB := V_OUT_CLOB ||
                          UPPER(LPAD(v_extracted_value,
                                     NVL(TABLE_FIELDS_REC.COLUMN_SIZE,LENGTH(v_extracted_value)), '0'));
         ELSE
            v_value := UPPER(RPAD(v_extracted_value,
                                  NVL(TABLE_FIELDS_REC.COLUMN_SIZE,LENGTH(v_extracted_value))));
            --If there is a change and if the changed value is null then it comes here as '~'
            --We need to capture these ~'s and convert into proper formatting
            --like we do for null values for specific fields
            IF TRIM(v_value) = '~' THEN
               --Setting Open_Date to '01012099' which have null open date so that we can pass it to main frame
               IF ((IN_TABLE_NAME||' - '|| TABLE_FIELDS_REC.COLUMN_NAME = 'COST_CENTER - OPEN_DATE' )) THEN
            
                  V_OUT_CLOB := V_OUT_CLOB || UPPER(RPAD('20990101',TABLE_FIELDS_REC.COLUMN_SIZE));
                  --Setting All 9's for Phone_Number, Merchant_Id, Quality_Code, Amex_SE_Id, Discover_Id
                  --which have null values so that we can pass it to main frame
                  --For Address_USA Table the PRI country(PR State) should default the values to 99 and 9
               ELSE
                  IF ((IN_TABLE_NAME||' - '|| TABLE_FIELDS_REC.COLUMN_NAME IN ('BANK_CARD - MERCHANT_ID',
                                                                               'BANK_CARD - QUALITY_CODE',
                                                                               'BANK_CARD - AMEX_SE_ID',
                                                                               'BANK_CARD - DISCOVER_ID',
                                                                               'PHONE - PHONE_NUMBER',
                                                                               'PHONE - PHONE_AREA_CODE',
                                                                               'ADDRESS_USA - DESTINATION_POINT',
                                                                               'ADDRESS_USA - CHECK_DIGIT'))) THEN
                     V_OUT_CLOB := V_OUT_CLOB || UPPER(LPAD('9',TABLE_FIELDS_REC.COLUMN_SIZE,'9'));	
                  ELSE
                     --Below two fields should not go as ~ in audit field rather should go as spaces
                     --Should be removed once we start populating these fields on the server
                     IF IN_TABLE_NAME||' - '|| TABLE_FIELDS_REC.COLUMN_NAME IN ('TERMINAL - POS_LAST_TRAN_DATE',
                                                                                'TERMINAL - POS_LAST_TRAN_NUMBER') THEN
                        V_OUT_CLOB := V_OUT_CLOB || RPAD(' ',TABLE_FIELDS_REC.COLUMN_SIZE);
                     ELSE
                        V_OUT_CLOB := V_OUT_CLOB || v_value;
                     END IF;
                  END IF;
               END IF;
            ELSE
               --For global hierarchy, sales manager records alone, we hard coded <SPACE> with # for data to work
               --We need to replace those to spaces when we send them back to backfeed
               IF (IN_TABLE_NAME||' - '|| TABLE_FIELDS_REC.COLUMN_NAME IN ('HIERARCHY_DETAIL - HRCHY_DTL_CURR_ROW_VAL',
                                                                           'HIERARCHY_DETAIL - HRCHY_DTL_PREV_LVL_VAL',
                                                                           'HIERARCHY_DETAIL - HRCHY_DTL_CURR_LVL_VAL',
                                                                           'HIERARCHY_DETAIL - HRCHY_DTL_NEXT_LVL_VAL')) THEN
                  --the below replacements are applicable only for 6th level of GLOBAL_HIERARCHY
                  IF NVL(V_HRCHY_HDR_NAME,'XXX') = 'GLOBAL_HIERARCHY' THEN
                      --if it is 6th level, replace YY with @@
                      IF IN_TABLE_NAME||' - '|| TABLE_FIELDS_REC.COLUMN_NAME = 'HIERARCHY_DETAIL - HRCHY_DTL_CURR_ROW_VAL'
                         AND NVL(V_HRCHY_DTL_LEVEL,'X') = '06' THEN
                          v_value := REPLACE(v_value,'YY','@@');
                      END IF;
                      --if it has 6th level value in its composite key and it is YY replace it with @@
                      IF LENGTH(v_value) > 10 AND SUBSTR(v_value,11,2) = 'YY' THEN
                          v_value := SUBSTR(v_value,1,10)||'@@'||SUBSTR(v_value,13);
                      END IF;
                  END IF;
                  V_OUT_CLOB := V_OUT_CLOB || REPLACE(v_value,'#',' ');
               ELSE
                  --below 2 variables are used to replace YY in global hierarchy 6th level with @@
                  IF IN_TABLE_NAME||' - '|| TABLE_FIELDS_REC.COLUMN_NAME = 'HIERARCHY_DETAIL - HRCHY_HDR_NAME' THEN
                      V_HRCHY_HDR_NAME := TRIM(v_value);
                  ELSIF IN_TABLE_NAME||' - '|| TABLE_FIELDS_REC.COLUMN_NAME = 'HIERARCHY_DETAIL - HRCHY_DTL_LEVEL' THEN
                      V_HRCHY_DTL_LEVEL := TRIM(v_value);
                  END IF;
                  V_OUT_CLOB := V_OUT_CLOB || v_value;
               END IF;
            END IF;   
         END IF;
      ELSE
         V_CONTEXT := 'Building by extracting the Non-Existing Data';
         V_OUT_CLOB := V_OUT_CLOB || RPAD(' ',TABLE_FIELDS_REC.COLUMN_SIZE);
      END IF;
   END LOOP;
 END IF;
  --working just remove for debbuging un comment for writing file
IF  V_OUT_CLOB <> EMPTY_CLOB() THEN   
     UTL_FILE.PUT_LINE(output_file, v_out_clob, TRUE);
     UTL_FILE.FCLOSE(output_file);
END IF;

EXCEPTION WHEN OTHERS THEN
  SQ := SQLCODE;
	SE := SQLERRM;
	V_CONTEXT := V_CONTEXT || ' ' || SQ || ' ' || SE; 
 
 	ERRPKG.RAISE_ERR(-20003,'Build_File_SP in ' || IN_TABLE_NAME || ' for ' || IN_COST_CENTER || 'at ', V_CONTEXT);
END Build_File_SP;

PROCEDURE PROCESS_AUDIT_LOG(
/**********************************************************
PROCESS_AUDIT_LOG

This procedure is the core process that performs the required operations
for the audit log processing

created : 02/07/2014 jxc517 CCN Project Team . . .
**********************************************************/
    IN_TRANSACTION_ID     IN     VARCHAR2,
    IN_TABLE_NAME         IN     VARCHAR2,
    OUT_CC_CODE              OUT VARCHAR2,
    OUT_CONTEXT              OUT VARCHAR2)
IS
V_CONTEXT	          VARCHAR2(200);
DIFF_XML            XMLTYPE;
OUT_PREV_ROW        XMLTYPE;
OUT_CURR_ROW        XMLTYPE;
V_LOG_ID            NUMBER; --current log id
V_LOG_ID_PREV       NUMBER; --Previous log id
V_CC_CODE           COST_CENTER.COST_CENTER_CODE%TYPE;
V_CHANGE_TYPE       varchar2(1) := 'A';
BEGIN
    --Check if audit process is needed for the current table and if cost center is part of global hierarchy  
    IF REQUIRED_TABLE_CHECK(IN_TABLE_NAME) = 'Y' THEN
        --Process the record only if cost center in the key is associated with global
        --or hierarchy_detail record that is NOT in last two levels of any hierarchy
        --NOTE: All details of other hierarchies also should be taken in to consideration 
        IF (NOT IS_IN_LAST_TWO_LVLS_OF_HRCHY(IN_TRANSACTION_ID, IN_TABLE_NAME))
           OR IS_COSTCNTR_IN_GLOBAL_HRCHY(IN_TRANSACTION_ID, IN_TABLE_NAME) 
           OR IN_TABLE_NAME IN ('MANAGER_EMPLOYEE', 'TERRITORY_EMPLOYEE') --Added 09/04/2014 
        THEN
            V_CONTEXT:='Call procedure PARSE_DIFFERENCE_XML for every combination of table_name,transaction_id';
            PARSE_DIFFERENCE_XML( IN_TABLE_NAME
                                  ,IN_TRANSACTION_ID
                                  ,V_CC_CODE
  				                        ,V_CHANGE_TYPE
                                  ,OUT_PREV_ROW
                                  ,OUT_CURR_ROW 
                                  ,DIFF_XML
                                  ,V_LOG_ID_PREV
                                  ,V_LOG_ID
                                  );

            V_CONTEXT:='Call procedure Build_File_SP';
            BUILD_FILE_SP(V_CC_CODE
                          ,IN_TABLE_NAME	--in_TABLE_NAME IN VARCHAR2
                          ,SYSDATE			--in_ROW_DATE   IN DATE
                          ,OUT_PREV_ROW
                          ,OUT_CURR_ROW
                          ,DIFF_XML			--in_Row_data   IN sys.xmltype
                          ,V_CHANGE_TYPE
                          ,V_LOG_ID_PREV
                          ,V_LOG_ID);
            --set the GLOBAL_HIERARCHY_SKIP_FLAG to NULL, which means don't pick again in further batch processing
            UPDATE AUDIT_LOG
               SET GLOBAL_HIERARCHY_SKIP_FLAG = NULL
             WHERE TRANSACTION_ID             = IN_TRANSACTION_ID
               AND TABLE_NAME                 = IN_TABLE_NAME
               AND GLOBAL_HIERARCHY_SKIP_FLAG = 'Y';
        ELSE
            --set the GLOBAL_HIERARCHY_SKIP_FLAG to 'Y', which means pick again in further batch processing
            UPDATE AUDIT_LOG
              SET GLOBAL_HIERARCHY_SKIP_FLAG = 'Y'
            WHERE TRANSACTION_ID             = IN_TRANSACTION_ID
              AND TABLE_NAME                 = IN_TABLE_NAME
              AND GLOBAL_HIERARCHY_SKIP_FLAG IS NULL
              AND AUDIT_REC_FLAG             IS NULL;
        END IF;
    END IF;
    OUT_CC_CODE := V_CC_CODE;
    OUT_CONTEXT := V_CONTEXT;
--Exceptions handled in calling procedure
END PROCESS_AUDIT_LOG;

BEGIN
    V_CONTEXT:='Inserting a record in the Batch_Job table with Status as PROCESSING';
    CCN_BATCH_PKG.LOCK_DATABASE_SP(); -- PRAGMA AUTONOMOUS_TRANSACTION;

    FOR SEL_AUDIT_REC IN SEL_AUDIT_LOG LOOP
        BEGIN
            SAVEPOINT NEXT_AUDIT_REC;
            PROCESS_AUDIT_LOG(SEL_AUDIT_REC.TRANSACTION_ID, SEL_AUDIT_REC.TABLE_NAME, V_CC_CODE, V_CONTEXT);
        EXCEPTION
            WHEN OTHERS THEN
                ROLLBACK TO NEXT_AUDIT_REC;
                V_TRANS_STATUS := 'ERROR';
                v_code  := SQLCODE;
                v_errm  := substr(SQLERRM,1,500);
                --write to error log
                errpkg.INSERT_ERROR_LOG_SP(v_code, 'SELECT_AUDIT_LOG', v_errm, NVL(V_CC_CODE,'AUDIT'));
        END;
    END LOOP;  

    V_CONTEXT:='Updating the Status in batch_job table';
    CCN_BATCH_PKG.UNLOCK_DATABASE_SP(); -- PRAGMA AUTONOMOUS_TRANSACTION; 
EXCEPTION
    WHEN OTHERS THEN
	      SQ := SQLCODE;
	      SE := SQLERRM;
	      V_CONTEXT := V_CONTEXT || ' ' || SQ || ' ' || SE; 
	      ERRPKG.RAISE_ERR(-20003,'SELECT_AUDIT_LOG',V_CONTEXT);
END;
/
