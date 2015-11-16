CREATE OR REPLACE PACKAGE ERRNUMS
AS
/*********************************************************** 
This package will hold all error definitions for 
and system errors throughout the entire Banking application

THIS PACKAGE CONTAINS ERROR NUMBERS FROM -20000 ONWARDS

Created : 03/10/2015 jxc517 CCN Project....
Changed :
************************************************************/

/*********************************************************** 
The "cc_not_lead_ever" passes a numerical error of -20000
This error will be used when the Cost center entered is never a lead 

Created : 06/15/2015 jxc517 CCN Project....
Changed :
************************************************************/
en_cc_not_lead_ever CONSTANT NUMBER := -20000;
exc_cc_not_lead_ever EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_cc_not_lead_ever , -20000);

/*********************************************************** 
The "member_added_twice" passes a numerical error of -20001
This error will be used when the member and lead store combination entered is already present

Created : 06/25/2015 jxc517 CCN Project....
Changed :
************************************************************/
en_member_added_twice CONSTANT NUMBER := -20001;
exc_member_added_twice EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_member_added_twice , -20001);

/*********************************************************** 
The "lead_assigned_as_mem" passes a numerical error of -20002
This error will be used when the member store passed is already a lead store

Created : 07/06/2015 jxc517 CCN Project....
Changed :
************************************************************/
en_lead_assigned_as_mem CONSTANT NUMBER := -20002;  
exc_lead_assigned_as_mem EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_lead_assigned_as_mem , -20002);

/*********************************************************** 
The "lead_exists_for_effctv_dt" passes a numerical error of -20003
This error will be used when the lead is effective for another bank
account number for the passed effective date

Created : 07/09/2015 jxc517 CCN Project....
Changed :
************************************************************/
en_lead_exists_for_effctv_dt CONSTANT NUMBER := -20003;  
exc_lead_exists_for_effctv_dt EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_lead_exists_for_effctv_dt , -20003);

/*********************************************************** 
The "effective_date_null" passes a numerical error of -20004
This error will be used when the effective date is not passed

Created : 07/09/2015 jxc517 CCN Project....
Changed :
************************************************************/
en_effective_date_null CONSTANT NUMBER := -20004;  
exc_effective_date_null EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_effective_date_null , -20004);

/*********************************************************** 
The "exprtn_lt_effctv_dt_dt" passes a numerical error of -20005
This error will be used when the expiration date is passed
that is less than effective date

Created : 07/09/2015 jxc517 CCN Project....
Changed :
************************************************************/
en_exprtn_lt_effctv_dt_dt CONSTANT NUMBER := -20005;  
exc_exprtn_lt_effctv_dt_dt EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_exprtn_lt_effctv_dt_dt , -20005);

/*********************************************************** 
The "mbr_exists_for_effctv_dt" passes a numerical error of -20006
This error will be used when the member is effective for another lead
for the passed effective date

Created : 07/09/2015 jxc517 CCN Project....
Changed :
************************************************************/
en_mbr_exists_for_effctv_dt CONSTANT NUMBER := -20006;  
exc_mbr_exists_for_effctv_dt EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_mbr_exists_for_effctv_dt , -20006);

/*********************************************************** 
The "lead_exprd_with_actv_chlds" passes a numerical error of -20007
This error will be used when a lead-bank account combination is expired
with atleast one member active under it

Created : 07/14/2015 jxc517 CCN Project....
Changed :
************************************************************/
en_lead_exprd_with_actv_chlds CONSTANT NUMBER := -20007;  
exc_lead_exprd_with_actv_chlds EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_lead_exprd_with_actv_chlds , -20007);

/*********************************************************** 
The "effctv_dt_lt_current_dt" passes a numerical error of -20008
This error will be used when the expiration date is passed
that is less than current date

Created : 07/14/2015 jxc517 CCN Project....
Changed :
************************************************************/
en_effctv_dt_lt_current_dt CONSTANT NUMBER := -20008;  
exc_effctv_dt_lt_current_dt EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_effctv_dt_lt_current_dt , -20008);

/*********************************************************** 
The "effctv_dt_lte_current_dt" passes a numerical error of -20009
This error will be used when the expiration date is passed
that is less than or equal to current date

Created : 07/14/2015 jxc517 CCN Project....
Changed :
************************************************************/
en_effctv_dt_lte_current_dt CONSTANT NUMBER := -20009;  
exc_effctv_dt_lte_current_dt EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_effctv_dt_lte_current_dt , -20009);

/*********************************************************** 
The "parent_child_dates_err" passes a numerical error of -20011
This error will be used child dates falls outside parents dates

Created : 07/17/2015 jxc517 CCN Project....
Changed :
************************************************************/
en_parent_child_dates_err CONSTANT NUMBER := -20011;  
exc_parent_child_dates_err EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_parent_child_dates_err , -20011);

/*********************************************************** 
The "bnk_accnt_expr_wt_actv_chld" passes a numerical error of -20012
This error will be used when a bank account is expired
with atleast one MICR format or Lead active under it

Created : 07/22/2015 jxc517 CCN Project....
Changed :
************************************************************/
en_bnk_accnt_expr_wt_actv_chld CONSTANT NUMBER := -20012;  
exc_bnk_accn_expr_wt_actv_chld EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_bnk_accn_expr_wt_actv_chld , -20012);

/*********************************************************** 
The "str_exprd_trnsfr_err" passes a numerical error of -20013
This error will be used when transfer fails due to expired store

Created : 07/28/2015 jxc517 CCN Project....
Changed :
************************************************************/
en_str_exprd_trnsfr_err CONSTANT NUMBER := -20013;
exc_str_exprd_trnsfr_err EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_str_exprd_trnsfr_err , -20013);

/*********************************************************** 
The "bnk_accnt_ftr_effctv_err" passes a numerical error of -20014
This error will be used when bank account effective date is
  less than or equal to previous records effective date

Created : 07/28/2015 jxc517 CCN Project....
Changed :
************************************************************/
en_bnk_accnt_ftr_effctv_err CONSTANT NUMBER := -20014;
exc_bnk_accnt_ftr_effctv_err EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_bnk_accnt_ftr_effctv_err , -20014);

/*********************************************************** 
The "from_to_leads_are_same_err" passes a numerical error of -20015
This error will be used when from and to leads are same in concentration
window

Created : 07/29/2015 jxc517 CCN Project....
Changed :
************************************************************/
en_from_to_leads_are_same_err CONSTANT NUMBER := -20015;
exc_from_to_leads_are_same_err EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_from_to_leads_are_same_err , -20015);

/*********************************************************** 
The "micr_added_twice" passes a numerical error of -20016
This error will be used when the MICR and Account Number combination entered is already present

Created : 08/17/2015 jxc517 CCN Project....
Changed :
************************************************************/
en_micr_added_twice CONSTANT NUMBER := -20016;
exc_micr_added_twice EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_micr_added_twice , -20016);

/*********************************************************** 
The "micr_exprd_with_actv_dptks" passes a numerical error of -20017
This error will be used when a MICR-bank account combination is expired
with atleast one deposit ticket active under it

Created : 08/18/2015 jxc517 CCN Project....
Changed :
************************************************************/
en_micr_exprd_with_actv_dptks CONSTANT NUMBER := -20017;
exc_micr_exprd_with_actv_dptks EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_micr_exprd_with_actv_dptks , -20017);

/*********************************************************** 
The "lead_indpdt_with_actv_mbr" passes a numerical error of -20010
This error will be used when a lead is made independent with active members

Created : 08/21/2015 jxc517 CCN Project....
Changed :
************************************************************/
en_lead_indpdt_with_actv_mbr CONSTANT NUMBER := -20010;
exc_lead_indpdt_with_actv_mbr EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_lead_indpdt_with_actv_mbr , -20010);

/*********************************************************** 
The "micr_format_conversion" passes a numerical error of -20019
This error will be used when format selected is not supported for actual values

Created : 08/21/2015 jxc517 CCN Project....
Changed :
************************************************************/
en_micr_format_conversion CONSTANT NUMBER := -20018;
exc_micr_format_conversion EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_micr_format_conversion , -20018);

/*********************************************************** 
The "mbr_exprd_with_actv_dptks" passes a numerical error of -20019
This error will be used when a member is expired with atleast 
one deposit ticket active under it

Created : 08/18/2015 jxc517 CCN Project....
Changed :
************************************************************/
en_mbr_exprd_with_actv_dptks CONSTANT NUMBER := -20019;
exc_mbr_exprd_with_actv_dptks EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_mbr_exprd_with_actv_dptks , -20019);

/*********************************************************** 
The "accnt_nbr_not_avlbl_for_cc" passes a numerical error of -20020
This error will be used when there is no bank account number found for the
store entered

Created : 08/18/2015 jxc517 CCN Project....
Changed :
************************************************************/
en_accnt_nbr_not_avlbl_for_cc CONSTANT NUMBER := -20020;
exc_accnt_nbr_not_avlbl_for_cc EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_accnt_nbr_not_avlbl_for_cc , -20020);

/*********************************************************** 
The "to_lead_not_provided_err" passes a numerical error of -20022
This error will be used when user tries to transfer members without specifying
the new "To" lead

Created : 09/09/2015 jxc517 CCN Project....
Changed :
************************************************************/
en_to_lead_not_provided_err CONSTANT NUMBER := -20022;
exc_to_lead_not_provided_err EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_to_lead_not_provided_err , -20022);

/*********************************************************** 
The "to_member_not_selected_err" passes a numerical error of -20023
This error will be used when user tries to transfer members without selecting
any member

Created : 09/09/2015 jxc517 CCN Project....
Changed :
************************************************************/
en_member_not_selected_err CONSTANT NUMBER := -20023;
exc_member_not_selected_err EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_member_not_selected_err , -20023);

/*********************************************************** 
The "to_effective_date" passes a numerical error of -20024
This error will be used when user tries to transfer members without selecting
any effective date

Created : 09/14/2015 axk326 CCN Project....
Changed :
************************************************************/
en_to_effect_date_err CONSTANT NUMBER := -20024;
exc_to_effect_date_err EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_to_effect_date_err , -20024);

/*********************************************************** 
The "childs_effctv_before_parent" passes a numerical error of -20025
This error will be used when childs are effective before parents

Created : 09/15/2015 axk326 CCN Project....
Changed :
************************************************************/
en_childs_effctv_before_parent CONSTANT NUMBER := -20025;
exc_childs_effctv_bfr_parent EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_childs_effctv_bfr_parent , -20025);

/*********************************************************** 
The "future_del_wrn" passes a numerical error of -20026
This warning will be used if an expired member with future 
is transferred again. 
Created : 09/30/2015 sxh487 CCN Project....
Changed :
************************************************************/
en_future_del_wrn CONSTANT NUMBER := -20026;
exc_future_del_wrn EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_future_del_wrn , -20026);

/*********************************************************** 
The "lead_bank_type_not_chg" passes a numerical error of -20027
This error will be thrown if there is a change to Bank type and 
effective date correspondingly
Created : 10/06/2015 axk326 CCN Project....
Changed :
************************************************************/
en_lead_bnk_typ_not_chg_err CONSTANT NUMBER := -20027;
exc_lead_bnk_typ_not_chg_err EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_lead_bnk_typ_not_chg_err , -20027);

/*********************************************************** 
The "book_keeper_null_err" passes a numerical error of -20028
This error will be thrown if the bank account book keeper number
is not provided

Created : 10/14/2015 jxc517 CCN Project....
Changed :
************************************************************/
en_book_keeper_null_err CONSTANT NUMBER := -20028;
exc_book_keeper_null_err EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_book_keeper_null_err , -20028);

/*********************************************************** 
The "bnk_dep_bag_tckord_seq_err" passes a numerical error of -20029
This error will be used when current order is placed with a future order 
already in place

Created : 10/20/2015 jxc517 CCN Project....
Changed :
************************************************************/
en_bnk_dep_bag_tckord_seq_err CONSTANT NUMBER := -20029;
exc_bnk_dep_bag_tckord_seq_err EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_bnk_dep_bag_tckord_seq_err , -20029);

/*********************************************************** 
The "trnsfr_with_multiple_dts" passes a numerical error of -20030
This error will be used when a transfer is performed selecting multiple dates
for members selected

Created : 11/10/2015 jxc517 CCN Project....
Changed :
************************************************************/
en_trnsfr_with_multiple_dts CONSTANT NUMBER := -20030;
exc_trnsfr_with_multiple_dts EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_trnsfr_with_multiple_dts , -20030);

/*********************************************************** 
The "mem_to_ld_effect_dt_err" passes a numerical error of -20031
This error will be used when user tries to enter the date for the member transfer where 
the TO_COST_CENTER is not lead in the date passed  

Created : 10/11/2015 nxk927 CCN Project....
Changed :
************************************************************/
en_mem_to_ld_effect_dt_err CONSTANT NUMBER := -20031;
exc_mem_to_ld_effect_dt_err EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_mem_to_ld_effect_dt_err , -20031);

/*********************************************************** 
The "lead_ever_mbr_frm_efctv_dt" passes a numerical error of -20032
This error will be used when user tries to add a lead who is already a member 

Created : 10/12/2015 jxc517 CCN Project....
Changed :
************************************************************/
en_lead_ever_mbr_frm_efctv_dt CONSTANT NUMBER := -20032;
exc_lead_ever_mbr_frm_efctv_dt EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_lead_ever_mbr_frm_efctv_dt , -20032);

/*********************************************************** 
The "str_micr_dtls_not_avail" passes a numerical error of -20033
This error will be used when there is no store micr format details attached
to the passed cost_center_code

Created : 11/12/2015 axk326 CCN Project....
Changed :
************************************************************/
en_str_micr_dtls_not_avail CONSTANT NUMBER := -20033;
exc_str_micr_dtls_not_avail EXCEPTION;
PRAGMA EXCEPTION_INIT(exc_str_micr_dtls_not_avail , -20033);

END ERRNUMS;

