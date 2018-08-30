--creating rls_run_cycle accounts for rls_cycle 0 rerun
--sxh487 08/30/2018

DELETE FROM CUST_DEP_REDEMPTION_DETAILS WHERE customer_account_number IN
(select acctnbr from PNP.pre_go_live_headers where rls_run_cycle =0);

DELETE FROM CUST_DEP_CREDIT_DETAILS WHERE customer_account_number IN
(select acctnbr from PNP.pre_go_live_headers where rls_run_cycle =0);

DELETE FROM CUSTOMER_DEPOSIT_DETAILS WHERE customer_account_number IN
(select acctnbr from PNP.pre_go_live_headers where rls_run_cycle =0);

DELETE FROM CUSTOMER_DEPOSIT_HEADER WHERE customer_account_number IN
(select acctnbr from PNP.pre_go_live_headers where rls_run_cycle =0);

COMMIT;