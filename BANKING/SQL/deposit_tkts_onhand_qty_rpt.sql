/*****************************************************************
  This script will generate the excel report for Deposit Tickets.
  Which describes Store #,Store Name, OnHand Quantity, Last Order Date and Last Maintenance Date and
  send email to the SMIS group

  This excel should generate after DPST_TCKTS_UPDT_BTCH daily batch job,
  and DPST_TCKTS_UPDT_BTCH job scheduled daily at 7 AM,
  hence This script will execute daily at 8 AM.

created : sxp130 06/22/2017 ASP_805
modified: axt754 10/18/2017 Filter Cost Centers Which are Active and polling status as 'P'
**********************************************************/
DECLARE
   CURSOR dep_bag_cur IS
      SELECT bt.cost_center_code cost_center_code,
             cc.cost_center_name cost_center_name,
             bt.dep_tkts_onhand_qty dep_tkts_onhand_qty,
             bt.last_vw_order_date last_vw_order_date,
             bt.last_maintenance_date last_maintenance_date
        FROM bank_dep_tick bt, cost_center cc
       WHERE bt.cost_center_code = cc.cost_center_code
         AND NVL(cc.OPEN_DATE,SYSDATE) <> '01-JAN-2099'
         AND cc.close_date IS NULL
         AND EXISTS (SELECT 1
                       FROM POLLING p
                      WHERE p.cost_center_code = bt.cost_center_code
                        AND p.polling_status_code = 'P'
                        AND p.expiration_date IS NULL)
       ORDER BY bt.cost_center_code;

   --variable declaration
   V_CLOB              CLOB;
   V_FINAL_CLOB        CLOB;

BEGIN

   --building the header
   V_FINAL_CLOB := 'Store No,'        ||
                   'Store Name,'       ||
                   'OnHand Quantity,' ||
                   'Last Order Date,'  ||
                   'Last Maintenance Date';

   FOR rec IN dep_bag_cur LOOP
      V_CLOB := '"' || rec.cost_center_code         || '",' ||
                '"' || rec.cost_center_name         || '",' ||
                '"' || rec.dep_tkts_onhand_qty      || '",' ||
                '"' || rec.last_vw_order_date       || '",' ||
                '"' || rec.last_maintenance_date    || '"';
      V_FINAL_CLOB := V_FINAL_CLOB || CHR(10) || V_CLOB;
   END LOOP;

   --sending mail for the category 'DEP_TICK_ONHAND_QTY_RPT'
   IF V_CLOB <> EMPTY_CLOB() THEN   
      MAIL_PKG.send_mail('DEP_TICK_ONHAND_QTY_RPT', NULL, NULL, V_FINAL_CLOB);
   END IF;

EXCEPTION
   WHEN OTHERS THEN
      Dbms_Output.put_line('DEP_TICK_ONHAND_QTY_RPT Failed  : ' || SQLCODE || ' ' || SUBSTR(SQLERRM,1,500));
      :exitcode := 2;
END ;
/