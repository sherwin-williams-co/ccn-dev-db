/*
Created : 10/31/2016 SXH487 CCN Project Team....
          Below script will update the STD_COST_IDENTIFIER and PRIM_COST_IDENTIFIER columns in the table COST_CENTER to NULL
        : 11/10/2016 nxk927 CCN Project Team....
          added two more cost center to be update the STD_COST_IDENTIFIER and PRIM_COST_IDENTIFIER columns in the table COST_CENTER to NULL
*/
BEGIN
    CCN_BATCH_PKG.LOCK_DATABASE_SP();
END;
/

SELECT * FROM COST_CENTER WHERE COST_CENTER_CODE = '76749T';
--1 Row(s) Selected
UPDATE COST_CENTER 
   SET STD_COST_IDENTIFIER = NULL,
       PRIM_COST_IDENTIFIER = NULL
 WHERE COST_CENTER_CODE ='76749T';
--1 Row(s) Updated

SELECT * FROM COST_CENTER WHERE COST_CENTER_CODE = '76752T';
--1 Row(s) Selected
UPDATE COST_CENTER 
   SET STD_COST_IDENTIFIER = NULL,
       PRIM_COST_IDENTIFIER = NULL
 WHERE COST_CENTER_CODE ='76752T';
--1 Row(s) Updated

SELECT * FROM COST_CENTER WHERE COST_CENTER_CODE = '76753T';
--1 Row(s) Selected
UPDATE COST_CENTER 
   SET STD_COST_IDENTIFIER = NULL,
       PRIM_COST_IDENTIFIER = NULL
 WHERE COST_CENTER_CODE ='76753T';
--1 Row(s) Updated

SELECT * FROM COST_CENTER WHERE COST_CENTER_CODE = '76754T';
--1 Row(s) Selected
UPDATE COST_CENTER 
   SET STD_COST_IDENTIFIER = NULL,
       PRIM_COST_IDENTIFIER = NULL
 WHERE COST_CENTER_CODE ='76754T';
--1 Row(s) Updated

SELECT * FROM COST_CENTER WHERE COST_CENTER_CODE = '76782T';
--1 Row(s) Selected
UPDATE COST_CENTER 
   SET STD_COST_IDENTIFIER = NULL,
       PRIM_COST_IDENTIFIER = NULL
 WHERE COST_CENTER_CODE ='76782T';
--1 Row(s) Updated

--nxk927
SELECT * FROM COST_CENTER WHERE COST_CENTER_CODE = '76Q799';
--1 Row(s) Selected
UPDATE COST_CENTER
   SET STD_COST_IDENTIFIER = NULL,
       PRIM_COST_IDENTIFIER = NULL
 WHERE COST_CENTER_CODE ='76Q799';
--1 Row(s) Updated

SELECT * FROM COST_CENTER WHERE COST_CENTER_CODE = '76Q796';
--1 Row(s) Selected
UPDATE COST_CENTER
   SET STD_COST_IDENTIFIER = NULL,
       PRIM_COST_IDENTIFIER = NULL
 WHERE COST_CENTER_CODE ='76Q796';
--1 Row(s) Updated

COMMIT;

BEGIN
    CCN_BATCH_PKG.UNLOCK_DATABASE_SP();
END;
/

