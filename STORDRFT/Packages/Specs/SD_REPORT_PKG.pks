create or replace 
PACKAGE SD_REPORT_PKG as 
/*********************************************************** 
This package will hold all pl/sql objects that are needed to 
store draft reports from 


created : 08/01/2014

revisions: 
************************************************************/

Procedure Store_draft_report_query
/**********************************************************

This procedure will build the store draft report data 

created : 08/01/2014
**********************************************************/
(in_start_date IN date,
in_end_date IN date 
)
;

FUNCTION GET_RQSTD_ATTRIBUTE_VALUE(
    IN_UPPER_LVL_VER_VALUE  IN     HIERARCHY_DETAIL.UPPER_LVL_VER_VALUE%TYPE,
    IN_ATTRIBUTE_NAME       IN     VARCHAR2)
    RETURN VARCHAR2
    ;

       
FUNCTION CC_MANAGER(
    IN_COST_CENTER_CODE EMPLOYEE_DETAILS.COST_CENTER_CODE%TYPE)
    RETURN VARCHAR2;
    
FUNCTION GET_MANAGER_NAME(
   IN_IND in VARCHAR2,
   IN_HRCHY_DTL_PREV_LVL_VAL IN HIERARCHY_DETAIL.HRCHY_DTL_PREV_LVL_VAL%TYPE
   )
      RETURN VARCHAR2;
    

end;