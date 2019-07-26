/*
CCNCC-18 This script to add index on POS_CUSTOMER tables.

Created : 07/11/2019 sxs484 CCN Project Team....
Changed :
*/


create index DLY_POS_CUSTOMER_IDX on DLY_POS_CUSTOMER ( cost_center_code) ;
create index DLY_POS_CUSTOMER_DETAILS_IDX on DLY_POS_CUSTOMER_DETAILS ( cost_center_code) ;
create index DLY_POS_CSTMR_SALES_TAX_IDX on DLY_POS_CSTMR_SALES_TAX ( cost_center_code) ;
create index DLY_POS_CSTMR_FORM_OF_PAY_IDX on DLY_POS_CSTMR_FORM_OF_PAY ( cost_center_code) ;
