CREATE TABLE ACH_DRFTS_EXTRCT_CNTRL_FL 
   (COST_CENTER_CODE VARCHAR2(4), 
	CENTURY VARCHAR2(1), 
	BANK_DEP_AMT VARCHAR2(10), 
	BANK_ACCOUNT_NBR VARCHAR2(17), 
	BANK_AUTO_REC_IND VARCHAR2(1),
    TRANSACTION_DATE DATE, 
	LOAD_DATE DATE
   );
  
  CREATE INDEX ACH_DRFTS_INDX1 ON ACH_DRFTS_EXTRCT_CNTRL_FL (COST_CENTER_CODE, LOAD_DATE);
  CREATE INDEX ACH_DRFTS_INDX2 ON ACH_DRFTS_EXTRCT_CNTRL_FL (COST_CENTER_CODE, TRANSACTION_DATE, LOAD_DATE);
  CREATE INDEX ACH_DRFTS_INDX3 ON ACH_DRFTS_EXTRCT_CNTRL_FL (LOAD_DATE);
  
   
  
  
  