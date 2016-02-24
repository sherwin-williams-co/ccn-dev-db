/*
Created: 02/24/2016 dxv848/nxk927 delete script for the ACH_DRFTS_EXTRCT_CNTRL_FL for removing duplicates
*/

DELETE   FROM ACH_DRFTS_EXTRCT_CNTRL_FL a
      WHERE a.ROWID > ANY (SELECT b.ROWID
                             FROM ACH_DRFTS_EXTRCT_CNTRL_FL b
                            WHERE a.COST_CENTER_CODE = b.COST_CENTER_CODE
                              AND a.BANK_DEP_AMT = b.BANK_DEP_AMT
                              AND a.BANK_ACCOUNT_NBR=b.BANK_ACCOUNT_NBR
                              AND a.TRANSACTION_DATE=b.TRANSACTION_DATE
                              ); 
					
COMMIT;
					