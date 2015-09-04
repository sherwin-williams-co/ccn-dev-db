  CREATE TABLE BANK_DEP_TICK_HIST 
   (	BANK_ACCOUNT_NBR VARCHAR2(20) NOT NULL ENABLE,
	COST_CENTER_CODE VARCHAR2(6) NOT NULL ENABLE,
	DAILY_USE_ACTUAL VARCHAR2(3),
	DAILY_USE_OVERRIDE VARCHAR2(3),
	DEP_TKTS_ONHAND_QTY VARCHAR2(5),
	YTD_DEP_TKTS_ORDERED_QTY VARCHAR2(5),
	REORDER_POINT VARCHAR2(5),
	REORDER_NUMBER_BKS VARCHAR2(5),
	IMAGES_PER_PAGE VARCHAR2(1),
	NBR_FORMS_PER_BK VARCHAR2(5),
	PART_PAPER_PER_FORM VARCHAR2(1),
	NBR_DEP_TICKETS_PER_BK VARCHAR2(5),
	SHEETS_OF_PAPER_PER_BK VARCHAR2(5),
	EFFECTIVE_DATE DATE,
	EXPIRATION_DATE DATE,
	LAST_MAINTENANCE_DATE DATE,
	LAST_MAINT_USER_ID VARCHAR2(6),
	REORDER_SWITCH VARCHAR2(1),
	LAST_VW_ORDER_DATE DATE
   );
  /