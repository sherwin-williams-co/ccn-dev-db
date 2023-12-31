CREATE TABLE CREDIT_HIERARCHY_T 
      (	HRCHY_HDR_NAME VARCHAR2(100), 
   	HRCHY_DTL_LEVEL VARCHAR2(2), 
   	HRCHY_DTL_PREV_LVL_VAL VARCHAR2(1000), 
   	HRCHY_DTL_CURR_LVL_VAL VARCHAR2(1000), 
   	HRCHY_DTL_NEXT_LVL_VAL VARCHAR2(1000), 
   	HRCHY_DTL_EFF_DATE DATE, 
   	HRCHY_DTL_EXP_DATE DATE, 
   	HRCHY_DTL_DESC VARCHAR2(100), 
   	ATTRIB1 VARCHAR2(1000), 
   	ATTRIB2 VARCHAR2(1000)
      ) ;
   
     CREATE INDEX CRDT_HRCHY_IDX ON CREDIT_HIERARCHY_T (HRCHY_HDR_NAME, HRCHY_DTL_LEVEL, HRCHY_DTL_CURR_LVL_VAL) ;
     
   