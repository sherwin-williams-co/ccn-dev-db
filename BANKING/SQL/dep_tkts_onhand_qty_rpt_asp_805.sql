/*****************************************************************
  This script will generate the excel report for Deposit Tickets.
  Which describes Store #, OnHand Quantity and Last Order Date and
  send email to the SMIS group

  This excel should generate after DPST_TCKTS_UPDT_BTCH daily batch job,
  and DPST_TCKTS_UPDT_BTCH job scheduled daily at 7 AM,
  hence This script will execute daily at 8 AM.

created : sxp130 06/22/2017
modified:
**********************************************************/
DECLARE
   CURSOR dep_bag_cur IS
      SELECT cost_center_code,
             dep_tkts_onhand_qty,
             last_vw_order_date
        FROM bank_dep_tick
       WHERE business_rules_pkg.is_placing_dpt_tkt_bag_ord_ok(cost_center_code) = UPPER('Y')
       ORDER BY cost_center_code;

   --variable declaration
   V_CLOB              CLOB;
   V_CLOB_FOR_EMAIL    CLOB;

BEGIN

   --building the header
   V_CLOB_FOR_EMAIL := 'Store No,'        ||
                       'OnHand Quantity,' ||
                       'Last Order Date'  ;

   FOR rec IN dep_bag_cur LOOP
      V_CLOB := '"' || rec.cost_center_code         || '",' ||
                '"' || rec.dep_tkts_onhand_qty      || '",' ||
                '"' || rec.last_vw_order_date       || '"';

      IF V_CLOB <> EMPTY_CLOB() THEN
         IF V_CLOB_FOR_EMAIL <> EMPTY_CLOB() THEN
            --Appending the header
            V_CLOB_FOR_EMAIL := V_CLOB_FOR_EMAIL || CHR(10) || V_CLOB;
         ELSE
            V_CLOB_FOR_EMAIL := V_CLOB;
         END IF;
      END IF;
   END LOOP;

   --sending mail for the category 'DEP_TICK_ONHAND_QTY_RPT'
   IF V_CLOB_FOR_EMAIL <> EMPTY_CLOB() THEN
      MAIL_PKG.send_mail('DEP_TICK_ONHAND_QTY_RPT', NULL, NULL, V_CLOB_FOR_EMAIL);
   END IF;

EXCEPTION
   WHEN OTHERS THEN
      Dbms_Output.put_line('DEP_TICK_ONHAND_QTY_RPT Failed  : ' || SQLCODE || ' ' || SUBSTR(SQLERRM,1,500));
      :exitcode := 2;
END ;
/