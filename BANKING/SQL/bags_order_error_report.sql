/**********************************************************
  This script will generate the excel report for the deposit
  bags that failed while ordering today with reason for failure
  and send the report through email to the SMIS group

created : gxg192 12/20/2016
modified: 
**********************************************************/
DECLARE
   CURSOR dep_bag_cur IS
       SELECT 'Bag Orders' PROCESS, COST_CENTER_CODE,
              CASE WHEN ERROR_TEXT LIKE '%cost center%closed%dummy%'
                      THEN 'The cost center is either closed or a dummy cost center.'
                   WHEN ERROR_TEXT like '%Deposit bag can not be ordered on reorder switch of L%'
                      THEN 'Deposit bag can not be ordered on reorder switch of L'
                   ELSE ERROR_TEXT end as ERROR_TEXT
       FROM ERROR_LOG EL
      WHERE MODULE = 'DPST_BAGS_UPDATE_BATCH_PKG.PROCESS'
        AND TRUNC(ERROR_DATE) = TRUNC(SYSDATE)
        AND ERROR_TEXT IS NOT NULL;
 
   V_CLOB   CLOB;    
BEGIN
   DBMS_OUTPUT.PUT_LINE('Generating report for Deposit Bag Orders on: ' || TO_CHAR(SYSDATE, 'mm/dd/yyyy hh:mi:ss'));
   FOR REC IN dep_bag_cur
   LOOP
      V_CLOB := V_CLOB
                ||REC.PROCESS||','
                ||REC.COST_CENTER_CODE ||','
                ||REC.ERROR_TEXT|| CHR(9) ||CHR(10);
   END LOOP;
   
   IF V_CLOB <> EMPTY_CLOB() THEN

      --Appending the header
      V_CLOB  := 'PROCESS,COST_CENTER,REASON_FOR_FAILURE'||  UTL_TCP.crlf || V_CLOB;

   ELSE
      DBMS_OUTPUT.PUT_LINE('No Records found in Error log for Deposit Bag Orders');
   END IF;

   --Sending the Email
   MAIL_PKG.SEND_MAIL('DEP_BAGORD_ERROR_RPT', NULL, NULL, V_CLOB);
   DBMS_OUTPUT.PUT_LINE('Error report for Deposit Ticket Orders completed and emailed on: ' || TO_CHAR(SYSDATE, 'mm/dd/yyyy hh:mi:ss')); 

EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error Reporting for Deposit Bag Orders FAILED: ' || SQLCODE || ' ' || substr(SQLERRM,1,500));
      :exitCode := 2;
END;
/
