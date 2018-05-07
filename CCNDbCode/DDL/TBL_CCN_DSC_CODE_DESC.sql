/*#############################################################
This script creates a Table CCN_DSC_CODE_DESC 

Created : 04/23/2018 sxg151 CCN Team...
#############################################################*/
-- Create table script 
CREATE TABLE CCN_DSC_CODE_DESC 
    (COST_CENTER_CODE VARCHAR2(21),
     PRIMARY_DSC	  NUMBER(3),
     PRI_DSC_DESCR	  VARCHAR2(60),
     SECONDARY_DSC	  NUMBER(3),
     SEC_DESC_DESCR  VARCHAR2(60),
CONSTRAINT PK_CCN_DSC_CODE_DESC1 PRIMARY KEY (COST_CENTER_CODE)
    );
    
GRANT SELECT ON CCN_DSC_CODE_DESC TO CCN_UTILITY;