create or replace PACKAGE BANKING_REPORTING_PKG AS
/**********************************************************
	This Package is intended to run the Banking Reports.

created : 07/25/2019 jxc517 CCN Project....CCNBN-12
changed :
**********************************************************/

PROCEDURE GENERATE_DEP_TICK_BAG_DLY_RPRTS;
/**********************************************************
	This Procedure will create an Excel file containing the
  Banking Reports for Bags and Tickets (mentioned below)
  and email that Excel file.

created : 07/25/2019 jxc517 CCN Project....CCNBN-12
          1. Cost centers which are active but not having deposit ticket details
          2. Cost centers which are active but not having deposit bag details
          3. Deposit Bag OnHand Qty File generation
          4. Deposit Ticket OnHand Qty File generation
          5. Deposit Tickets Ordered Report
          6. Deposit Tickets Error Report
          7. Deposit Bags Error Report
          8. Deposit Bags Ordered Report

changed :
**********************************************************/

END BANKING_REPORTING_PKG;