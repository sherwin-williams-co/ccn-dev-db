/****************************************************************************/
--Created : 06/01/2017 rxa457.. CCN Project Team for ASP-761
--          To Clean unused filler fields from SRA11000 related tables 
--          Changes CHARACTER AMOUNT fields to numeric fields with precision of 10,2
--          Updates Cost Center code field to 6 digit equivalent
/****************************************************************************/
--BACKUP TABLES
CREATE TABLE SUMMARY_EXTRCT_CNTRL_FL_761 AS SELECT * FROM SUMMARY_EXTRCT_CNTRL_FL  PARALLEL;
CREATE TABLE ACH_DRFTS_EXT_CTRL_761 AS SELECT * FROM ACH_DRFTS_EXT_CTRL  PARALLEL;
CREATE TABLE MISCTRAN_761 AS SELECT * FROM MISCTRAN  PARALLEL;
CREATE TABLE OVERSHRT_761 AS SELECT * FROM OVERSHRT  PARALLEL;
--BACKUP UAR TABLES
CREATE TABLE UAR_SUMM_EXTRCT_CNTRL_FL_761 AS SELECT * FROM UAR_SUMMARY_EXTRCT_CNTRL_FL  PARALLEL;
CREATE TABLE UAR_ACH_DRFTS_EXT_CTRL_761 AS SELECT * FROM UAR_ACH_DRFTS_EXT_CTRL  PARALLEL;
CREATE TABLE UAR_JV_EXTRCT_CNTRL_FL_761 AS SELECT * FROM UAR_JV_EXTRCT_CNTRL_FL  PARALLEL;
CREATE TABLE UAR_MISCTRAN_761 AS SELECT * FROM UAR_MISCTRAN  PARALLEL;
CREATE TABLE UAR_OVERSHRT_761 AS SELECT * FROM UAR_OVERSHRT  PARALLEL;

/******CLEAN UP***************************************************************************************
--DROPS UNUSED COLS
--CHANGES NUMERIC VARCHAR2 FIELDS TO NUMBER FIELDS
--AND  CONVERTS 4 DIGIT COST CENTER CODES TO 6 DIGIT EQUIVALENTS
*******************************************************************************************************/
--CLEAN DATA AND LOAD INTO TEMP TABLES 
CREATE TABLE SUMMARY_EXTRCT_CNTRL_FL_TEMP AS  WITH C AS (SELECT COST_CENTER_CODE, SUBSTR(COST_CENTER_CODE,3) COST_CENTER_CC4 FROM COST_CENTER) 
                                             SELECT CAST(
                                                       NVL( 
                                                            (SELECT /*+  index(C COST_CENTER_NX02) */ MIN(C.COST_CENTER_CODE) 
                                                                                                FROM  C
                                                               WHERE COST_CENTER_CC4 = SUBSTR(A.COST_CENTER_CODE,-4))
                                                            ,A.COST_CENTER_CODE
                                                          ) 
                                                       AS VARCHAR2(6)
                                                    ) COST_CENTER_CODE,
                                                    CENTURY, 
                                                    CAST(TO_NUMBER(BANK_DEP_AMT)/100 AS NUMBER(10,2)) BANK_DEP_AMT, 
                                                    BANK_ACCOUNT_NBR, 
                                                    TRANSACTION_DATE, 
                                                    LOAD_DATE, 
                                                    ORIGINATED_BANK_ACCNT_NBR 
                                               FROM SUMMARY_EXTRCT_CNTRL_FL A; 
                                                                                                                                          
CREATE TABLE ACH_DRFTS_EXT_CTRL_TEMP AS WITH C AS (SELECT COST_CENTER_CODE, SUBSTR(COST_CENTER_CODE,3) COST_CENTER_CC4 FROM COST_CENTER) 
                                        SELECT  CAST(
                                                       NVL( 
                                                            (SELECT /*+  index(C COST_CENTER_NX02) */ MIN(C.COST_CENTER_CODE) 
                                                                                                FROM  C
                                                               WHERE COST_CENTER_CC4 = SUBSTR(A.COST_CENTER_CODE,-4))
                                                            ,A.COST_CENTER_CODE
                                                          ) 
                                                       AS VARCHAR2(6)
                                                    ) COST_CENTER_CODE,
                                                CENTURY,
                                                TRANSACTION_DATE,
                                                CAST(TO_NUMBER(BANK_DEP_AMT)/100 AS NUMBER(10,2)) BANK_DEP_AMT,  
                                                BANK_ACCOUNT_NBR,
                                                LOAD_DATE,
                                                ORIGINATED_BANK_ACCNT_NBR
                                           FROM ACH_DRFTS_EXT_CTRL A;
                                                                                    

CREATE TABLE MISCTRAN_TEMP AS WITH C AS (SELECT COST_CENTER_CODE, SUBSTR(COST_CENTER_CODE,3) COST_CENTER_CC4 FROM COST_CENTER)
                              SELECT BANK_ACCOUNT_NBR,
                                    CAST(
                                                       NVL( 
                                                            (SELECT /*+  index(C COST_CENTER_NX02) */ MIN(C.COST_CENTER_CODE) 
                                                                                                FROM  C
                                                               WHERE COST_CENTER_CC4 = SUBSTR(A.COST_CENTER_CODE,-4))
                                                            ,A.COST_CENTER_CODE
                                                          ) 
                                                       AS VARCHAR2(6)
                                                    ) COST_CENTER_CODE,
                                    CAST(TO_NUMBER(AMOUNT)/100 AS NUMBER(10,2)) AMOUNT,
                                    TRANSACTION_DATE,
                                    TCODE,
                                    CAST(TO_NUMBER(TRAN_SEQNUM) AS NUMBER) TRAN_SEQNUM,
                                    DB_CR_CODE,
                                    SNZ_SAM_CODE,
                                    LOAD_DATE,
                                    ORIGINATED_BANK_ACCNT_NBR 
                               FROM MISCTRAN A ; 

CREATE TABLE OVERSHRT_TEMP AS WITH C AS (SELECT COST_CENTER_CODE, SUBSTR(COST_CENTER_CODE,3) COST_CENTER_CC4 FROM COST_CENTER)
                             SELECT BANK_ACCOUNT_NBR,
                                    CAST(
                                                       NVL( 
                                                            (SELECT /*+  index(C COST_CENTER_NX02) */ MIN(C.COST_CENTER_CODE) 
                                                                                                FROM  C
                                                               WHERE COST_CENTER_CC4 = SUBSTR(A.COST_CENTER_CODE,-4))
                                                            ,A.COST_CENTER_CODE
                                                          ) 
                                                       AS VARCHAR2(6)
                                                    ) COST_CENTER_CODE,
                                    CAST(TO_NUMBER(AMOUNT)/100 AS NUMBER(10,2)) AMOUNT,
                                    TRANSACTION_DATE,
                                    TCODE,
                                    CAST(TO_NUMBER(TRAN_SEQNUM) AS NUMBER) TRAN_SEQNUM,
                                    TRAN_CODE,
                                    LOAD_DATE,
                                    ORIGINATED_BANK_ACCNT_NBR 
                               FROM OVERSHRT  A ; 


--CHECK IF TEMP TABLE WITH CLEANUP DATA GOT PROPERLY CREATED WITHOUT ANY ERRORS BEFORE DROPPING ORIGINAL TABLES
DECLARE
    M_REC_COUNT NUMBER;
BEGIN
    M_REC_COUNT :=0;
    SELECT COUNT(1) INTO M_REC_COUNT FROM SUMMARY_EXTRCT_CNTRL_FL_TEMP ;
    IF M_REC_COUNT > 0 THEN
      EXECUTE IMMEDIATE 'DROP TABLE SUMMARY_EXTRCT_CNTRL_FL';
      EXECUTE IMMEDIATE 'ALTER TABLE SUMMARY_EXTRCT_CNTRL_FL_TEMP RENAME TO SUMMARY_EXTRCT_CNTRL_FL';
    END IF;

    M_REC_COUNT :=0;
    SELECT COUNT(1) INTO M_REC_COUNT FROM ACH_DRFTS_EXT_CTRL_TEMP;
    IF M_REC_COUNT > 0 THEN
      EXECUTE IMMEDIATE 'DROP TABLE ACH_DRFTS_EXT_CTRL';
      EXECUTE IMMEDIATE 'ALTER TABLE ACH_DRFTS_EXT_CTRL_TEMP RENAME TO ACH_DRFTS_EXT_CTRL';
    END IF;


    M_REC_COUNT :=0;
    SELECT COUNT(1) INTO M_REC_COUNT FROM  MISCTRAN_TEMP ;
    IF M_REC_COUNT > 0 THEN
      EXECUTE IMMEDIATE 'DROP TABLE MISCTRAN';
      EXECUTE IMMEDIATE 'ALTER TABLE MISCTRAN_TEMP RENAME TO MISCTRAN';
    END IF;

    M_REC_COUNT :=0;
    SELECT COUNT(1) INTO M_REC_COUNT FROM OVERSHRT_TEMP;
    IF M_REC_COUNT > 0 THEN
      EXECUTE IMMEDIATE 'DROP TABLE OVERSHRT';
      EXECUTE IMMEDIATE 'ALTER TABLE OVERSHRT_TEMP RENAME TO OVERSHRT';
		END IF;
END;
/


--COMPILE VIEWS
ALTER VIEW ACH_DRFTS_EXTRCT_CNTRL_FL_VW COMPILE;
ALTER VIEW SUMMARY_EXTRCT_CNTRL_FL_VW COMPILE;


