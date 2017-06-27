/*****************************************************************
  This script will generate the excel report for Deposit Bags.
  Which describes Store #, OnHand Quantity and Last Order Date and
  send email to the SMIS group

  This excel should generate after DPST_BAGS_UPDT_BTCH daily batch job,
  and DPST_BAGS_UPDT_BTCH job scheduled daily at 7 AM,
  hence This script will execute daily at 8 AM.

created : sxp130 06/22/2017 ASP_805
modified:
**********************************************************/
DECLARE
   CURSOR dep_bag_cur IS
      SELECT cost_center_code,
             depbag_onhand_qty,
             depbag_last_order_date
        FROM bank_dep_bag_tick
       ORDER BY cost_center_code;

   --variable declaration
   V_CLOB              CLOB;
   V_FINAL_CLOB        CLOB;

BEGIN

   --building the header
   V_FINAL_CLOB := 'Store No,'        ||
                   'OnHand Quantity,' ||
                   'Last Order Date'  ;

   FOR rec IN dep_bag_cur LOOP
      V_CLOB := '"' || rec.cost_center_code         || '",' ||
                '"' || rec.depbag_onhand_qty        || '",' ||
                '"' || rec.depbag_last_order_date   || '"';
      V_FINAL_CLOB := V_FINAL_CLOB || CHR(10) || V_CLOB;
   END LOOP;

   --sending mail for the category 'DEP_BAG_TICK_ONHAND_QTY_RPT'
   IF V_CLOB <> EMPTY_CLOB() THEN
      MAIL_PKG.send_mail('DEP_BAG_TICK_ONHAND_QTY_RPT', NULL, NULL, V_FINAL_CLOB);
   END IF;

EXCEPTION
   WHEN OTHERS THEN
      Dbms_Output.put_line('DEP_BAG_TICK_ONHAND_QTY_RPT Failed  : ' || SQLCODE || ' ' || SUBSTR(SQLERRM,1,500));
      :exitcode := 2;
END ;
/