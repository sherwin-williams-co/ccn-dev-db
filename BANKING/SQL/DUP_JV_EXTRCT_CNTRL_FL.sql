/*
Created : 02/24/2016 dxv848/nxk927 removing the duplicate records in the SUMMARY_EXTRCT_CNTRL_FL table
*/
-- creating the JV_EXTRCT_CNTRL_FL_TEMP table
CREATE TABLE JV_EXTRCT_CNTRL_FL_TEMP AS  SELECT * FROM JV_EXTRCT_CNTRL_FL where 1=0;

/
-- Select the distinct records  from JV_EXTRCT_CNTRL_FL and insert into JV_EXTRCT_CNTRL_FL_TEMP table
DECLARE
v_count NUMBER:= 0;
BEGIN
FOR REC IN (
    SELECT *  
      FROM JV_EXTRCT_CNTRL_FL a
     WHERE load_date = (SELECT MIN(load_date) 
                          FROM JV_EXTRCT_CNTRL_FL 
                         WHERE BANK_ACCOUNT_NBR            =a.BANK_ACCOUNT_NBR
 	                       AND COST_CENTER_CODE            =a.COST_CENTER_CODE
                           AND CENTURY                     =a.CENTURY
                           AND NVL(TRAN_SEQNUM ,'X')       =NVL(a.TRAN_SEQNUM,'X')  
                           AND NVL(TCODE ,'X')             =NVL(a.TCODE,'X')
                           AND NVL(AMOUNT,'X')             =NVL(a.AMOUNT,'X')
                           AND NVL(JV_TYPE,'X')            =NVL(a.JV_TYPE,'X')
                           AND NVL(CFA_SIGN ,'X')          =NVL(a.CFA_SIGN ,'X')
                           AND NVL(REFEED_TCODE ,'X')      =NVL(a.REFEED_TCODE ,'X')
                           AND NVL(DR_DIV ,'X')            =NVL(a.DR_DIV ,'X')
                           AND NVL(DR_PRIME,'X')           =NVL(a.DR_PRIME ,'X')
                           AND NVL(DR_SUB ,'X')            =NVL(a.DR_SUB ,'X')
                           AND NVL(DR_CC ,'X')             =NVL(a.DR_CC  ,'X')
                           AND NVL(DR_PROJ ,'X')           =NVL(a.DR_PROJ  ,'X')
                           AND NVL(DR_OFFSET_CDE ,'X')     =NVL(a.DR_OFFSET_CDE ,'X')
                           AND NVL(CR_DIV ,'X')            =NVL(a.CR_DIV  ,'X')
                           AND NVL(CR_PRIME ,'X')          =NVL(a.CR_PRIME  ,'X')
                           AND NVL(CR_SUB ,'X')            =NVL(a.CR_SUB  ,'X')
                           AND NVL(CR_CC ,'X')             =NVL(a.CR_CC  ,'X')
                           AND NVL(CR_PROJ  ,'X')          =NVL(a.CR_PROJ  ,'X')
                           AND NVL(CR_OFFSET_CDE ,'X')     =NVL(a.CR_OFFSET_CDE  ,'X')
                           AND TRANSACTION_DATE =a.TRANSACTION_DATE)) LOOP
    v_count := v_count +1;
    INSERT INTO JV_EXTRCT_CNTRL_FL_TEMP VALUES rec;
    IF v_count =100 THEN
        v_count:= 0;
        COMMIT;
    END IF;
END LOOP;
COMMIT;
END;

/
-- check the count of the JV_EXTRCT_CNTRL_FL_TEMP table
SELECT COUNT(*) FROM JV_EXTRCT_CNTRL_FL_TEMP;

/

-- DROP the JV_EXTRCT_CNTRL_FL table
DROP TABLE JV_EXTRCT_CNTRL_FL;

/

-- RENAME THE table  
ALTER TABLE JV_EXTRCT_CNTRL_FL_TEMP RENAME TO JV_EXTRCT_CNTRL_FL;

/