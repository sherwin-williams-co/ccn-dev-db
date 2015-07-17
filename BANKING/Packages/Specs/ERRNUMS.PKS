CREATE OR REPLACE PACKAGE errnums
/*********************************************************** 
This package will hold all error definitions for 
and system errors throughout the entire Banking application

THIS PACKAGE CONTAINS ERROR NUMBERS FROM -20000 ONWARDS

created : 03/10/2015 jxc517 CCN Project
revisions: 
************************************************************/
IS

/*********************************************************** 
The "accnt_nbr_not_avlbl_for_cc" passes a numerical error of -20000
This error will be used when account number if not found for cost center provided

created : 03/10/2015 jxc517 CCN Project
revisions: 
************************************************************/
en_accnt_nbr_not_avlbl_for_cc CONSTANT NUMBER := -20000;
exc_accnt_nbr_not_avlbl_for_cc EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_accnt_nbr_not_avlbl_for_cc , -20000);

/*********************************************************** 
The "en_cc_not_lead_ever" passes a numerical error of -20001
This error will be used when the Cost center entered in the 
Member Cost Center Maintenance screen is not a Lead 

created : 06/15/2015 sxh487 CCN Project
revisions: 
************************************************************/
en_cc_not_lead_ever CONSTANT NUMBER := -20001;
exc_cc_not_lead_ever EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_cc_not_lead_ever , -20001);

/*********************************************************** 
The "een_member_added_twice" passes a numerical error of -20002
This error will be used when the member Cost center and the lead cc combination entered in the 
Member Cost Center Maintenance screen is already present

created : 06/25/2015 nxk927 CCN Project
revisions: 
************************************************************/
en_member_added_twice CONSTANT NUMBER := -20002;
exc_member_added_twice EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_member_added_twice , -20002);

/*********************************************************** 
The "en_lead_assigned_as_mem" passes a numerical error of -20003
This error will be used when the member Cost center passed is 
present as a lead

created : 07/06/2015 nxk927 CCN Project
revisions: 
************************************************************/
en_lead_assigned_as_mem CONSTANT NUMBER := -20003;  
exc_lead_assigned_as_mem EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_lead_assigned_as_mem , -20003);

/*********************************************************** 
The "en_exp_eff_date_mismatch" passes a numerical error of -20004
This error will be used when the member Cost center passed is 
present as a lead

created : 07/07/2015 nxk927 CCN Project
revisions: 
************************************************************/
en_exp_eff_date_mismatch CONSTANT NUMBER := -20004;  
exc_exp_eff_date_mismatch EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_exp_eff_date_mismatch , -20004);

/*********************************************************** 
The "en_lead_exists_for_effctv_dt" passes a numerical error of -20005
This error will be used when the lead is effective for another bank
account number for the passed effective date

created : 07/09/2015 jxc517 CCN Project
revisions: 
************************************************************/
en_lead_exists_for_effctv_dt CONSTANT NUMBER := -20005;  
exc_lead_exists_for_effctv_dt EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_lead_exists_for_effctv_dt , -20005);

/*********************************************************** 
The "en_effective_date_null" passes a numerical error of -20006
This error will be used when the effective date is not passed

created : 07/09/2015 jxc517 CCN Project
revisions: 
************************************************************/
en_effective_date_null CONSTANT NUMBER := -20006;  
exc_effective_date_null EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_effective_date_null , -20006);

/*********************************************************** 
The "en_effctv_dt_lt_exprtn_dt" passes a numerical error of -20007
This error will be used when the expiration date is passed
that is less than effective date

created : 07/09/2015 jxc517 CCN Project
revisions: 
************************************************************/
en_effctv_dt_lt_exprtn_dt CONSTANT NUMBER := -20007;  
exc_effctv_dt_lt_exprtn_dt EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_effctv_dt_lt_exprtn_dt , -20007);

/*********************************************************** 
The "en_mbr_exists_for_effctv_dt" passes a numerical error of -20008
This error will be used when the member is effective for another lead
for the passed effective date

created : 07/09/2015 jxc517 CCN Project
revisions: 
************************************************************/
en_mbr_exists_for_effctv_dt CONSTANT NUMBER := -20008;  
exc_mbr_exists_for_effctv_dt EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_mbr_exists_for_effctv_dt , -20008);

/*********************************************************** 
The "en_lead_exprd_with_actv_mbr" passes a numerical error of -20009
This error will be used when a lead-bank accoun combination is expired
with atleast one member active under it

created : 07/14/2015 jxc517 CCN Project
revisions: 
************************************************************/
en_lead_exprd_with_actv_mbr CONSTANT NUMBER := -20009;  
exc_lead_exprd_with_actv_mbr EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_lead_exprd_with_actv_mbr , -20009);

/*********************************************************** 
The "en_effctv_dt_lt_current_dt" passes a numerical error of -20010
This error will be used when the expiration date is passed
that is less than current date

created : 07/14/2015 jxc517 CCN Project
revisions: 
************************************************************/
en_effctv_dt_lt_current_dt CONSTANT NUMBER := -20010;  
exc_effctv_dt_lt_current_dt EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_effctv_dt_lt_current_dt , -20010);

/*********************************************************** 
The "en_effctv_dt_lte_current_dt" passes a numerical error of -20011
This error will be used when the expiration date is passed
that is less than current date

created : 07/14/2015 jxc517 CCN Project
revisions: 
************************************************************/
en_effctv_dt_lte_current_dt CONSTANT NUMBER := -20011;  
exc_effctv_dt_lte_current_dt EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_effctv_dt_lte_current_dt , -20011);

/*********************************************************** 
The "en_bank_exists_for_effctv_dt" passes a numerical error of -20012
This error will be used when the bank account is effective for another lead
for the passed effective date

created : 07/09/2015 jxc517 CCN Project
revisions: 
************************************************************/
en_bank_exists_for_effctv_dt CONSTANT NUMBER := -20012;  
exc_bank_exists_for_effctv_dt EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_bank_exists_for_effctv_dt , -20012);


END errnums;

