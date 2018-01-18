/***********************************************************
This table HIERARCHY_DETAIL_DAILY_SNAP cteated to load data from HIERARCHY_DETAIL
created : 1/04/2017 SXG151
revised :
************************************************************/
CREATE TABLE HIERARCHY_DETAIL_DAILY_SNAP
(
    HRCHY_HDR_NAME            VARCHAR2(100) NOT NULL,
    HRCHY_DTL_LEVEL           VARCHAR2(2) NOT NULL,
    HRCHY_DTL_PREV_LVL_VAL    VARCHAR2(1000),
    HRCHY_DTL_CURR_LVL_VAL    VARCHAR2(1000) NOT NULL,
    HRCHY_DTL_NEXT_LVL_VAL    VARCHAR2(1000),
    HRCHY_DTL_EFF_DATE        DATE NOT NULL,
    HRCHY_DTL_EXP_DATE        DATE,
    HRCHY_DTL_DESC            VARCHAR2(100),
    HRCHY_DTL_CURR_ROW_VAL    VARCHAR2(100),
    UPPER_LVL_VER_VALUE       XMLTYPE,
    LOAD_DATE                 DATE    NOT NULL
);

CREATE INDEX INDX1 ON HIERARCHY_DETAIL_DAILY_SNAP (HRCHY_HDR_NAME, LOAD_DATE);
CREATE INDEX INDX2 ON HIERARCHY_DETAIL_DAILY_SNAP (HRCHY_DTL_CURR_ROW_VAL);
CREATE INDEX INDX3 ON HIERARCHY_DETAIL_DAILY_SNAP (HRCHY_HDR_NAME, HRCHY_DTL_LEVEL, HRCHY_DTL_PREV_LVL_VAL);
CREATE INDEX INDX4 ON HIERARCHY_DETAIL_DAILY_SNAP (HRCHY_DTL_LEVEL||HRCHY_DTL_CURR_LVL_VAL, HRCHY_HDR_NAME);
CREATE INDEX INDX5 ON HIERARCHY_DETAIL_DAILY_SNAP (HRCHY_DTL_CURR_LVL_VAL||HRCHY_DTL_NEXT_LVL_VAL, HRCHY_HDR_NAME);
CREATE INDEX INDX6 ON HIERARCHY_DETAIL_DAILY_SNAP (HRCHY_HDR_NAME, HRCHY_DTL_LEVEL, HRCHY_DTL_CURR_LVL_VAL);
CREATE INDEX INDX7 ON HIERARCHY_DETAIL_DAILY_SNAP (HRCHY_HDR_NAME, HRCHY_DTL_CURR_LVL_VAL, HRCHY_DTL_NEXT_LVL_VAL, HRCHY_DTL_PREV_LVL_VAL);