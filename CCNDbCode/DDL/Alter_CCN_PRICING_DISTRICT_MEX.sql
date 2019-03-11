/*******************************************************************************
Alter table script to alter the size of store_address_province field in CCN_PRICING_DISTRICT_MEX table
CREATED : 03/11/2019 pxa852 CCN Project Team...
*******************************************************************************/

ALTER TABLE CCN_PRICING_DISTRICT_MEX MODIFY STORE_ADDRESS_PROVINCE VARCHAR2(5);