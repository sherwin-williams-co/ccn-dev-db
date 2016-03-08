CREATE OR REPLACE VIEW COST_CENTER_FLDPRRPT_V AS 
  SELECT
       /*******************************************************************************
    
     Modified : 03/02/2016 MXR916 Added CATEGORY_DESCRIPTION,STATEMENT_TYPE_DESCRIPTION,COUNTRY_CODE_DESCRIPTION,
                                        MISSION_TYPE_CODE_DESCRIPTION columns.
     *******************************************************************************/     
                  COST_CENTER_CODE,
                  COST_CENTER_NAME,
                  CATEGORY,
                  CATEGORY_DESCRIPTION,
                  STATEMENT_TYPE,
                  STATEMENT_TYPE_DESCRIPTION,
                  COUNTRY_CODE,
                  COUNTRY_CODE_DESCRIPTION,
                  BEGIN_DATE,
                  OPEN_DATE,
                  MOVE_DATE,
                  CLOSE_DATE,
                  MISSION_TYPE_CODE,
                  MISSION_TYPE_CODE_DESCRIPTION,
                  DUNS_NUMBER
     FROM COST_CENTER_VW;