/*
SCRIPT NAME: DDL_CCN_SWC_PN_SQFT_INT.SQL
PURPOSE    : CREATING THE CCN_SWC_PN_SQFT_INT TABLE.

CREATED : 07/11/2017 km302 CCN PROJECT....
CHANGED : 
*/

CREATE  TABLE CCN_SWC_PN_SQFT_INT (
    DIVISION              VARCHAR2(10),
    COST_CENTER           VARCHAR2(10),
    Leasing_Sales_Sq_Ft   VARCHAR2(50),
    Leasing_Total_Sq_Ft   VARCHAR2(50),
    LEASE_OR_OWNED        VARCHAR2(2),
    CONSTRAINT COST_CENTER_SWC_PK PRIMARY KEY (COST_CENTER)
);

GRANT SELECT ON CCN_SWC_PN_SQFT_INT TO CCN_UTILITY;