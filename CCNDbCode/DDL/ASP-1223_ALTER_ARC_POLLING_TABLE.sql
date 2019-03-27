/**********************************************************
Script Name- ALTER_ARC_POLLING_TABLE
Description- This SQL Script rename the existing columns effective_date
             and expiration_date in arc_polling table
			 to poll_status_eff_dt and poll_status_exp_dt
Created    - dxp896 03/26/2018
**********************************************************/

ALTER TABLE ARC_POLLING 
  RENAME COLUMN effective_date to poll_status_eff_dt;

ALTER TABLE ARC_POLLING 
  RENAME COLUMN expiration_date to poll_status_exp_dt;





