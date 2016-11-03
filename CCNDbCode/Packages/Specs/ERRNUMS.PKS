create or replace PACKAGE          errnums
/*********************************************************** 
This package will hold all error definitions for 
and system errors throughout the entire CCN applications

THIS PACKAGE CONTAINS ERROR NUMBERS FROM
                   -20000 TILL -20500 FOR COSTCNTR
                   -20500 ONWARDS FOR HIERARCHY

created : 12/02/2011 blr CCN Project
revisions:

************************************************************/

/*********************************************************** 
The "en_general_error" passes a numerical error of -20000.
If an error occurs outside the scope of -20000 thru -20999
defined errors ; a generic error message is displayed

created : 12/08/2011 blr CCN Project
revisions: 

************************************************************/
IS
en_general_error CONSTANT NUMBER := -20000;
exc_general_error EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_general_error, -20000);

/*********************************************************** 
The "invalid_cost_center_err" passes a numerical error of -20001.
An error occurs when Cost Center cannot be found.

created : 06/07/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_cost_center_err CONSTANT NUMBER := -20001;
exc_invalid_cost_center_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_cost_center_err , -20001);

/*********************************************************** 
The "inactive_cost_center_err" passes a numerical error of -20002.
An error occurs when Cost_Center effective date >
current date & expiration date not null.

created : 06/07/2012 cbd CCN Project
revisions: 

************************************************************/
en_inactive_cost_center_err CONSTANT NUMBER := -20002;
exc_inactive_cost_center_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_inactive_cost_center_err , -20002);

/*********************************************************** 
The "xmlcomp_err" passes a numerical error of -20003.
This error is raised when there is an error in the XML comparison
procedure for the audit_log table

created : 05/09/2012 kdp CCN Project
revisions: 

************************************************************/
en_xmlcomp_err CONSTANT NUMBER := -20003;
exc_xmlcomp_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_xmlcomp_err , -20003);

/*********************************************************** 
The "hierarchy_err" passes a numerical error of -20004.
This error is raised when there is an error in the hierarchy 
package

created : 05/09/2012 kdp CCN Project
revisions: 

************************************************************/
en_hierarchy_err CONSTANT NUMBER := -20004;
exc_hierarchy_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_hierarchy_err , -20004);

/*********************************************************** 
The "non_numeric_err" passes a numerical error of -20005.
The non numeric error is generataed by our Business Rules process
if the merchant ID has a non numeric value

created : 05/09/2012 kdp CCN Project
revisions: 

************************************************************/
en_non_numeric_err CONSTANT NUMBER := -20005;
exc_non_numeric_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_non_numeric_err , -20005);                           
                             
/*********************************************************** 
The "invalid_merchid_err" passes a numerical error of -20006.
The invalid merchant ID is generataed by our Business Rules process
if the merchant ID has a is set to a default value of 9999999999

created : 05/09/2012 kdp CCN Project
revisions: 

************************************************************/
en_invalid_merchid_err CONSTANT NUMBER := -20006;
exc_invalid_merchid_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_merchid_err , -20006);  

/*********************************************************** 
The "cost_center_err" passes a numerical error of -20007.
The cost center execption is generataed by our Business Rules process
if the merchant ID has the wrong cost center enbedded in the ID.

created : 05/09/2012 kdp CCN Project
revisions: 

************************************************************/
en_cost_center_err CONSTANT NUMBER := -20007;
exc_cost_center_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_cost_center_err , -20007);

/*********************************************************** 
The "check_digit_err" passes a numerical error of -20008.
The cost center execption is generataed by our Business Rules process
if the merchant ID has the wrong cost center enbedded in the ID.

created : 05/09/2012 kdp CCN Project
revisions: 

************************************************************/
en_check_digit_err CONSTANT NUMBER := -20008;
exc_check_digit_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_check_digit_err , -20008);

/*********************************************************** 
The "ccntr_close_err" passes a numerical error of -20009.
This error will check to make sure that the user is actually
trying to close a cost center ('X' or '5') and that there
is a Close Date present.

created : 05/25/2012 cbd CCN Project
revisions: 

************************************************************/
en_ccntr_close_err CONSTANT NUMBER := -20009;
exc_ccntr_close_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_ccntr_close_err , -20009);

/*********************************************************** 
The "invalid_close_date_err" passes a numerical error of -20010.
This error tells us that the status is "X" or "5" and the
close date has been entered, but it does not match the
effective_date of STATUS table. In the future, we will
automatically set the close date to this value.

created : 05/25/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_close_date_err CONSTANT NUMBER := -20010;
exc_invalid_close_date_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_close_date_err , -20010);

/*********************************************************** 
The "no_act_status_rec_err" passes a numerical error of -20011.
This error states that we are trying to get the active
STATUS Table Row of the Cost Center and there is not
active Status for this cost center.

created : 05/25/2012 cbd CCN Project
revisions: 

************************************************************/
en_no_act_status_rec_err CONSTANT NUMBER := -20011;
exc_no_act_status_rec_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_no_act_status_rec_err , -20011);

/*********************************************************** 
The "close_store_asgn_terr_err" passes a numerical error of -20012.
This error states that there this "STORE" cost center is
a home store for a territory on the TERRITORY table.

created : 05/25/2012 cbd CCN Project
revisions: 

************************************************************/
en_close_store_asgn_terr_err CONSTANT NUMBER := -20012;
exc_close_store_asgn_terr_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_close_store_asgn_terr_err , -20012);

/*********************************************************** 
The "close_terr_asgn_store_err" passes a numerical error of -20013.
This error states that there this "TERRITORY" cost center
is still assigned to a a home store. 

created : 05/25/2012 cbd CCN Project
revisions: 

************************************************************/
en_close_terr_asgn_store_err CONSTANT NUMBER := -20013;
exc_close_terr_asgn_store_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_close_terr_asgn_store_err , -20013);

/*********************************************************** 
The "no_territory_err" passes a numerical error of -20014.
This error states that there is no  "TERRITORY" table entry
for the requested territory cost center. 

created : 05/25/2012 cbd CCN Project
revisions: 

************************************************************/
en_no_territory_err CONSTANT NUMBER := -20014;
exc_no_territory_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_no_territory_err , -20014);

/*********************************************************** 
The "invalid_close_status_err" passes a numerical error of -20015.
This error states that a Close_date has been entered
but the Status_Code has not been updated to an "X" or "5".
In the future, this will be automatically done. 

created : 05/25/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_close_status_err CONSTANT NUMBER := -20015;
exc_invalid_close_status_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_close_status_err , -20015);

/*********************************************************** 
The "no_cost_center_err" passes a numerical error of -20016.
This error will check to make sure that the cost center is in
the COST_CENTER Table.

created : 06/05/2012 cbd CCN Project
revisions: 

************************************************************/
en_no_cost_center_err CONSTANT NUMBER := -20016;
exc_no_cost_center_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_no_cost_center_err , -20016);

/*********************************************************** 
The "invalid_reopen_ccntr_err" passes a numerical error of -20017.
This error tells us that the CLOSE_DATE is Populated
(Not ZERO as it should be for a re-open status) or that the
CLOSE_DATE is zeros but it matchs the CLOSE_Date on the
COST_CENTER table.
This denotes that the Cost Center has already been re-opened. 

created : 06/05/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_reopen_ccntr_err CONSTANT NUMBER := -20017;
exc_invalid_reopen_ccntr_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_reopen_ccntr_err , -20017);

/*********************************************************** 
The "invalid_act_stat_code_err" passes a numerical error of -20018.
This states that the user is re-opening the Cost Center but the
STATUS_Code sent denotes a closed Cost Center ("X", "5", or "9"). 

created : 06/05/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_act_stat_code_err CONSTANT NUMBER := -20018;
exc_invalid_act_stat_code_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_act_stat_code_err , -20018);

/*********************************************************** 
The "terr_home_store_err" passes a numerical error of -20019.
This error states that a Territory Cost Center is being re-opened
and does not have the HOME_STORE column populated. 

created : 06/05/2012 cbd CCN Project
revisions: 

************************************************************/
en_terr_home_store_err CONSTANT NUMBER := -20019;
exc_terr_home_store_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_terr_home_store_err , -20019);

/*********************************************************** 
The "territory_category_err" passes a numerical error of -20020.
This error will be used if the Territory Category specified is not "T".

created : 06/05/2012 cbd CCN Project
revisions: 

************************************************************/
en_territory_category_err CONSTANT NUMBER := -20020;
exc_territory_category_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_territory_category_err , -20020);

/*********************************************************** 
The "no_home_store_spec_err" passes a numerical error of -20021.
This error will be used when no Home Store is specified for the Territory.

created : 06/05/2012 cbd CCN Project
revisions: 

************************************************************/
en_no_home_store_spec_err CONSTANT NUMBER := -20021;
exc_no_home_store_spec_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_no_home_store_spec_err , -20021);

/*********************************************************** 
The "no_home_store_cctr_err" passes a numerical error of -20022.
This error is used when no Cost Center is found for the Home Store specified.

created : 06/05/2012 cbd CCN Project
revisions: 

************************************************************/
en_no_home_store_cctr_err CONSTANT NUMBER := -20022;
exc_no_home_store_cctr_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_no_home_store_cctr_err , -20022);

/*********************************************************** 
The "home_store_cctr_cat_err" passes a numerical error of -20023.
This error will be used when the Cost Center Category for the
Home Store is not "S".

created : 06/05/2012 cbd CCN Project
revisions: 

************************************************************/
en_home_store_cctr_cat_err CONSTANT NUMBER := -20023;
exc_home_store_cctr_cat_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_home_store_cctr_cat_err , -20023);

/*********************************************************** 
The "home_store_cctr_closed_err" passes a numerical error of -20024.
This error is used when the Cost Center for the Home Store is closed.

created : 06/05/2012 cbd CCN Project
revisions: 

************************************************************/
en_home_store_cctr_closed_err CONSTANT NUMBER := -20024;
exc_home_store_cctr_closed_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_home_store_cctr_closed_err , -20024);

/*********************************************************** 
The "terr_store_stmnt_type_err" passes a numerical error of -20025.
This error is used when there is a Territory and
Home Store Statement Type mismatch.

created : 06/05/2012 cbd CCN Project
revisions: 

************************************************************/
en_terr_store_stmnt_type_err CONSTANT NUMBER := -20025;
exc_terr_store_stmnt_type_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_terr_store_stmnt_type_err , -20025);

/*********************************************************** 
The "no_territory_cctr_err" passes a numerical error of -20026.
This error is used when the Cost Center is not found for Territory.

created : 06/05/2012 cbd CCN Project
revisions: 

************************************************************/
en_no_territory_cctr_err CONSTANT NUMBER := -20026;
exc_no_territory_cctr_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_no_territory_cctr_err , -20026);

/*********************************************************** 
The "terr_store_entity_type_err" passes a numerical error of -20027.
This error is used when there is a Territory and
Home Store Entity Type mismatch.

created : 06/05/2012 cbd CCN Project
revisions: 

************************************************************/
en_terr_store_entity_type_err CONSTANT NUMBER := -20027;
exc_terr_store_entity_type_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_terr_store_entity_type_err , -20027);

/*********************************************************** 
The "no_act_type_rec_err" passes a numerical error of -20028.
This error will check to make sure that an active TYPE Table Row
is active for the cost center being re-opened. 

created : 06/06/2012 cbd CCN Project
revisions: 

************************************************************/
en_no_act_type_rec_err CONSTANT NUMBER := -20028;
exc_no_act_type_rec_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_no_act_type_rec_err , -20028);

/*********************************************************** 
The "no_home_store_err" passes a numerical error of -20029.
This error is used when no Store is found for the Home Store specified.

created : 06/07/2012 cbd CCN Project
revisions: 

************************************************************/
en_no_home_store_err CONSTANT NUMBER := -20029;
exc_no_home_store_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_no_home_store_err , -20029);

/*********************************************************** 
The "invalid_discoverid_err" passes a numerical error of -20030.
An error occurs when Discover ID is invalid.

created : 06/07/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_discoverid_err CONSTANT NUMBER := -20030;
exc_invalid_discoverid_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_discoverid_err , -20030);

/*********************************************************** 
The "invalid_amexid_err" passes a numerical error of -20031.
An error occurs when Amex ID is = `999999999�.

created : 06/07/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_amexid_err CONSTANT NUMBER := -20031;
exc_invalid_amexid_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_amexid_err , -20031);

/*********************************************************** 
The "invalid_bank_card_err" passes a numerical error of -20032.
An error occurs when Bank_card cannot be found.

created : 06/07/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_bank_card_err CONSTANT NUMBER := -20032;
exc_invalid_bank_card_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_bank_card_err , -20032);

/*********************************************************** 
The "inactive_bank_card_err" passes a numerical error of -20033.
An error occurs when the effective date > current date & expiration date > 0.

created : 06/07/2012 cbd CCN Project
revisions: 

************************************************************/
en_inactive_bank_card_err CONSTANT NUMBER := -20033;
exc_inactive_bank_card_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_inactive_bank_card_err , -20033);

/*********************************************************** 
The "invalid_time_zone_err" passes a numerical error of -20034.
An error occurs when Polling Time Zone is Null.

created : 06/07/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_time_zone_err CONSTANT NUMBER := -20034;
exc_invalid_time_zone_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_time_zone_err , -20034);

/*********************************************************** 
The "invalid_poll_sched_err" passes a numerical error of -20035.
An error occurs when Polling Schedule Code is Null.

created : 06/07/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_poll_sched_err CONSTANT NUMBER := -20035;
exc_invalid_poll_sched_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_poll_sched_err , -20035);

/*********************************************************** 
The "invalid_poll_stat_err" passes a numerical error of -20036.
An error occurs when status code not = 'p' or 'q'.

created : 06/07/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_poll_stat_err CONSTANT NUMBER := -20036;
exc_invalid_poll_stat_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_poll_stat_err , -20036);

/*********************************************************** 
The "invalid_poll_phone_err" passes a numerical error of -20037.
An error occurs when the Polling phone number is null.

created : 06/07/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_poll_phone_err CONSTANT NUMBER := -20037;
exc_invalid_poll_phone_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_poll_phone_err , -20037);

/*********************************************************** 
The "invalid_costctr_name_err" passes a numerical error of -20038.
An error occurs when cost center name is null.

created : 06/07/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_costctr_name_err CONSTANT NUMBER := -20038;
exc_invalid_costctr_name_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_costctr_name_err , -20038);

/*********************************************************** 
The "invalid_inventory_id_err" passes a numerical error of -20039.
An error occurs when inventory_id not = `y�.

created : 06/07/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_inventory_id_err CONSTANT NUMBER := -20039;
exc_invalid_inventory_id_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_inventory_id_err , -20039);

/*********************************************************** 
The "invalid_status_err" passes a numerical error of -20040.
An error occurs when Status cannot be found.

created : 06/07/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_status_err CONSTANT NUMBER := -20040;
exc_invalid_status_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_status_err , -20040);

/*********************************************************** 
The "inactive_status_err" passes a numerical error of -20041.
An error occurs when effective date >
current date & expiration date not null.

created : 06/07/2012 cbd CCN Project
revisions: 

************************************************************/
en_inactive_status_err CONSTANT NUMBER := -20041;
exc_inactive_status_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_inactive_status_err , -20041);

/*********************************************************** 
The "invalid_type_err" passes a numerical error of -20042.
An error occurs when TYPE cannot be found.

created : 06/07/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_type_err CONSTANT NUMBER := -20042;
exc_invalid_type_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_type_err , -20042);

/*********************************************************** 
The "inactive_type_err" passes a numerical error of -20043.
An error occurs when effective date >
current date & expiration date not null.

created : 06/07/2012 cbd CCN Project
revisions: 

************************************************************/
en_inactive_type_err CONSTANT NUMBER := -20043;
exc_inactive_type_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_inactive_type_err , -20043);

/*********************************************************** 
The "invalid_terminal_err" passes a numerical error of -20044.
An error occurs when Terminal cannot be found.

created : 06/07/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_terminal_err CONSTANT NUMBER := -20044;
exc_invalid_terminal_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_terminal_err , -20044);

/*********************************************************** 
The "inactive_terminal_err" passes a numerical error of -20045.
An error occurs when effective date >
current date & expiration date not null.

created : 06/07/2012 cbd CCN Project
revisions: 

************************************************************/
en_inactive_terminal_err CONSTANT NUMBER := -20045;
exc_inactive_terminal_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_inactive_terminal_err , -20045);

/*********************************************************** 
The "invalid_store_err" passes a numerical error of -20046.
An error occurs when store cannot be found.

created : 06/07/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_store_err CONSTANT NUMBER := -20046;
exc_invalid_store_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_store_err , -20046);

/*********************************************************** 
The "inactive_store_err" passes a numerical error of -20047.
An error occurs when effective date >
current date & expiration date not null.

created : 06/07/2012 cbd CCN Project
revisions: 

************************************************************/
en_inactive_store_err CONSTANT NUMBER := -20047;
exc_inactive_store_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_inactive_store_err , -20047);

/*********************************************************** 
The "invalid_addr_usa_err" passes a numerical error of -20048.
An error occurs when Address USA cannot be found.

created : 06/07/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_addr_usa_err CONSTANT NUMBER := -20048;
exc_invalid_addr_usa_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_addr_usa_err , -20048);

/*********************************************************** 
The "inactive_addr_usa_err" passes a numerical error of -20049.
An error occurs when effective date >
current date & expiration date not null.

created : 06/07/2012 cbd CCN Project
revisions: 

************************************************************/
en_inactive_addr_usa_err CONSTANT NUMBER := -20049;
exc_inactive_addr_usa_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_inactive_addr_usa_err , -20049);

/*********************************************************** 
The "invalid_addr_mex_err" passes a numerical error of -20050.
An error occurs when Address MEX cannot be found.

created : 06/07/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_addr_mex_err CONSTANT NUMBER := -20050;
exc_invalid_addr_mex_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_addr_mex_err , -20050);

/*********************************************************** 
The "inactive_addr_mex_err" passes a numerical error of -20051.
An error occurs when effective date >
current date & expiration date not null.

created : 06/07/2012 cbd CCN Project
revisions: 

************************************************************/
en_inactive_addr_mex_err CONSTANT NUMBER := -20051;
exc_inactive_addr_mex_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_inactive_addr_mex_err , -20051);

/*********************************************************** 
The "invalid_addr_can_err" passes a numerical error of -20052.
An error occurs when address CAN cannot be found.

created : 06/07/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_addr_can_err CONSTANT NUMBER := -20052;
exc_invalid_addr_can_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_addr_can_err , -20052);

/*********************************************************** 
The "inactive_addr_can_err" passes a numerical error of -20053.
An error occurs when effective date >
current date & expiration date not null.

created : 06/07/2012 cbd CCN Project
revisions: 

************************************************************/
en_inactive_addr_can_err CONSTANT NUMBER := -20053;
exc_inactive_addr_can_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_inactive_addr_can_err , -20053);

/*********************************************************** 
The "invalid_addr_other_err" passes a numerical error of -20054.
An error occurs when Address Other cannot be found.

created : 06/07/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_addr_other_err CONSTANT NUMBER := -20054;
exc_invalid_addr_other_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_addr_other_err , -20054);

/*********************************************************** 
The "inactive_addr_othr_err" passes a numerical error of -20055.
An error occurs when effective date >
current date & expiration date not null.

created : 06/07/2012 cbd CCN Project
revisions: 

************************************************************/
en_inactive_addr_othr_err CONSTANT NUMBER := -20055;
exc_inactive_addr_othr_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_inactive_addr_othr_err , -20055);

/*********************************************************** 
The "invalid_hierarchy_err" passes a numerical error of -20056.
An error occurs when a Hiearchy cannot be found.

created : 06/07/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_hierarchy_err CONSTANT NUMBER := -20056;
exc_invalid_hierarchy_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_hierarchy_err , -20056);

/*********************************************************** 
The "inactive_hierarchy_err" passes a numerical error of -20057.
An error occurs when effective date >
current date & expiration date not null.

created : 06/07/2012 cbd CCN Project
revisions: 

************************************************************/
en_inactive_hierarchy_err CONSTANT NUMBER := -20057;
exc_inactive_hierarchy_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_inactive_hierarchy_err , -20057);

/*********************************************************** 
The "en_invalid_poll_ind_err" passes a numerical error of -20058.
An error occurs when Polling_Ind not = `Y� or `N�.

created : 06/07/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_poll_ind_err CONSTANT NUMBER := -20058;
exc_invalid_poll_ind_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_poll_ind_err , -20058);

/*********************************************************** 
The "invalid_polling_err" passes a numerical error of -20059.
An error occurs when Polling cannot be found.

created : 06/08/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_polling_err CONSTANT NUMBER := -20059;
exc_invalid_polling_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_polling_err , -20059);

/*********************************************************** 
The "inactive_polling_err" passes a numerical error of -20060.
An error occurs when Polling effective date >
current date & expiratin date not null.

created : 06/08/2012 cbd CCN Project
revisions: 

************************************************************/
en_inactive_polling_err CONSTANT NUMBER := -20060;
exc_inactive_polling_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_inactive_polling_err , -20060);

/*********************************************************** 
The "invalid_phone_err" passes a numerical error of -20061.
An error occurs when Phone cannot be found.

created : 06/18/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_phone_err CONSTANT NUMBER := -20061;
exc_invalid_phone_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_phone_err , -20061);

/*********************************************************** 
The "inactive_phone_num_err" passes a numerical error of -20062.
An error occurs when Phone number is null.

created : 06/18/2012 cbd CCN Project
revisions: 

************************************************************/
en_inactive_phone_num_err CONSTANT NUMBER := -20062;
exc_inactive_phone_num_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_inactive_phone_num_err , -20062);

/*********************************************************** 
The "invalid_priority_err" passes a numerical error of -20063.
An error occurs when polling priority is nulll.

created : 06/18/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_priority_err CONSTANT NUMBER := -20063;
exc_invalid_priority_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_priority_err , -20063);

/*********************************************************** 
The "invalid_cc_populated_err" passes a numerical error of -20064.
An error occurs when cost center has been populated.

created : 06/18/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_cc_populated_err CONSTANT NUMBER := -20064;
exc_invalid_cc_populated_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_cc_populated_err , -20064);

/*********************************************************** 
The "invalid_transport_type_err" passes a numerical error of -20065.
An error occurs when Transport Type is null.

created : 06/25/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_transport_type_err CONSTANT NUMBER := -20065;
exc_invalid_transport_type_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_transport_type_err , -20065);

/*********************************************************** 
The "invalid_tax_jurisdiction_err" passes a numerical error of -20066.
An error occurs when Tax Jurisdiction is null.

created : 06/25/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_tax_juris_err CONSTANT NUMBER := -20066;
exc_invalid_tax_juris_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_tax_juris_err , -20066);

/*********************************************************** 
The "invalid_tax_cmpny_code_err" passes a numerical error of -20067.
An error occurs when Tax Company code is  null.

created : 06/25/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_tax_cmpny_code_err CONSTANT NUMBER := -20067;
exc_invalid_tax_cmpny_code_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_tax_cmpny_code_err , -20067);

/*********************************************************** 
The "dest_point_err" passes a numerical error of -20068.
An error occurs when Destination Point is equal to zero
when country code is USA.

created : 06/28/2012 cbd CCN Project
revisions: 

************************************************************/
en_dest_point_err CONSTANT NUMBER := -20068;
exc_dest_point_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_dest_point_err , -20068);

/*********************************************************** 
The "chk_dgt_non_numb_err" passes a numerical error of -20069.
An error occurs when check digit not numeric.

created : 06/28/2012 cbd CCN Project
revisions: 

************************************************************/
en_chk_dgt_non_numb_err CONSTANT NUMBER := -20069;
exc_chk_dgt_non_numb_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_chk_dgt_non_numb_err , -20069);

/*********************************************************** 
The "dest_pt_non_numb_err" passes a numerical error of -20070.
An error occurs when destination point not numeric.

created : 06/28/2012 cbd CCN Project
revisions: 

************************************************************/
en_dest_pt_non_numb_err CONSTANT NUMBER := -20070;
exc_dest_pt_non_numb_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_dest_pt_non_numb_err , -20070);

/*********************************************************** 
The "drm_err" passes a numerical error of -20071.
This error is raised when there is an error in the DRM
webservices api call package.

created : 07/27/2012 oxd CCN Project 
revisions: 

************************************************************/
en_drm_err CONSTANT NUMBER := -20071;
exc_drm_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_drm_err , -20071);

/*********************************************************** 
The "duplicate_terminal_exp" passes a numerical error of -20072.
This message would be used when an attempt is made to add a
terminal to a cost center and a duplicate terminal row is
found with an expiration date that is null.

created : 07/30/2012 cbd CCN Project
revisions: 

************************************************************/
en_duplicate_terminal_err CONSTANT NUMBER := -20072;
exc_duplicate_terminal_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_duplicate_terminal_err , -20072);

/*********************************************************** 
The "invalid_terminal_nbr_err" passes a numerical error of -20073.
this message would be used when an attempt is made to add a
terminal for a terminal number that is not numeric.

created : 07/30/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_terminal_nbr_err CONSTANT NUMBER := -20073;
exc_invalid_terminal_nbr_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_terminal_nbr_err , -20073);

/*********************************************************** 
The "invalid_eff_date_err" passes a numerical error of -20074.
This message would be used when an invalid effective date is entered.

created : 07/30/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_eff_date_err CONSTANT NUMBER := -20074;
exc_invalid_eff_date_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_eff_date_err , -20074);

/*********************************************************** 
The "invalid_exp_date_err" passes a numerical error of -20075.
This message would be used when an invalid expiration date is entered. 

created : 07/30/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_exp_date_err CONSTANT NUMBER := -20075;
exc_invalid_exp_date_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_exp_date_err , -20075);

/*********************************************************** 
The "expdt_must_be_gt_effdt_err" passes a numerical error of -20076.
This message would be used when an expiration date is entered
that is not greater than the effective date.

created : 07/30/2012 cbd CCN Project
revisions: 

************************************************************/
en_expdt_must_be_gt_effdt_err CONSTANT NUMBER := -20076;
exc_expdt_must_be_gt_effdt_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_expdt_must_be_gt_effdt_err , -20076);

/*********************************************************** 
The "no_sales_mgr_err" passes a numerical error of -20077.
This error will check to make sure that there is a valid
Territory_Sales_MGR table entry for the
Sales Manager Code entered.

created : 08/1/2012 cbd CCN Project
revisions: 

************************************************************/
en_no_sales_mgr_err CONSTANT NUMBER := -20077;
exc_no_sales_mgr_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_no_sales_mgr_err , -20077);

/*********************************************************** 
The "inv_home_store_desig1_err" passes a numerical error of -20078.
This error will check to make sure that there is a Home Store
assignment if the Cost Center is not closed.

created : 08/1/2012 cbd CCN Project
revisions: 

************************************************************/
en_inv_home_store_desig1_err CONSTANT NUMBER := -20078;
exc_inv_home_store_desig1_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_inv_home_store_desig1_err , -20078);

/*********************************************************** 
The "inv_home_store_desig2_err" passes a numerical error of -20079.
This error will check to make sure that if the Cost Center
is Closed, that there is no Home Store Assignment.  

created : 08/1/2012 cbd CCN Project
revisions: 

************************************************************/
en_inv_home_store_desig2_err CONSTANT NUMBER := -20079;
exc_inv_home_store_desig2_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_inv_home_store_desig2_err , -20079);

/*********************************************************** 
The "no_emp_data_err" passes a numerical error of -20080.
This error will check to make sure that the Sales Rep has
a valid GEMS record (EMP_DATA) and that the Sales Rep's
Payroll status is "Active"
                                               
created : 08/3/2012 cbd CCN Project
revisions: 

************************************************************/
en_no_emp_data_err CONSTANT NUMBER := -20080;
exc_no_emp_data_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_no_emp_data_err , -20080);

/*********************************************************** 
The "invalid_emp_code_err" passes a numerical error of -20081.
This error tells us when the Employee_Code on the SALES_REP table
does not match the Emp_Payroll_Status on the EMP_DATA View
(i.e. the Employee_Code is "10" but the Emp_Payroll_Status is not "A"). 

created : 08/3/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_emp_code_err CONSTANT NUMBER := -20081;
exc_invalid_emp_code_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_emp_code_err , -20081);

/*********************************************************** 
The "invalid_store_category_err" passes a numerical error of -20082.
An error occurs when an inputted cost center rows category is not equal "S". 

created : 08/3/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_store_category_err CONSTANT NUMBER := -20082;
exc_invalid_store_category_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_store_category_err , -20082);

/*********************************************************** 
The "bad_merchant_id_err" passes a numerical error of -20083.
An error occurs when an error was returned from merchant_s_sp procedure. 

created : 08/3/2012 cbd CCN Project
revisions: 

************************************************************/
en_bad_merchant_id_err CONSTANT NUMBER := -20083;
exc_bad_merchant_id_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_bad_merchant_id_err , -20083);

/*********************************************************** 
The "discvr_id_nonum_err" passes a numerical error of -20084.
An error occurs when Discover_id is not numeric.

created : 08/3/2012 cbd CCN Project
revisions: 

************************************************************/
en_discvr_id_nonum_err CONSTANT NUMBER := -20084;
exc_discvr_id_nonum_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_discvr_id_nonum_err , -20084);

/*********************************************************** 
The "discvr_id_zero_err" passes a numerical error of -20085.
An error occurs when discover_id cannot be zeroes.

created : 08/3/2012 cbd CCN Project
revisions: 

************************************************************/
en_discvr_id_zero_err CONSTANT NUMBER := -20085;
exc_discvr_id_zero_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_discvr_id_zero_err , -20085);

/*********************************************************** 
The "amex_id_zero_err" passes a numerical error of -20086.
An error occurs when Amex_id cannot be zeroes.

created : 08/3/2012 cbd CCN Project
revisions: 

************************************************************/
en_amex_id_zero_err CONSTANT NUMBER := -20086;
exc_amex_id_zero_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_amex_id_zero_err , -20086);

/*********************************************************** 
The "amex_id_nonum_err" passes a numerical error of -20087.
An error occurs when Amex_id is not numeric.

created : 08/3/2012 cbd CCN Project
revisions: 

************************************************************/
en_amex_id_nonum_err CONSTANT NUMBER := -20087;
exc_amex_id_nonum_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_amex_id_nonum_err , -20087);

/*********************************************************** 
The "invalid_slsmgr_cd_err " passes a numerical error of -20088.
An error occurs when Territory Sales Manager row not found.

created : 08/09/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_slsmgr_cd_err  CONSTANT NUMBER := -20088;
exc_invalid_slsmgr_cd_err  EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_slsmgr_cd_err  , -20088);

/*********************************************************** 
The "nonum_phone1_err" passes a numerical error of -20089.
An error occurs when Netacc_phone_1 is not numeric.

created : 08/3/2012 cbd CCN Project
revisions: 

************************************************************/
en_nonum_phone1_err CONSTANT NUMBER := -20089;
exc_nonum_phone1_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_nonum_phone1_err , -20089);

/*********************************************************** 
The "nonum_phone2_err" passes a numerical error of -20090.
An error occurs when Netacc_phone_2 is not numeric.

created : 08/3/2012 cbd CCN Project
revisions: 

************************************************************/
en_nonum_phone2_err CONSTANT NUMBER := -20090;
exc_nonum_phone2_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_nonum_phone2_err , -20090);

/*********************************************************** 
The "nonum_phone1_area_err" passes a numerical error of -20091.
An error occurs when Netacc_phone_1 area code is not numeric.

created : 08/3/2012 cbd CCN Project
revisions: 

************************************************************/
en_nonum_phone1_area_err CONSTANT NUMBER := -20091;
exc_nonum_phone1_area_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_nonum_phone1_area_err , -20091);

/*********************************************************** 
The "nonum_phone2_area_err" passes a numerical error of -20092.
An error occurs when Netacc_phone_2 area code is not numeric.

created : 08/3/2012 cbd CCN Project
revisions: 

************************************************************/
en_nonum_phone2_area_err CONSTANT NUMBER := -20092;
exc_nonum_phone2_area_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_nonum_phone2_area_err , -20092);

/*********************************************************** 
The "nonum_phone1_longdst_err" passes a numerical error of -20093.
An error occurs when Netacc_phone_1, position 1 is not numeric.

created : 08/3/2012 cbd CCN Project
revisions: 

************************************************************/
en_nonum_phone1_longdst_err CONSTANT NUMBER := -20093;
exc_nonum_phone1_longdst_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_nonum_phone1_longdst_err , -20093);

/*********************************************************** 
The "nonum_phone2_longdst_err" passes a numerical error of -20094.
An error occurs when Netacc_phone_2, position 1 is not numeric.

created : 08/3/2012 cbd CCN Project
revisions: 

************************************************************/
en_nonum_phone2_longdst_err CONSTANT NUMBER := -20094;
exc_nonum_phone2_longdst_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_nonum_phone2_longdst_err , -20094);

/*********************************************************** 
The "zero_phone1_err" passes a numerical error of -20095.
An error occurs when Netacc_phone_1, cannot be zero.

created : 08/3/2012 cbd CCN Project
revisions: 

************************************************************/
en_zero_phone1_err CONSTANT NUMBER := -20095;
exc_zero_phone1_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_zero_phone1_err , -20095);

/*********************************************************** 
The "zero_phone2_err" passes a numerical error of -20096.
An error occurs when Netacc_phone_2 cannot be zero .

created : 08/3/2012 cbd CCN Project
revisions: 

************************************************************/
en_zero_phone2_err CONSTANT NUMBER := -20096;
exc_zero_phone2_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_zero_phone2_err , -20096);

/*********************************************************** 
The "zero_phone1_area_err" passes a numerical error of -20097.
An error occurs when Netacc_phone_1 area code cannot be zero.

created : 08/3/2012 cbd CCN Project
revisions: 

************************************************************/
en_zero_phone1_area_err CONSTANT NUMBER := -20097;
exc_zero_phone1_area_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_zero_phone1_area_err , -20097);

/*********************************************************** 
The "zero_phone2_area_err" passes a numerical error of -20098.
An error occurs when Netacc_phone_2 area code cannot be zero.

created : 08/3/2012 cbd CCN Project
revisions: 

************************************************************/
en_zero_phone2_area_err CONSTANT NUMBER := -20098;
exc_zero_phone2_area_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_zero_phone2_area_err , -20098);

/*********************************************************** 
The "zero_phone1_longdst_err" passes a numerical error of -20099.
An error occurs when Netacc_phone_1, position 1 cannot be zero.

created : 08/3/2012 cbd CCN Project
revisions: 

************************************************************/
en_zero_phone1_longdst_err CONSTANT NUMBER := -20099;
exc_zero_phone1_longdst_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_zero_phone1_longdst_err , -20099);

/*********************************************************** 
The "zero_phone2_longdst_err" passes a numerical error of -20100.
An error occurs when Netacc_phone_2, position 1 cannot be zero.

created : 08/3/2012 cbd CCN Project
revisions: 

************************************************************/
en_zero_phone2_longdst_err CONSTANT NUMBER := -20100;
exc_zero_phone2_longdst_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_zero_phone2_longdst_err , -20100);

/*********************************************************** 
The "set_perp_inv_dt_err" passes a numerical error of -20101.
Perp_inv_start_date must be entered when
inventory_indicator = "Y"; default current date .

created : 08/3/2012 cbd CCN Project
revisions: 

************************************************************/
en_set_perp_inv_dt_err CONSTANT NUMBER := -20101;
exc_set_perp_inv_dt_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_set_perp_inv_dt_err , -20101);

/*********************************************************** 
The "inv_start_dt_err" passes a numerical error of -20102.
Perp_inv_start_date set to null when inventory_indicator = "N". 

created : 08/3/2012 cbd CCN Project
revisions: 

************************************************************/
en_inv_start_dt_err CONSTANT NUMBER := -20102;
exc_inv_start_dt_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_inv_start_dt_err , -20102);

/*********************************************************** 
The "code_header_name_err" passes a numerical error of -20103.
This error will check to make sure that the Code Header name
in the CODE_HEADER table is not null or spaces.

created : 08/6/2012 cbd CCN Project
revisions: 

************************************************************/
en_code_header_name_err CONSTANT NUMBER := -20103;
exc_code_header_name_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_code_header_name_err , -20103);

/*********************************************************** 
The "code_header_desc_err" passes a numerical error of -20104.
This error will check to make sure that the Code Header
description in the CODE_HEADER table is not null or spaces.

created : 08/6/2012 cbd CCN Project
revisions: 

************************************************************/
en_code_header_desc_err CONSTANT NUMBER := -20104;
exc_code_header_desc_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_code_header_desc_err , -20104);

/*********************************************************** 
The "code_header_dflt_err" passes a numerical error of -20105.
This error will check to make sure that the Code Header Detail
default value in the CODE_HEADER table is not null or spaces.

created : 08/6/2012 cbd CCN Project
revisions: 

************************************************************/
en_code_header_dflt_err CONSTANT NUMBER := -20105;
exc_code_header_dflt_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_code_header_dflt_err , -20105);

/*********************************************************** 
The "inv_code_hdr_val_size_err" passes a numerical error of -20106.
This error will check to make sure that the Code Header Detail Value Size,
which determines the size of the CODE, in the CODE_HEADER record is numeric
and not zeros.  

created : 08/6/2012 cbd CCN Project
revisions: 

************************************************************/
en_inv_code_hdr_val_size_err CONSTANT NUMBER := -20106;
exc_inv_code_hdr_val_size_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_inv_code_hdr_val_size_err , -20106);

/*********************************************************** 
The "invalid_cost_center_code_err" passes a numerical error of -20107.
This message would be used when the format of the cost_center_code
is not 2 digit numeric followed by 4 digit numeric or alpha.

created : 08/6/2012 cbd CCN Project
revisions: 

************************************************************/
en_inv_cost_center_code_err CONSTANT NUMBER := -20107;
exc_inv_cost_center_code_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_inv_cost_center_code_err , -20107);

/*********************************************************** 
The "duplicate_cost_center_err" passes a numerical error of -20108.
message would be used when an attempt is made to add a
cost_center that is already in the table.

created : 08/6/2012 cbd CCN Project
revisions: 

************************************************************/
en_duplicate_cost_center_err CONSTANT NUMBER := -20108;
exc_duplicate_cost_center_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_duplicate_cost_center_err , -20108);

/*********************************************************** 
The "invalid_category_err" passes a numerical error of -20109.
This message would be used when the category is not a valid value.

created : 08/6/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_category_err CONSTANT NUMBER := -20109;
exc_invalid_category_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_category_err , -20109);

/*********************************************************** 
The "invalid_statement_type_err" passes a numerical error of -20110.
This message would be used when the statement_type
is not a valid value.

created : 08/6/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_statement_type_err CONSTANT NUMBER := -20110;
exc_invalid_statement_type_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_statement_type_err , -20110);

/*********************************************************** 
The "invalid_country_code_err" passes a numerical error of -20111.
This message would be used when the country_code is not a valid value.

created : 08/6/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_country_code_err CONSTANT NUMBER := -20111;
exc_invalid_country_code_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_country_code_err , -20111);

/*********************************************************** 
The "country_statement_match_err" passes a numerical error of -20112.
This message would be used when the country_code and statement_type
are not corresponding values.

created : 08/6/2012 cbd CCN Project
revisions: 

************************************************************/
en_country_stmt_match_err constant number := -20112;
exc_country_stmt_match_err EXCEPTION;
pragma exception_init
(exc_country_stmt_match_err , -20112);

/*********************************************************** 
The "invalid_fin_close_date_err" passes a numerical error of -20113.
This message would be used when the fin_close_date is not a valid date.

created : 08/6/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_fin_close_date_err CONSTANT NUMBER := -20113;
exc_invalid_fin_close_date_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_fin_close_date_err , -20113);

/*********************************************************** 
The "invalid_currency_code_err" passes a numerical error of -20114.
This message would be used when the currency_code is not a valid value
or does not correspond to the country_code.

created : 08/6/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_currency_code_err CONSTANT NUMBER := -20114;
exc_invalid_currency_code_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_currency_code_err , -20114);

/*********************************************************** 
The "invalid_div_nonum_err" passes a numerical error of -20115.
An error occurs when  sales manger code pos 1-2 not numeric.

created : 08/09/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_div_nonum_err CONSTANT NUMBER := -20115;
exc_invalid_div_nonum_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_div_nonum_err , -20115);

/*********************************************************** 
The "invalid_area_nonum_err" passes a numerical error of -20116.
An error occurs when sales manger code pos 3-4 not numeric.

created : 08/09/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_area_nonum_err CONSTANT NUMBER := -20116;
exc_invalid_area_nonum_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_area_nonum_err , -20116);

/*********************************************************** 
The "invalid_dist_nonum_err" passes a numerical error of -20117.
An error occurs when 'sales manger code pos 5-6 not numeric.

created : 08/09/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_dist_nonum_err CONSTANT NUMBER := -20117;
exc_invalid_dist_nonum_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_dist_nonum_err , -20117);

/*********************************************************** 
The "invalid_cc_spaces_err" passes a numerical error of -20118.
An error occurs when cost center code is null.

created : 08/09/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_cc_spaces_err CONSTANT NUMBER := -20118;
exc_invalid_cc_spaces_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_cc_spaces_err , -20118);

/*********************************************************** 
The "invalid_terr_category_err" passes a numerical error of -20119.
An error occurs when category for territory not equal to  T.

created : 08/09/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_terr_category_err CONSTANT NUMBER := -20119;
exc_invalid_terr_category_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_terr_category_err , -20119);

/*********************************************************** 
The "invalid_gemsid_spaces_err" passes a numerical error of -20120.
An error occurs when gems employee id is spaces.

created : 08/09/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_gemsid_spaces_err CONSTANT NUMBER := -20120;
exc_invalid_gemsid_spaces_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_gemsid_spaces_err , -20120);

/*********************************************************** 
The "invalid_empdata_err" passes a numerical error of -20121.
An error occurs when employee data table cannot be found.

created : 08/09/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_empdata_err CONSTANT NUMBER := -20121;
exc_invalid_empdata_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_empdata_err , -20121);

/*********************************************************** 
The "invalid_tslsmgr_err" passes a numerical error of -20122.
An error occurs when territory sales manager table cannot be found.

created : 08/09/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_tslsmgr_err CONSTANT NUMBER := -20122;
exc_invalid_tslsmgr_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_tslsmgr_err , -20122);

/*********************************************************** 
The "invalid_other_category_err" passes a numerical error of -20123.
An error occurs when category for other not equal to  O.

created : 08/09/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_other_category_err CONSTANT NUMBER := -20123;
exc_invalid_other_category_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_other_category_err , -20123);

/*********************************************************** 
The "invalid_re_category_err" passes a numerical error of -20124.
An error occurs when category for real estate not equal to  R.

created : 08/09/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_re_category_err CONSTANT NUMBER := -20124;
exc_invalid_re_category_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_re_category_err , -20124);

/*********************************************************** 
The "code_detail_value_err" passes a numerical error of -20125.
This error will check to make sure that the Code Detail Value
in the CODE_DETAIL table is not null or spaces. This error will
also check to make sure the size of the digits in this column
do not exceed the Code_Header_Dtl_Val_Size in the CODE_HEADER table. 

created : 08/09/2012 cbd CCN Project
revisions: 

************************************************************/
en_code_detail_value_err CONSTANT NUMBER := -20125;
exc_code_detail_value_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_code_detail_value_err , -20125);

/*********************************************************** 
The "code_detail_desc_err" passes a numerical error of -20126.
This error will check to make sure that the Code detail description
in the CODE_DETAIL table is not null or spaces. 

created : 08/09/2012 cbd CCN Project
revisions: 

************************************************************/
en_code_detail_desc_err CONSTANT NUMBER := -20126;
exc_code_detail_desc_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_code_detail_desc_err , -20126);

/*********************************************************** 
The "invalid_admin_category_err" passes a numerical error of -20127.
An error occurs when category for Administration not equal to  A. 

created : 08/09/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_admin_category_err CONSTANT NUMBER := -20127;
exc_invalid_admin_category_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_admin_category_err , -20127);

/*********************************************************** 
The "invalid_admin_cc_catg_err" passes a numerical error of -20128.
An error occurs when Cost Center table category_code must be = A. 

created : 08/09/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_admin_cc_catg_err CONSTANT NUMBER := -20128;
exc_invalid_admin_cc_catg_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_admin_cc_catg_err , -20128);

/*********************************************************** 
The "invalid_re_cc_catg_err" passes a numerical error of -20129.
An error occurs when Cost Center table category_code must be = R.

created : 08/09/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_re_cc_catg_err CONSTANT NUMBER := -20129;
exc_invalid_re_cc_catg_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_re_cc_catg_err , -20129);

/*********************************************************** 
The "invalid_othr_cc_catg_err" passes a numerical error of -20130.
An error occurs when Cost Center table category_code must be = O.

created : 08/09/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_othr_cc_catg_err CONSTANT NUMBER := -20130;
exc_invalid_othr_cc_catg_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_othr_cc_catg_err , -20130);

/*********************************************************** 
The "cctr_must_be_ent_err" passes a numerical error of -20131.
This message would be used when the cost_center_code has not been
entered and is required.

created : 08/09/2012 cbd CCN Project
revisions: 

************************************************************/
en_cctr_must_be_ent_err CONSTANT NUMBER := -20131;
exc_cctr_must_be_ent_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_cctr_must_be_ent_err , -20131);

/*********************************************************** 
The "invalid_zip_code_err" passes a numerical error of -20132.
This message would be used when zip_code or postal_code
has been entered in an invalid format.

created : 08/09/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_zip_code_err CONSTANT NUMBER := -20132;
exc_invalid_zip_code_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_zip_code_err , -20132);

/*********************************************************** 
The "country_must_be_ent_err" passes a numerical error of -20133.
This message would be used when the country has not been entered
and is required.

created : 08/09/2012 cbd CCN Project
revisions: 

************************************************************/
en_country_must_be_ent_err CONSTANT NUMBER := -20133;
exc_country_must_be_ent_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_country_must_be_ent_err , -20133);

/*********************************************************** 
The "invalid_state_code_err" passes a numerical error of -20134.
This message would be used when the state_code is not a valid value.

created : 08/09/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_state_code_err CONSTANT NUMBER := -20134;
exc_invalid_state_code_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_state_code_err , -20134);

/*********************************************************** 
The "invalid_county_err" passes a numerical error of -20135.
This message would be used when the county is not a valid value.

created : 08/09/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_county_err CONSTANT NUMBER := -20135;
exc_invalid_county_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_county_err , -20135);

/*********************************************************** 
The "invalid_fips_code_err" passes a numerical error of -20136.
This message would be used when the fips_code is not a valid value.

created : 08/09/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_fips_code_err CONSTANT NUMBER := -20136;
exc_invalid_fips_code_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_fips_code_err , -20136);

/*********************************************************** 
The "invalid_dest_point_err" passes a numerical error of -20137.
This message would be used when the destiniation_point is not a valid value.

created : 08/09/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_dest_point_err CONSTANT NUMBER := -20137;
exc_invalid_dest_point_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_dest_point_err , -20137);

/*********************************************************** 
The "invalid_check_digit_err" passes a numerical error of -20138.
This message would be used when the check_digit is not a valid value.

created : 08/09/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_check_digit_err CONSTANT NUMBER := -20138;
exc_invalid_check_digit_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_check_digit_err , -20138);

/*********************************************************** 
The "invalid_cc_nonum_err" passes a numerical error of -20139.
An error occurs when cost center code not numeric.

created : 08/10/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_cc_nonum_err CONSTANT NUMBER := -20139;
exc_invalid_cc_nonum_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_cc_nonum_err , -20139);

/*********************************************************** 
The "invalid_gems_nonum_err" passes a numerical error of -20140.
An error occurs when gems employee id  not numeric.

created : 08/10/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_gems_nonum_err CONSTANT NUMBER := -20140;
exc_invalid_gems_nonum_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_gems_nonum_err , -20140);

/*********************************************************** 
The "invalid_code_detail_err" passes a numerical error of -20141.
This error will check to make sure that a given column is
in the CODE_DETAIL table. 

created : 08/15/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_code_detail_err CONSTANT NUMBER := -20141;
exc_invalid_code_detail_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_code_detail_err , -20141);

/*********************************************************** 
The "country_currency_match_err" passes a numerical error of -20142.
This message would be used when the country_code and currency_code
do not match.

created : 08/16/2012 cbd CCN Project
revisions: 

************************************************************/
en_country_currency_match_err CONSTANT NUMBER := -20142;
exc_country_currency_match_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_country_currency_match_err , -20142);

/*********************************************************** 
The "invalid_last_name_err" passes a numerical error of -20143.
An error occurs when the required last name column is not entered. 

created : 09/26/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_last_name_err CONSTANT NUMBER := -20143;
exc_invalid_last_name_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_last_name_err , -20143);

/*********************************************************** 
The "invalid_first_name_err" passes a numerical error of -20144.
An error occurs when the required first name column is not entered.

created : 09/26/2012 cbd CCN Project
revisions: 

************************************************************/
en_invalid_first_name_err CONSTANT NUMBER := -20144;
exc_invalid_first_name_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_first_name_err , -20144);

/*********************************************************** 
The "multipl_expire_err" passes a numerical error of -20145.
This error will check to make sure that multiple active
records do not exist for a given cost center. 

created : 12/12/2012 cbd CCN Project
revisions: 

************************************************************/
en_multipl_expire_err CONSTANT NUMBER := -20145;
exc_multipl_expire_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_multipl_expire_err , -20145);

/*********************************************************** 
The "no_unexpire_err" passes a numerical error of -20146.
This error will check to make sure that there is at least
one active record (row) for a given cost center.

created : 12/12/2012 cbd CCN Project
revisions: 

************************************************************/
en_no_unexpire_err CONSTANT NUMBER := -20146;
exc_no_unexpire_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_no_unexpire_err , -20146);

/*********************************************************** 
The "record_update_err" passes a numerical error of -20147.
This error will be returned when EXPIRE_DATA_SP could not
update the expire_date for a given table. 

created : 12/12/2012 cbd CCN Project
revisions: 

************************************************************/
en_record_update_err CONSTANT NUMBER := -20147;
exc_record_update_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_record_update_err , -20147);

/*********************************************************** 
The "parameter_null_err" passes a numerical error of -20148.
This error will check to make sure that the multiple inputs
into the parocedure are not null. 

created : 12/17/2012 cbd CCN Project
revisions: 

************************************************************/
en_parameter_null_err CONSTANT NUMBER := -20148;
exc_parameter_null_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_parameter_null_err , -20148);

/*********************************************************** 
The "no_migrations_detaill_err" passes a numerical error of -20149.
This error will check to make sure that there is one or more
MIGRATIONS_DETAIL rows for each MIGRATIONS_HEADER record processed.
                                                      
created : 02/11/2013 cbd CCN Project
revisions: 

************************************************************/
en_no_migrations_detail_err CONSTANT NUMBER := -20149;
exc_no_migrations_detail_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_no_migrations_detail_err , -20149);

/*********************************************************** 
The "migration_update_err" passes a numerical error of -20150.
An error occurs when migration_id and environment keys
do not match  Migration_Header and Migration_Detail tables. 
                                                      
created : 02/13/2013 cbd CCN Project
revisions: 

************************************************************/
en_migration_update_err CONSTANT NUMBER := -20150;
exc_migration_update_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_migration_update_err , -20150);

/*********************************************************** 
The "selection_code_err" passes a numerical error of -20151.
This error will check to make sure that there is a
valid selection code sent to the process.

created : 02/13/2013 cbd CCN Project
revisions: 

************************************************************/
en_selection_code_err CONSTANT NUMBER := -20151;
exc_selection_code_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_selection_code_err , -20151);

/*********************************************************** 
The "no_terr_asgn_err" passes a numerical error of -20152.
This error will occur when a Territory_Assignment is
not found for the key field values entered.

created : 02/22/2013 cbd CCN Project
revisions: 

************************************************************/
en_no_terr_asgn_err CONSTANT NUMBER := -20152;
exc_no_terr_asgn_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_no_terr_asgn_err , -20152);

/*********************************************************** 
The "invalid_rurl_met_zone_err" passes a numerical error of -20153.
This error will occur when a Rural_Metro_Zone_Code is not found
in the Detail_Code Table for the value entered.

created : 02/27/2013 cbd CCN Project
revisions: 

************************************************************/
en_invalid_rurl_met_zone_err CONSTANT NUMBER := -20153;
exc_invalid_rurl_met_zone_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_rurl_met_zone_err , -20153);

/*********************************************************** 
The "address_info_missing_err" passes a numerical error of -20154.
An error occurs when Address information is not entered for
a new Cost_Center.

created : 05/24/2013 cbd CCN Project
revisions: 

************************************************************/
en_address_info_missing_err CONSTANT NUMBER := -20154;
exc_address_info_missing_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_address_info_missing_err , -20154);

/*********************************************************** 
The "invalid_duns_number_err" passes a numerical error of -20155.
This error will state the the duns number is missing for
Stores & Others or that the duns number is not numeric. 

created : 06/20/2013 cbd CCN Project
revisions: 

************************************************************/
en_invalid_duns_number_err CONSTANT NUMBER := -20155;
exc_invalid_duns_number_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_duns_number_err , -20155);

/*********************************************************** 
The "dup_mainframe_costcntr_err" passes a numerical error of -20156.
This error will state that the entered new cost center has same 
last 4 characters as one already existsing in the system. 

created : 06/20/2013 cbd CCN Project
revisions: 

************************************************************/
en_dup_mainframe_costcntr_err CONSTANT NUMBER := -20156;
exc_dup_mainframe_costcntr_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(EXC_DUP_MAINFRAME_COSTCNTR_ERR , -20156);

/*********************************************************** 
The "first_two_digit_err" passes a numerical error of -20157.
This error will state that the entered new cost center has same 
last 4 characters as one already existsing in the system. 

created : 09/16/2013 nxk CCN Project
revisions: 

************************************************************/
en_first_two_digit_err CONSTANT NUMBER := -20157;
exc_first_two_digit_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_first_two_digit_err , -20157);

/*********************************************************** 
The "invalid_amex_id_size_err" passes a numerical error of -20158.
This error will state that the AMEX ID entered is not of valid size. 

created : 12/19/2013 jxc517 CCN Project
revisions: 

************************************************************/
en_invalid_amex_id_size_err CONSTANT NUMBER := -20158;
exc_invalid_amex_id_size_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_amex_id_size_err , -20158);

/*********************************************************** 
The "invalid_duns_nbr_size_err" passes a numerical error of -20159.
This error will state that the Dums Number entered is not of valid size(9). 

created : 01/31/2014 jxc517 CCN Project
revisions: 

************************************************************/
en_invalid_duns_nbr_size_err CONSTANT NUMBER := -20159;
exc_invalid_duns_nbr_size_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_duns_nbr_size_err , -20159);

/*********************************************************** 
The "invalid_code_hdr_size_err" passes a numerical error of -20160.
This error will state that the Size of the code detail value 
should not exceed the value defined in the code header. 

created : 03/05/2014 jxc517 CCN Project
revisions: 

************************************************************/
en_invalid_code_hdr_size_err CONSTANT NUMBER := -20160;
exc_invalid_code_hdr_size_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_code_hdr_size_err , -20160);

/*********************************************************** 
The "terminal_window_locked_err" passes a numerical error of -20161.
This error will state that the terminal window has been locked by 
some user. 

created : 07/07/2014 jxc517 CCN Project
revisions: 

************************************************************/
en_terminal_window_locked_err CONSTANT NUMBER := -20161;
exc_terminal_window_locked_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_terminal_window_locked_err , -20161);

/*********************************************************** 
The "actv_dup_terr_exists_err" passes a numerical error of -20162.
This error will state that the terminal window has been locked by 
some user. 

created : 11/13/2014 jxc517 CCN Project
revisions: 

************************************************************/
en_actv_dup_terr_exists_err CONSTANT NUMBER := -20162;
exc_actv_dup_terr_exists_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_actv_dup_terr_exists_err , -20162);

/*********************************************************** 
The "territory_typ_business_rule" passes a numerical error of -20163.
This error will state that territory type busienss code is applicable only
for territory cost centers

created : 02/19/2015 jxc517 CCN Project
revisions: 

************************************************************/
en_territory_typ_business_rule CONSTANT NUMBER := -20163;
exc_territory_typ_busines_rule EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_territory_typ_busines_rule , -20163);

/*********************************************************** 
The "invalid_addr_brb_err" passes a numerical error of -20164.
An error occurs when address BRB cannot be found.

created : 05/24/2016 jxc517 CCN Project Team....
revisions: 

************************************************************/
en_invalid_addr_brb_err CONSTANT NUMBER := -20164;
exc_invalid_addr_brb_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_addr_brb_err , -20164);

/*********************************************************** 
The "status_check_warning_wrn" passes a numerical error of -20500.
This error will state a warning that the address line has been
changed and that the status code may need to be changed for
relocation. 

created : 01/15/2013 cbd CCN Project
revisions: 

************************************************************/
en_status_check_warning_wrn CONSTANT NUMBER := -20500;
exc_status_check_warning_wrn EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_status_check_warning_wrn , -20500);

/*********************************************************** 
The "taxware_check_warning_wrn" passes a numerical error of -20501.
This error will state a warning that the zip or zip +4 fields
have been changed and that the taxware file may need to be updated. 

created : 01/15/2013 cbd CCN Project
revisions: 

************************************************************/
en_taxware_check_warning_wrn CONSTANT NUMBER := -20501;
exc_taxware_check_warning_wrn EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_taxware_check_warning_wrn , -20501);

/*********************************************************** 
The "invalid_order_wrn" passes a numerical error of -20502.
This error will state a warning that the order of the levels 
added for a new hierarchy is incorrect based on Global Hierarchy. 

created : 06/14/2013 SH CCN Project
revisions: 

************************************************************/
en_invalid_order_wrn CONSTANT NUMBER := -20502;
exc_invalid_order_wrn EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_order_wrn , -20502);

/*********************************************************** 
The "chk_hier_wrn" passes a numerical error of -20503.
This error will state a warning that If a Global Hierarchy is 
changed for a Cost Center,other hierarchies such as the 
Alternate D-A-D, SGL Division, or COA Division must be checked for 
possible changes for the same cost center. This will be a Warning message 
to check or verify other hierarchies for the same cost center

created : 06/14/2013 SH CCN Project
revisions: 

************************************************************/
en_chk_hier_wrn CONSTANT NUMBER := -20503;
exc_chk_hier_wrn EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_chk_hier_wrn , -20503);

/*********************************************************** 
The "Stmnt_Type_wrn" passes a numerical error of -20504.
This error will state a warning that When a higher node's Statement_Type
changes, all lower nodes will be checked to make sure that they adhere 
to business rules and have the same statement type except for NULL
(wildcard). 

created : 06/14/2013 SH CCN Project
revisions: 

************************************************************/
en_Stmnt_Type_wrn CONSTANT NUMBER := -20504;
exc_Stmnt_Type_wrn EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_Stmnt_Type_wrn , -20504);

/*********************************************************** 
The "invalid_cc_wrn" passes a numerical error of -20505.
This error will state a warning that When a higher node's Statement_Type
changes, the Cost Center cannot be Null.

created : 06/14/2013 SH CCN Project
revisions: 

************************************************************/
en_invalid_cc_wrn CONSTANT NUMBER := -20505;
exc_invalid_cc_wrn EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_cc_wrn , -20505);

/*********************************************************** 
The "exp_date_wrn" passes a numerical error of -20506.
This error will state a warning that before allowing the expiration 
of any level (i.e. division or area) all lower nodes (area, 
district, cost center)must have been expired previously.

created : 06/14/2013 SH CCN Project
revisions: 

************************************************************/
en_exp_date_wrn CONSTANT NUMBER := -20506;
exc_exp_date_wrn EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_exp_date_wrn , -20506);

/*********************************************************** 
The "dist_exists_wrn" passes a numerical error of -20507.
This error will state a warning that for Reporting_DAD, City DAD, 
or Alternate DAD - duplication of a district number across all divisions 
and Areas is not allowed.

created : 06/14/2013 SH CCN Project
revisions: 

************************************************************/
en_dist_exists_wrn CONSTANT NUMBER := -20507;
exc_dist_exists_wrn EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_dist_exists_wrn , -20507);

/*********************************************************** 
The "CC_exists_wrn" passes a numerical error of -20508.
This error will state a warning that for Reporting_DAD or City DAD, 
duplication of a Cost Center across areas or divisions is not allowed

created : 06/14/2013 SH CCN Project
revisions: 

************************************************************/
en_CC_exists_wrn CONSTANT NUMBER := -20508;
exc_CC_exists_wrn EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_CC_exists_wrn , -20508);

/*********************************************************** 
The "CC_exists_err" passes a numerical error of -20509.
This error will state an error that,duplication of a Cost Center 
in the same Hierarchy is not allowed

created : 07/01/2013 SH CCN Project
revisions: 

************************************************************/
en_CC_exists_err CONSTANT NUMBER := -20509;
exc_CC_exists_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_CC_exists_err , -20509);

/*********************************************************** 
The "CC_exists_err" passes a numerical error of -20509.
This error will state an error that,duplication of a Cost Center 
in the same Hierarchy is not allowed

created : 07/01/2013 SH CCN Project
revisions: 

************************************************************/
en_invalid_levels_err CONSTANT NUMBER := -20510;
exc_invalid_levels_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_levels_err , -20510);


/*********************************************************** 
The "EN_PREV_LEVEL_MISSING_ERR" passes a numerical error of -20155.
This error will state the the duns number is missing for
Stores & Others or that the duns number is not numeric. 

created : 07/01/2013 SH CCN Project
revisions: 

************************************************************/
EN_PREV_LEVEL_MISSING_ERR CONSTANT number := -20511;
exc_prev_level_missing_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(EXC_PREV_LEVEL_MISSING_ERR , -20511);

/*********************************************************** 
The "invalid_stmnt_type_err" passes a numerical error of -20512.
This error will state an error that,the statment type at 5th level of
global hierarchy not matching with the cost center statement type

created : 09/25/2013 SH CCN Project
revisions: 

************************************************************/
en_invalid_stmnt_type_err CONSTANT NUMBER := -20512;
exc_invalid_stmnt_type_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_stmnt_type_err , -20512);

/*********************************************************** 
The "previous_level_missing_err" passes a numerical error of -20513.
This error will state an error that,the previous level is missing in
the hierarchy

created : 09/30/2013 SH CCN Project
revisions: 

************************************************************/
en_previous_level_missing_err  CONSTANT NUMBER := -20513;
exc_previous_level_missing_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_previous_level_missing_err , -20513);

/*********************************************************** 
The "incomplete_cc_err" passes a numerical error of -20514.
This error will state an error that,the cost center is not complete
as it is not associated with all Global, Legacy and Fact hierarchies

created : 09/30/2013 SH CCN Project
revisions: 

************************************************************/
en_incomplete_cc_err  CONSTANT NUMBER := -20514;
exc_incomplete_cc_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_incomplete_cc_err , -20514);

/*********************************************************** 
The "en_hierarachy_not_exists" passes a numerical error of -20515.
This error will state an error that a hierarchy is broken at particular level

created : 11/14/2013 JXC517 CCN Project
revisions: 

************************************************************/
en_hierarachy_not_exists  CONSTANT NUMBER := -20515;
exc_hierarachy_not_exists EXCEPTION;
PRAGMA EXCEPTION_INIT
(EXC_HIERARACHY_NOT_EXISTS , -20515);

/*********************************************************** 
The "en_code_detail_err" passes a numerical error of -20516.
This error will state an error that a code detail value for cost center prefix and cost center type mismatch

created : 12/19/2013 NXK CCN Project
revisions: 

************************************************************/
en_code_detail_err  CONSTANT NUMBER := -20516;
exc_code_detail_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(EXC_CODE_DETAIL_ERR , -20516);


/*********************************************************** 
The "EN_DIVISION_ERR" passes a numerical error of -20517.
This error will state an error that the division can not allowed for the code detail
value for cost center prefix and cost center type 

created : 12/19/2013 NXK CCN Project
revisions: 

************************************************************/
EN_DIVISION_ERR  CONSTANT NUMBER := -20517;
EXC_DIVISION_ERR EXCEPTION;
PRAGMA EXCEPTION_INIT
(EXC_DIVISION_ERR , -20517);

/*********************************************************** 
The "EN_DIVISION_ERR" passes a numerical error of -20518.
This error will state a soft error has occured while processing transfer process

created : 02/10/2014 jxc517 CCN Project
revisions: 

************************************************************/
EN_TRANSFER_ERR  CONSTANT NUMBER := -20518;
EXC_TRANSFER_ERR EXCEPTION;
PRAGMA EXCEPTION_INIT
(EXC_TRANSFER_ERR , -20518);

/*********************************************************** 
The "CURR_LVL_VAL_NOT_EXISTS" passes a numerical error of -20519.
This error states that the current level value doesn't exists in
hierarchy_detail table to transfer from

created : 02/10/2014 jxc517 CCN Project
revisions: 

************************************************************/
EN_CURR_LVL_VAL_NOT_EXISTS  CONSTANT NUMBER := -20519;
EXC_CURR_LVL_VAL_NOT_EXISTS EXCEPTION;
PRAGMA EXCEPTION_INIT
(EXC_CURR_LVL_VAL_NOT_EXISTS , -20519);

/*********************************************************** 
The "BELOW_LEVELS_NOT_EXPIRED" passes a numerical error of -20520.
This error states that the current level can not be expired as lower/below levels
are not expired yet

created : 03/12/2014 jxc517 CCN Project
revisions: 

************************************************************/
EN_BELOW_LEVELS_NOT_EXPIRED  CONSTANT NUMBER := -20520;
EXC_BELOW_LEVELS_NOT_EXPIRED EXCEPTION;
PRAGMA EXCEPTION_INIT
(EXC_BELOW_LEVELS_NOT_EXPIRED , -20520);

/*********************************************************** 
The invalid_last_lvl passes a numerical error of -20521.
This error states that the last level in the hierarchy is not cost center

created : 03/19/2014 SXH487 CCN Project
revisions: 

************************************************************/
en_invalid_last_lvl  CONSTANT NUMBER := -20521;
exc_invalid_last_lvl EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_last_lvl , -20521);

/*********************************************************** 
The invalid_last_lvl passes a numerical error of -20522.
This error states that the division for the GL DIVISION
passed does not match with the div in GLOBAL hierarchy

created : 03/20/2014 SXH487 CCN Project
revisions: 

************************************************************/
en_invalid_GL_div  CONSTANT NUMBER := -20522;
exc_invalid_GL_div EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_GL_div , -20522);

/*********************************************************** 
The invalid_hist_rec passes a numerical error of -20523.
This error states that the record passed doesn't match
the record in the respective table

created : 04/17/2014 NXK CCN Project


************************************************************/
en_invalid_hist_rec  CONSTANT NUMBER := -20523;
exc_invalid_hist_rec EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_hist_rec , -20523);

/*********************************************************** 
The lvl_val_size_err passes a numerical error of -20524.
This error states that the size of the value passed for
particular level doesn't match with that of reference data

created : 06/18/2014 jxc517 CCN Project
revisions: 

************************************************************/
en_lvl_val_size_err  CONSTANT NUMBER := -20524;
exc_lvl_val_size_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_lvl_val_size_err , -20524);

/*********************************************************** 
The "invalid_pri_logo_group" passes a numerical error of -20525.
This error will state that thepri_logo_group should be entered.

created : 09/12/2014 nxk CCN Project
revisions: 

************************************************************/
en_invalid_pri_logo_group CONSTANT NUMBER := -20525;
exc_invalid_pri_logo_group EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_pri_logo_group , -20525);

/*********************************************************** 
The "cc_sales_manager_lvl_err" passes a numerical error of -20526.
This error will state that cost center attached to sales manager hierarchy is not valid.

created : 09/18/2014 jxc517 CCN Project....
revisions: 

************************************************************/
en_cc_sales_manager_lvl_err CONSTANT NUMBER := -20526;
exc_cc_sales_manager_lvl_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_cc_sales_manager_lvl_err , -20526);

/*********************************************************** 
The "sales_manager_lvl_err" passes a numerical error of -20527.
This error will state that level code for sales manager hierarchy is not valid.

created : 09/18/2014 jxc517 CCN Project....
revisions: 

************************************************************/
en_sales_manager_lvl_err CONSTANT NUMBER := -20527;
exc_sales_manager_lvl_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_sales_manager_lvl_err , -20527);

/*********************************************************** 
The "invalid_pci_id_err" passes a numerical error of -20529.
This error will state that the PCI_MERCHANT_ID and 
PCI_DISCOVER_ID should not be null when the polling status is 'P'

created : 03/02/2016 nxk927 CCN Project
revisions: 

************************************************************/
en_invalid_pci_id_err CONSTANT NUMBER := -20529;
exc_invalid_pci_id_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_pci_id_err , -20529);

/*********************************************************** 
The "pci_terminal_id_err" passes a numerical error of -20530.
This error will state that the PCI_TERMINAL_ID is null

created : 03/02/2016 nxk927 CCN Project
revisions: 03/15/2016 nxk927 CCN Project

************************************************************/
en_pci_terminal_id_err CONSTANT NUMBER := -20530;
exc_pci_terminal_id_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_pci_terminal_id_err , -20530);

/*********************************************************** 
The "hrchy_cc_ftr_exists_err" passes a numerical error of -20531
This error will state that the cost center being modifed
has a future already in place

Created  : 04/04/2016 jxc517 CCN Project Team....
Modified : 
************************************************************/
en_hrchy_cc_ftr_exists_err CONSTANT NUMBER := -20531;
exc_hrchy_cc_ftr_exists_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_hrchy_cc_ftr_exists_err , -20531);

/*********************************************************** 
The "hrchy_ftr_not_allowed_err" passes a numerical error of -20532
This error will state that the hierarchy does not support future transactions

Created  : 04/07/2016 jxc517 CCN Project Team....
Modified : 
************************************************************/
en_hrchy_ftr_not_allowed_err CONSTANT NUMBER := -20532;
exc_hrchy_ftr_not_allowed_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_hrchy_ftr_not_allowed_err , -20532);

/*********************************************************** 
The "invalid_dscvr_id_size_err" passes a numerical error of -20533
This error will state that Bank Card Discover ID Size is wrong

Created  : 04/11/2016 jxc517 CCN Project Team....
Modified : 
************************************************************/
en_invalid_dscvr_id_size_err CONSTANT NUMBER := -20533;
exc_invalid_dscvr_id_size_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_dscvr_id_size_err , -20533);

/*********************************************************** 
The "invld_pci_dscvr_id_size_err" passes a numerical error of -20534
This error will state that Bank Card PCI Discover ID Size is wrong

Created  : 04/11/2016 jxc517 CCN Project Team....
Modified : 
************************************************************/
en_invld_pci_dscvr_id_size_err CONSTANT NUMBER := -20534;
exc_invld_pci_dscvr_id_size_er EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invld_pci_dscvr_id_size_er , -20534);

/*********************************************************** 
The "invalid_mrchnt_id_size_err" passes a numerical error of -20535
This error will state that Bank Card Merchant ID Size is wrong

Created  : 04/11/2016 jxc517 CCN Project Team....
Modified : 
************************************************************/
en_invalid_mrchnt_id_size_err CONSTANT NUMBER := -20535;
exc_invalid_mrchnt_id_size_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_mrchnt_id_size_err , -20535);

/*********************************************************** 
The "invld_pci_mrchnt_id_sz_err" passes a numerical error of -20536
This error will state that Bank Card PCI Merchant ID Size is wrong

Created  : 04/11/2016 jxc517 CCN Project Team....
Modified : 
************************************************************/
en_invld_pci_mrchnt_id_sz_err CONSTANT NUMBER := -20536;
exc_invld_pci_mrchnt_id_sz_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invld_pci_mrchnt_id_sz_err , -20536);

/*********************************************************** 
The "invld_ftr_adr_efctv_dt_err" passes a numerical error of -20537
This error will state that the future address is having effective date 
less than or equal to current date

Created  : 04/20/2016 jxc517 CCN Project Team....
Modified : 
************************************************************/
en_invld_ftr_adr_efctv_dt_err CONSTANT NUMBER := -20537;
exc_invld_ftr_adr_efctv_dt_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invld_ftr_adr_efctv_dt_err , -20537);

/*********************************************************** 
The "en_unkown_error" passes a numerical error of -20999.
If the error passed was outside the scope of numeric error
definitions, then we denote it as an unknown error, this says
a numerical error should be defined within this package

created : 12/08/2011 blr CCN project
revisions: 

************************************************************/
en_unkown_error CONSTANT NUMBER := -20999;
exc_unkown_error EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_unkown_error , -20999);

max_error_used CONSTANT NUMBER := -20999;

/*********************************************************** 
The "en_cc_strd_primry_price_err" passes a numerical error of -20545.
The en_cc_strd_primry_price_err execption is generataed by our Business Rules process
if the standard price or primary price is null for non canada countries then
throw a warning. 
created : 08/17/2016 MXK766 CCN Project Team....
revisions:
************************************************************/
en_cc_strd_primry_price_err CONSTANT NUMBER := -20545;
exc_cc_strd_primry_price_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_cc_strd_primry_price_err , -20545);

/*********************************************************** 
The "en_invld_dco_costcntr_err" passes a numerical error of -20546
This error will state that the passed DCO cost center code does not 
exist in the database.

Created  : 08/23/2016 vxv336 CCN Project Team....
Modified : 
************************************************************/
en_invld_dco_costcntr_err CONSTANT NUMBER := -20546;
exc_invld_dco_costcntr_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invld_dco_costcntr_err , -20546);

/*********************************************************** 
The "en_cn_ac_prmry_stndrd_cc_ind" passes a numerical error of -20167
This error will state that std_cost_identifier and prim_cost_identifier 
can only be "08" for statement types CN/AC

Created  : 09/19/2016 jxc517 CCN Project Team....
Modified : 
************************************************************/
en_cn_ac_prmry_stndrd_cc_ind CONSTANT NUMBER := -20167;
exc_cn_ac_prmry_stndrd_cc_ind EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_cn_ac_prmry_stndrd_cc_ind , -20167);

/*********************************************************** 
The "en_non_cn_ac_prmry_std_cc_ind" passes a numerical error of -20168
This error will state that std_cost_identifier and prim_cost_identifier 
can not be "08" for statement types other than CN/AC

Created  : 09/19/2016 jxc517 CCN Project Team....
Modified : 
************************************************************/
en_non_cn_ac_prmry_std_cc_ind CONSTANT NUMBER := -20168;
exc_non_cn_ac_prmry_std_cc_ind EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_non_cn_ac_prmry_std_cc_ind , -20168);

/*********************************************************** 
The "en_prcr_actv_in_group" passes a numerical error of -20169
This error will state that a processor is active for a group and 
can not be deleted

Created  : 10/19/2016 jxc517 CCN Project Team....
Modified : 
************************************************************/
en_prcr_actv_in_group CONSTANT NUMBER := -20169;
exc_prcr_actv_in_group EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_prcr_actv_in_group , -20169);

END ERRNUMS;