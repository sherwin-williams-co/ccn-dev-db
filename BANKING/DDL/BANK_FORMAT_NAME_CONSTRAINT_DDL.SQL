/*********************************************************** 
This DDL will create constraints on banking format name to
1. Allow only 6 characters for format name (no less, no more)
2. Allow only alpha numeric characters(spaces and special characters are considered invalid)

Created : 10/5/2015 jcx517 CCN project....
Changed :
************************************************************/
ALTER TABLE BANK_MICR_FORMAT ADD CONSTRAINT micr_format_name_check CHECK(regexp_like(FORMAT_NAME,'^[[:alnum:]]{6}$')) ENABLE;
ALTER TABLE BANK_MICR_FORMAT_FUTURE ADD CONSTRAINT micr_format_name_check_ftr CHECK(regexp_like(FORMAT_NAME,'^[[:alnum:]]{6}$')) ENABLE;
ALTER TABLE BANK_MICR_FORMAT_HIST ADD CONSTRAINT micr_format_name_check_hist CHECK(regexp_like(FORMAT_NAME,'^[[:alnum:]]{6}$')) ENABLE;
