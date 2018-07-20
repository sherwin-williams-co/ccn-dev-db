/*
SCRIPT NAME: DDL_CCN_SWC_PN_SQFT_INT.SQL
PURPOSE    : CREATING THE CCN_SWC_PN_SQFT_INT TABLE.

CREATED : 07/16/2018 km302 CCN PROJECT....
CHANGED : 
*/

DROP TABLE CCN_SWC_PN_SQFT_INT;

CREATE  TABLE CCN_SWC_PN_SQFT_INT (
    DIVISION              VARCHAR2(4),
    COST_CENTER           VARCHAR2(6),
    LEASING_SALES_SQ_FT   NUMBER,
    LEASING_TOTAL_SQ_FT   NUMBER,
    LEASE_OR_OWNED        VARCHAR2(1),
	CONSTRAINT COST_CENTER_SWC_PK PRIMARY KEY (COST_CENTER)
);
