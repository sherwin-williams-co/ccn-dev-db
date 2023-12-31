/*
SCRIPT NAME: DDL_CCN_SWC_PN_SQFT_INT_HIST.SQL
PURPOSE    : CREATING THE CCN_SWC_PN_SQFT_INT_HIST TABLE.

CREATED : 07/16/2018 km302 CCN PROJECT....
CHANGED : 07/20/2018 km302 CCN PROJECT....
          Datatype for square footage changed to NUMERIC
*/

DROP TABLE CCN_SWC_PN_SQFT_INT_HIST;

CREATE  TABLE CCN_SWC_PN_SQFT_INT_HIST (
    DIVISION              VARCHAR2(4),
    COST_CENTER           VARCHAR2(6),
    LEASING_SALES_SQ_FT   NUMBER,
    LEASING_TOTAL_SQ_FT   NUMBER,
    LEASE_OR_OWNED        VARCHAR2(1),
    LOAD_DATE             DATE,
	CONSTRAINT COST_CENTER_SWC_HIST_PK PRIMARY KEY (COST_CENTER,LOAD_DATE)
);
