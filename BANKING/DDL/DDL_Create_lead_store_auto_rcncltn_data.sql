/*
**************************************************************************** 
This script is created to create a new table for storing
the leads/independent stores that are having auto-reconciliation set to "Y". 
Created : 01/23/2017 gxg192 CCN Project.... 
Changed : 
****************************************************************************
*/

CREATE TABLE LEAD_STORE_AUTO_RCNCLTN_DATA
   (
      LEAD_BANK_ACCOUNT_NBR VARCHAR2(20),
      LEAD_STORE_NBR        VARCHAR2(6),
      EFFECTIVE_DATE        DATE,
      EXPIRATION_DATE       DATE,
      BANK_BRANCH_NBR       VARCHAR2(8),
      BANK_TYPE_CODE        VARCHAR2(1),
      LOAD_DATE             DATE DEFAULT SYSDATE,
            CONSTRAINT LEAD_BANK_AutoRecon_FK FOREIGN KEY (LEAD_BANK_ACCOUNT_NBR, LEAD_STORE_NBR)
            REFERENCES LEAD_BANK_CC (LEAD_BANK_ACCOUNT_NBR, LEAD_STORE_NBR)
   );