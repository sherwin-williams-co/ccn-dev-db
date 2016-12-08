/*
12/07/2016 NXK927 
*** TAKE THE BACKUP BEFORE UPDATING*****
/*
     SELECT * 
       FROM BANK_DEP_TICK 
      WHERE COST_CENTER_CODE IN (SELECT MEMBER_STORE_NBR
                                   FROM MEMBER_BANK_CC
                                  WHERE NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE)
                                  UNION           
                                  SELECT LEAD_STORE_NBR
                                    FROM LEAD_BANK_CC
                                   WHERE NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE))
      AND (BANK_ACCOUNT_NBR, COST_CENTER_CODE) NOT IN (SELECT LEAD_BANK_ACCOUNT_NBR,MEMBER_STORE_NBR
                                                           FROM MEMBER_BANK_CC
                                                          WHERE NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE)
                                                          UNION           
                                                         SELECT LEAD_BANK_ACCOUNT_NBR, LEAD_STORE_NBR
                                                           FROM LEAD_BANK_CC
                                                          WHERE NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE));
    SELECT *
      FROM BANK_DEP_TICKORD
     WHERE COST_CENTER_CODE IN (SELECT MEMBER_STORE_NBR
                                   FROM MEMBER_BANK_CC
                                  WHERE NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE)
                                  UNION           
                                  SELECT LEAD_STORE_NBR
                                    FROM LEAD_BANK_CC
                                   WHERE NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE))
       AND (BANK_ACCOUNT_NBR,COST_CENTER_CODE)  NOT IN (SELECT LEAD_BANK_ACCOUNT_NBR,MEMBER_STORE_NBR
                                                           FROM MEMBER_BANK_CC
                                                          WHERE NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE)
                                                          UNION           
                                                         SELECT LEAD_BANK_ACCOUNT_NBR, LEAD_STORE_NBR
                                                           FROM LEAD_BANK_CC
                                                          WHERE NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE));
														  
     SELECT * 
       FROM BANK_DEP_BAG_TICK 
      WHERE COST_CENTER_CODE IN (SELECT MEMBER_STORE_NBR
                                   FROM MEMBER_BANK_CC
                                  WHERE NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE)
                                  UNION           
                                  SELECT LEAD_STORE_NBR
                                    FROM LEAD_BANK_CC
                                   WHERE NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE))
      AND (BANK_ACCOUNT_NBR, COST_CENTER_CODE) NOT IN (SELECT LEAD_BANK_ACCOUNT_NBR,MEMBER_STORE_NBR
                                                           FROM MEMBER_BANK_CC
                                                          WHERE NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE)
                                                          UNION           
                                                         SELECT LEAD_BANK_ACCOUNT_NBR, LEAD_STORE_NBR
                                                           FROM LEAD_BANK_CC
                                                          WHERE NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE));

    SELECT *
      FROM BANK_DEP_BAG_TICKORD
     WHERE COST_CENTER_CODE IN (SELECT MEMBER_STORE_NBR
                                   FROM MEMBER_BANK_CC
                                  WHERE NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE)
                                  UNION           
                                  SELECT LEAD_STORE_NBR
                                    FROM LEAD_BANK_CC
                                   WHERE NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE))
       AND (BANK_ACCOUNT_NBR,COST_CENTER_CODE)  NOT IN (SELECT LEAD_BANK_ACCOUNT_NBR,MEMBER_STORE_NBR
                                                           FROM MEMBER_BANK_CC
                                                          WHERE NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE)
                                                          UNION           
                                                         SELECT LEAD_BANK_ACCOUNT_NBR, LEAD_STORE_NBR
                                                           FROM LEAD_BANK_CC
                                                          WHERE NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE));
														  
*/
/*
1) BANK NUMBER UPDATE TO FIX THE BANK ACCOUNT NUMBER IN DEPOSIT TICKET AND BAG TABLE
2) EFFECTIVE DATE FOR THE DEPOSIT TICKET AND BAG
3) UPDATING THE LAST ORDER DATE IN THE DEPOSIT TICKET/BAG TABLE
4) COMMIT ONLY AFTER VALIDATING THE DATA

*/
DECLARE
  CURSOR CUR_DEP_TKT IS 
     SELECT * 
       FROM BANK_DEP_TICK 
      WHERE COST_CENTER_CODE IN (SELECT MEMBER_STORE_NBR
                                   FROM MEMBER_BANK_CC
                                  WHERE NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE)
                                  UNION           
                                  SELECT LEAD_STORE_NBR
                                    FROM LEAD_BANK_CC
                                   WHERE NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE))
      AND (BANK_ACCOUNT_NBR, COST_CENTER_CODE) NOT IN (SELECT LEAD_BANK_ACCOUNT_NBR,MEMBER_STORE_NBR
                                                           FROM MEMBER_BANK_CC
                                                          WHERE NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE)
                                                          UNION           
                                                         SELECT LEAD_BANK_ACCOUNT_NBR, LEAD_STORE_NBR
                                                           FROM LEAD_BANK_CC
                                                          WHERE NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE));
 
 CURSOR CUR_DEP_TKTORD IS
    SELECT *
      FROM BANK_DEP_TICKORD
     WHERE COST_CENTER_CODE IN (SELECT MEMBER_STORE_NBR
                                   FROM MEMBER_BANK_CC
                                  WHERE NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE)
                                  UNION           
                                  SELECT LEAD_STORE_NBR
                                    FROM LEAD_BANK_CC
                                   WHERE NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE))
       AND (BANK_ACCOUNT_NBR,COST_CENTER_CODE)  NOT IN (SELECT LEAD_BANK_ACCOUNT_NBR,MEMBER_STORE_NBR
                                                           FROM MEMBER_BANK_CC
                                                          WHERE NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE)
                                                          UNION           
                                                         SELECT LEAD_BANK_ACCOUNT_NBR, LEAD_STORE_NBR
                                                           FROM LEAD_BANK_CC
                                                          WHERE NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE));
  CURSOR CUR_DEP_BAG_TKT IS 
     SELECT * 
       FROM BANK_DEP_BAG_TICK 
      WHERE COST_CENTER_CODE IN (SELECT MEMBER_STORE_NBR
                                   FROM MEMBER_BANK_CC
                                  WHERE NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE)
                                  UNION           
                                  SELECT LEAD_STORE_NBR
                                    FROM LEAD_BANK_CC
                                   WHERE NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE))
      AND (BANK_ACCOUNT_NBR, COST_CENTER_CODE) NOT IN (SELECT LEAD_BANK_ACCOUNT_NBR,MEMBER_STORE_NBR
                                                           FROM MEMBER_BANK_CC
                                                          WHERE NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE)
                                                          UNION           
                                                         SELECT LEAD_BANK_ACCOUNT_NBR, LEAD_STORE_NBR
                                                           FROM LEAD_BANK_CC
                                                          WHERE NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE));
 
 CURSOR CUR_DEP_BAGORD IS
    SELECT *
      FROM BANK_DEP_BAG_TICKORD
     WHERE COST_CENTER_CODE IN (SELECT MEMBER_STORE_NBR
                                   FROM MEMBER_BANK_CC
                                  WHERE NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE)
                                  UNION           
                                  SELECT LEAD_STORE_NBR
                                    FROM LEAD_BANK_CC
                                   WHERE NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE))
       AND (BANK_ACCOUNT_NBR,COST_CENTER_CODE)  NOT IN (SELECT LEAD_BANK_ACCOUNT_NBR,MEMBER_STORE_NBR
                                                           FROM MEMBER_BANK_CC
                                                          WHERE NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE)
                                                          UNION           
                                                         SELECT LEAD_BANK_ACCOUNT_NBR, LEAD_STORE_NBR
                                                           FROM LEAD_BANK_CC
                                                          WHERE NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE));

  CURSOR CUR_BANK_ACT_NBR(P_CC IN varchar2) IS
    SELECT LEAD_BANK_ACCOUNT_NBR
      FROM MEMBER_BANK_CC
     WHERE MEMBER_STORE_NBR = P_CC
       AND NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE)
     UNION           
    SELECT LEAD_BANK_ACCOUNT_NBR
      FROM LEAD_BANK_CC
     WHERE LEAD_STORE_NBR = P_CC
       AND NVL(EXPIRATION_DATE,TRUNC(SYSDATE)) >= TRUNC(SYSDATE);
BEGIN
  FOR REC IN CUR_DEP_TKT LOOP
     FOR REC1 IN CUR_BANK_ACT_NBR(REC.COST_CENTER_CODE) LOOP
        REC.EXPIRATION_DATE := REC.EFFECTIVE_DATE;
        INSERT INTO BANK_DEP_TICK_HIST VALUES REC;
        UPDATE BANK_DEP_TICK
           SET BANK_ACCOUNT_NBR = REC1.LEAD_BANK_ACCOUNT_NBR
         WHERE COST_CENTER_CODE = REC.COST_CENTER_CODE;
    END LOOP;
  END LOOP;
  
  FOR REC2 IN CUR_DEP_TKTORD LOOP
     FOR REC1 IN CUR_BANK_ACT_NBR(REC2.COST_CENTER_CODE) LOOP
         REC2.EXPIRATION_DATE := REC2.EFFECTIVE_DATE;
         INSERT INTO BANK_DEP_TICKORD_HIST VALUES REC2;
         UPDATE BANK_DEP_TICKORD
            SET BANK_ACCOUNT_NBR = REC1.LEAD_BANK_ACCOUNT_NBR
          WHERE COST_CENTER_CODE = REC2.COST_CENTER_CODE;
    END LOOP;
 END LOOP;
    
  FOR REC3 IN CUR_DEP_BAG_TKT LOOP
     FOR REC1 IN CUR_BANK_ACT_NBR(REC3.COST_CENTER_CODE) LOOP
        REC3.EXPIRATION_DATE := REC3.EFFECTIVE_DATE;
        INSERT INTO BANK_DEP_BAG_TICK_HIST VALUES REC3;
        UPDATE BANK_DEP_BAG_TICK
           SET BANK_ACCOUNT_NBR = REC1.LEAD_BANK_ACCOUNT_NBR
         WHERE COST_CENTER_CODE = REC3.COST_CENTER_CODE;
    END LOOP;
  END LOOP;
  
  FOR REC4 IN CUR_DEP_BAGORD LOOP
     FOR REC1 IN CUR_BANK_ACT_NBR(REC4.COST_CENTER_CODE) LOOP
         REC4.EXPIRATION_DATE := REC4.EFFECTIVE_DATE;
         INSERT INTO BANK_DEP_BAG_TICKORD_HIST VALUES REC4;
         UPDATE BANK_DEP_BAG_TICKORD
            SET BANK_ACCOUNT_NBR = REC1.LEAD_BANK_ACCOUNT_NBR
          WHERE COST_CENTER_CODE = REC4.COST_CENTER_CODE;
       END LOOP;
    END LOOP;
END;

--commit only after validating the data that the deposit ticket/bag and deposit ticket/bag orders bank account number matches the member or lead bank account number
commit;
/


DECLARE
  CURSOR CUR_DEP_TICK IS 
    SELECT COST_CENTER_CODE, ORDER_DATE,LAST_MAINTENANCE_DATE
      FROM BANK_DEP_TICKORD A
     WHERE BANK_DEP_TICK_FTR_ID = (SELECT MAX(BANK_DEP_TICK_FTR_ID)
                                     FROM BANK_DEP_TICKORD
                                    WHERE COST_CENTER_CODE = A.COST_CENTER_CODE);
BEGIN
FOR REC IN CUR_DEP_TICK LOOP
   UPDATE BANK_DEP_TICK
      SET LAST_VW_ORDER_DATE    = REC.ORDER_DATE,
          LAST_MAINTENANCE_DATE = REC.LAST_MAINTENANCE_DATE
    WHERE COST_CENTER_CODE      = REC.COST_CENTER_CODE;
END LOOP;
END;

--commit only after validating the data that the deposit ticket has the same LAST_VW_ORDER_DATE as the last order date from the deposit order table
commit;

/
DECLARE
  CURSOR CUR_DEP_BAG_TICK IS 
    SELECT COST_CENTER_CODE, ORDER_DATE
      FROM BANK_DEP_BAG_TICKORD A
     WHERE BANK_DEP_BAG_FTR_ID = (SELECT MAX(BANK_DEP_BAG_FTR_ID)
                                    FROM BANK_DEP_BAG_TICKORD
                                   WHERE COST_CENTER_CODE = A.COST_CENTER_CODE);
BEGIN
FOR REC IN CUR_DEP_BAG_TICK LOOP
   UPDATE BANK_DEP_BAG_TICK
      SET DEPBAG_LAST_ORDER_DATE= REC.ORDER_DATE
    WHERE COST_CENTER_CODE      = REC.COST_CENTER_CODE;
END LOOP;
END;
/

--commit only after validating the data that the deposit bag has the same DEPBAG_LAST_ORDER_DATE as the last order date from the deposit bag order table
commit;

/

UPDATE BANK_DEP_TICK
   SET IMAGES_PER_PAGE = 3,
       NBR_FORMS_PER_BK = 108,
       SHEETS_OF_PAPER_PER_BK = 324,
       REORDER_NUMBER_BKS = NVL(REORDER_NUMBER_BKS,1);

Commit;
/