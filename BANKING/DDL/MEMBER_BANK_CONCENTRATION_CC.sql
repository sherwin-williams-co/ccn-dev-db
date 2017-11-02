/*******************************************************************************
 The table is used to hold the Banking lead store no# and member store no#
 Create Table : MEMBER_BANK_CONCENTRATION_CC 
 Index        : INDEX_LOAD_DATE -- Create index on Load_date.
 
 Created  : 10/31/2015 SXG151 CCN
*******************************************************************************/
CREATE TABLE MEMBER_BANK_CONCENTRATION_CC
            (LEAD_STORE_NBR VARCHAR2(6) NOT NULL ENABLE, 
	           MEMBER_STORE_NBR VARCHAR2(6) NOT NULL ENABLE, 
	           LOAD_DATE DATE
            );      
CREATE INDEX INDEX_LOAD_DATE ON MEMBER_BANK_CONCENTRATION_CC(LOAD_DATE);   