CREATE OR REPLACE PACKAGE ERRNUMS
AS
/*********************************************************** 
This package will hold all error definitions for 
and system errors throughout the entire Banking application

THIS PACKAGE CONTAINS ERROR NUMBERS FROM -20000 ONWARDS

Created : 03/10/2015 jxc517 CCN Project
Changed :
************************************************************/
/*********************************************************** 
The "accnt_nbr_not_avlbl_for_cc" passes a numerical error of -20000
This error will be used when account number is not found for cost center provided

Created : 03/10/2015 jxc517 CCN Project
Changed : 
************************************************************/
en_accnt_nbr_not_avlbl_for_cc CONSTANT NUMBER := -20000;
exc_accnt_nbr_not_avlbl_for_cc EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_accnt_nbr_not_avlbl_for_cc , -20000);

/*********************************************************** 
The "cc_not_lead_ever" passes a numerical error of -20001
This error will be used when the Cost center entered is never a lead 

Created : 06/15/2015 jxc517 CCN Project
Changed :
************************************************************/
en_cc_not_lead_ever CONSTANT NUMBER := -20001;
exc_cc_not_lead_ever EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_cc_not_lead_ever , -20001);

/*********************************************************** 
The "member_added_twice" passes a numerical error of -20002
This error will be used when the member and lead store combination entered is already present

Created : 06/25/2015 jxc517 CCN Project
Changed :
************************************************************/
en_member_added_twice CONSTANT NUMBER := -20002;
exc_member_added_twice EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_member_added_twice , -20002);

/*********************************************************** 
The "lead_assigned_as_mem" passes a numerical error of -20003
This error will be used when the member store passed is already a lead store

Created : 07/06/2015 jxc517 CCN Project
Changed :
************************************************************/
en_lead_assigned_as_mem CONSTANT NUMBER := -20003;  
exc_lead_assigned_as_mem EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_lead_assigned_as_mem , -20003);

/*********************************************************** 
The "lead_exists_for_effctv_dt" passes a numerical error of -20004
This error will be used when the lead is effective for another bank
account number for the passed effective date

Created : 07/09/2015 jxc517 CCN Project
Changed :
************************************************************/
en_lead_exists_for_effctv_dt CONSTANT NUMBER := -20004;  
exc_lead_exists_for_effctv_dt EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_lead_exists_for_effctv_dt , -20004);

/*********************************************************** 
The "effective_date_null" passes a numerical error of -20005
This error will be used when the effective date is not passed

Created : 07/09/2015 jxc517 CCN Project
Changed :
************************************************************/
en_effective_date_null CONSTANT NUMBER := -20005;  
exc_effective_date_null EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_effective_date_null , -20005);

/*********************************************************** 
The "exprtn_lt_effctv_dt_dt" passes a numerical error of -20006
This error will be used when the expiration date is passed
that is less than effective date

Created : 07/09/2015 jxc517 CCN Project
Changed :
************************************************************/
en_exprtn_lt_effctv_dt_dt CONSTANT NUMBER := -20006;  
exc_exprtn_lt_effctv_dt_dt EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_exprtn_lt_effctv_dt_dt , -20006);

/*********************************************************** 
The "mbr_exists_for_effctv_dt" passes a numerical error of -20007
This error will be used when the member is effective for another lead
for the passed effective date

Created : 07/09/2015 jxc517 CCN Project
Changed :
************************************************************/
en_mbr_exists_for_effctv_dt CONSTANT NUMBER := -20007;  
exc_mbr_exists_for_effctv_dt EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_mbr_exists_for_effctv_dt , -20007);

/*********************************************************** 
The "lead_exprd_with_actv_mbr" passes a numerical error of -20008
This error will be used when a lead-bank account combination is expired
with atleast one member active under it

Created : 07/14/2015 jxc517 CCN Project
Changed :
************************************************************/
en_lead_exprd_with_actv_mbr CONSTANT NUMBER := -20008;  
exc_lead_exprd_with_actv_mbr EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_lead_exprd_with_actv_mbr , -20008);

/*********************************************************** 
The "effctv_dt_lt_current_dt" passes a numerical error of -20009
This error will be used when the expiration date is passed
that is less than current date

Created : 07/14/2015 jxc517 CCN Project
Changed :
************************************************************/
en_effctv_dt_lt_current_dt CONSTANT NUMBER := -20009;  
exc_effctv_dt_lt_current_dt EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_effctv_dt_lt_current_dt , -20009);

/*********************************************************** 
The "effctv_dt_lte_current_dt" passes a numerical error of -20010
This error will be used when the expiration date is passed
that is less than or equal to current date

Created : 07/14/2015 jxc517 CCN Project
Changed :
************************************************************/
en_effctv_dt_lte_current_dt CONSTANT NUMBER := -20010;  
exc_effctv_dt_lte_current_dt EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_effctv_dt_lte_current_dt , -20010);

/*********************************************************** 
The "bank_exists_for_effctv_dt" passes a numerical error of -20011
This error will be used when the bank account is effective for another lead
for the passed effective date

Created : 07/09/2015 nxk927 CCN Project
Changed :
************************************************************/
en_bank_exists_for_effctv_dt CONSTANT NUMBER := -20011;  
exc_bank_exists_for_effctv_dt EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_bank_exists_for_effctv_dt , -20011);

/*********************************************************** 
The "parent_child_dates_err" passes a numerical error of -20012
This error will be used child dates falls outside parents dates

Created : 07/17/2015 jxc517 CCN Project
Changed :
************************************************************/
en_parent_child_dates_err CONSTANT NUMBER := -20012;  
exc_parent_child_dates_err EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_parent_child_dates_err , -20012);

/*********************************************************** 
The "bnk_accnt_expr_wt_actv_chld" passes a numerical error of -20013
This error will be used when a bank account is expired
with atleast one MICR format or Lead active under it

Created : 07/22/2015 jxc517 CCN Project
Changed :
************************************************************/
en_bnk_accnt_expr_wt_actv_chld CONSTANT NUMBER := -20013;  
exc_bnk_accn_expr_wt_actv_chld EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_bnk_accn_expr_wt_actv_chld , -20013);

END ERRNUMS;

