/***************************************************************************************************************************************************
    The below script will update the records that have been outstanding for more than 90 days and those records whicg are 
    present HST_STORE_DRAFTS table as the 90_void_pay_rpt process will not update these records through the job .So these
    records are updated manually.

Created : 03/20/2018 bxa919 CCN Project Team... -ASP 1032      
*****************************************************************************************************************************************************/
--Below details will be validated against query mentinoed right below it
SELECT CHECK_SERIAL_NUMBER, ISSUE_DATE, VOID_DATE, STOP_PAY_DATE, CHANGE_DATE, PAID_DATE
  FROM STORE_DRAFTS 
 WHERE CHECK_SERIAL_NUMBER IN (
          '0873215297', '0890610025', '0879410140', '0882910045', '0357610013', '0882210206', '0890710197', '0873215537', '0880600010', '0880610258',
          '0870218799', '0882610223', '0885110007', '0876511320', '0872113964', '0357710110', '0875012510', '0876411364', '0880810536', '0140911835',
          '0142011097', '0271512741', '0227119294', '0433714664', '0523217982', '0704023472', '0871619789', '0873910582', '0975220039', '0930620539')
   AND PAID_DATE IS NULL
   AND VOID_DATE IS NULL;
   
--Actual script in the Job which will fetch the reocrds which  have been outstanding for more than 90 days  
        SELECT *
          FROM STORE_DRAFTS A
         WHERE (VOID_DATE IS NULL AND STOP_PAY_DATE IS NULL) --open
           AND PAID_DATE IS NULL --not paid yet
           AND EXISTS (SELECT 1
                         FROM HIERARCHY_DETAIL_VIEW
                        WHERE COST_CENTER_CODE = A.COST_CENTER_CODE
                          AND HRCHY_HDR_NAME   = 'GLOBAL_HIERARCHY'
                          AND DIVISION IN ('05','08','09')) --considering only '05','08','09' stores
           AND ISSUE_DATE < (TRUNC(SYSDATE) - 90) --outstanding more than 90 days;
           ;
--Below query contains the list of records which were provided by the user to make sure these records are mark as VOID 
SELECT CHECK_SERIAL_NUMBER, ISSUE_DATE, VOID_DATE, STOP_PAY_DATE, CHANGE_DATE, PAID_DATE
  FROM HST_STORE_DRAFTS
 WHERE CHECK_SERIAL_NUMBER IN (
 '0873215297', '0890610025', '0879410140', '0882910045', '0357610013', '0882210206', '0890710197', '0873215537', '0880600010', '0880610258',
 '0870218799', '0882610223', '0885110007', '0876511320', '0872113964', '0357710110', '0875012510', '0876411364', '0880810536', '0140911835',
 '0142011097', '0271512741', '0227119294', '0433714664', '0523217982', '0704023472', '0871619789', '0873910582', '0975220039', '0930620539')
   AND PAID_DATE IS NULL
   AND VOID_DATE IS NULL;

--Below query contains the list of records which were provided by the user in order to make sure these records are mark as VOID
SELECT CHECK_SERIAL_NUMBER, ISSUE_DATE, VOID_DATE, STOP_PAY_DATE, CHANGE_DATE, PAID_DATE
FROM UNATTACHED_MNL_DRFT_DTL WHERE CHECK_SERIAL_NUMBER IN (
 '0873215297', '0890610025', '0879410140', '0882910045', '0357610013', '0882210206', '0890710197', '0873215537', '0880600010', '0880610258',
 '0870218799', '0882610223', '0885110007', '0876511320', '0872113964', '0357710110', '0875012510', '0876411364', '0880810536', '0140911835',
 '0142011097', '0271512741', '0227119294', '0433714664', '0523217982', '0704023472', '0871619789', '0873910582', '0975220039', '0930620539'
);

--Below query contains the list of records which were provided by the user in order to make sure these records are mark as VOID
SELECT CHECK_SERIAL_NUMBER, ISSUE_DATE, VOID_DATE, STOP_PAY_DATE, CHANGE_DATE, PAID_DATE
FROM UNATTACHED_MNL_DRFT_DTL_HST WHERE CHECK_SERIAL_NUMBER IN (
 '0873215297', '0890610025', '0879410140', '0882910045', '0357610013', '0882210206', '0890710197', '0873215537', '0880600010', '0880610258',
 '0870218799', '0882610223', '0885110007', '0876511320', '0872113964', '0357710110', '0875012510', '0876411364', '0880810536', '0140911835',
 '0142011097', '0271512741', '0227119294', '0433714664', '0523217982', '0704023472', '0871619789', '0873910582', '0975220039', '0930620539'
);
   
--For those records which are present in the above list the script will mark check serial number's status to void
UPDATE HST_STORE_DRAFTS
   SET VOID_DATE           = LAST_DAY(ADD_MONTHS(TRUNC(SYSDATE), -1)),
       VOID_INDICATOR      = 'Y',
       VOID_MARKED_BY_CCN  = 'Y',
       --open indicator will be N if both void and stop pay dates are not null
       OPEN_INDICATOR      = CASE WHEN STOP_PAY_DATE IS NOT NULL THEN 'N' ELSE OPEN_INDICATOR END,
       CHANGE_DATE         = TRUNC(SYSDATE)
 WHERE CHECK_SERIAL_NUMBER IN ('0271512741','0873215297')
   AND PAID_DATE IS NULL
   AND VOID_DATE IS NULL;
 
 COMMIT;
 
--Below records are from STORE_DRAFTS  table from production for reference 
/*
CHECK_SERI ISSUE_DATE           VOID_DATE                       STOP_PAY_DATE                   CHANGE_DATE                     PAID_DATE                      
---------- -------------------- ------------------------------- ------------------------------- ------------------------------- -------------------------------
0975220039 01-NOV-2016 00:00:00                                                                                                                                
0875012510 15-SEP-2017 00:00:00                                                                                                                                
0890610025 28-SEP-2016 00:00:00                                                                                                                                
0882910045 20-OCT-2016 00:00:00                                                                                                                                
0872113964 25-JUL-2017 00:00:00                                                                                                                                
0357710110 06-SEP-2017 00:00:00                                                                                                                                
0885110007 05-JUL-2017 00:00:00                                                                                                                                
0873215537 13-FEB-2017 00:00:00                                                                                                                                
0930620539 02-FEB-2017 00:00:00                                                                                                                                
0142011097 16-JAN-2018 00:00:00                                                                                                 06-FEB-2018 00:00:00           
0227119294 07-FEB-2017 00:00:00                                                                                                                                
0357610013 15-NOV-2016 00:00:00                                                                 16-NOV-2016 00:00:00                                           
0879410140 03-OCT-2016 00:00:00                                                                                                                                
0882610223 29-JUN-2017 00:00:00                                                                                                                                
0890710197 19-JAN-2017 00:00:00                                                                                                                                
0876511320 07-JUL-2017 00:00:00                                                                                                                                
0433714664 21-OCT-2016 00:00:00                                                                                                                                
0880810536 22-NOV-2017 00:00:00                                                                                                                                
0871619789 08-JUN-2017 00:00:00                                                                                                                                
0523217982 23-FEB-2017 00:00:00                                                                                                                                
0704023472 17-JUL-2017 00:00:00                                                                                                                                
0880600010 06-APR-2017 00:00:00 19-FEB-2018 00:00:00                                                                                                           
0880610258 06-APR-2017 00:00:00 19-FEB-2018 00:00:00                                                                                                           
0876411364 06-OCT-2017 00:00:00                                                                                                                                
0140911835 28-MAR-2017 00:00:00                                                                                                                                
0870218799 10-MAY-2017 00:00:00                                                                                                                                
0882210206 20-DEC-2016 00:00:00                                                                                                                                

27 rows selected. 

--Below records are from HST_STORE_DRAFTS  table from production for reference 

CHECK_SERI ISSUE_DATE           VOID_DATE                       STOP_PAY_DATE                   CHANGE_DATE                     PAID_DATE                      
---------- -------------------- ------------------------------- ------------------------------- ------------------------------- -------------------------------
0271512741 18-MAY-2016 00:00:00                                                                                                                                
0433714664 15-MAY-2000 00:00:00                                                                 16-MAY-2000 00:00:00            22-MAY-2000 00:00:00           
0873215297 16-SEP-2016 00:00:00                                                                                                                                
0873910582 27-JAN-2016 00:00:00                                                                                                 29-JAN-2016 00:00:00           
*/