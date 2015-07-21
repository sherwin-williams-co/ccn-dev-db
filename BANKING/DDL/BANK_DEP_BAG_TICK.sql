  CREATE TABLE BANK_DEP_BAG_TICK 
   (BANK_ACCOUNT_NBR VARCHAR2(16) NOT NULL ENABLE, 
	COST_CENTER_CODE VARCHAR2(6) NOT NULL ENABLE, 
	DEPBAG_DAILY_USE_ACTUAL VARCHAR2(5), 
	DEPBAG_DLY_USE_OVERRIDE VARCHAR2(5), 
	DEPBAG_LAST_ORDER_DATE DATE, 
	DEPBAG_LAST_ORDER_QTY VARCHAR2(5), 
	DEPBAG_ONHAND_QTY VARCHAR2(5), 
	DEPBAG_REORDER_QTY VARCHAR2(5), 
	DEPBAG_YTD_ORDERED_QTY VARCHAR2(5), 
	DEP_BAG_REORDER_POINT VARCHAR2(5), 
	DEP_BAG_TYPE VARCHAR2(1), 
	DEP_BAG_REORDER_SWITCH VARCHAR2(1), 
	EFFECTIVE_DATE DATE, 
	EXPIRATION_DATE DATE, 
	 CONSTRAINT BANK_DEP_BAG_TICK_PK PRIMARY KEY (COST_CENTER_CODE);

  /