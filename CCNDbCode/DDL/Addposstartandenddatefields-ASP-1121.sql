/*******************************************************************************
Alter table script to add POS Start date and POS End date to Pricing district tables.

User requested to add POS start and end date fields to Price district hierarchy report.

CREATED : 08/21/2018 pxa852 CCN Project...
*******************************************************************************/

Alter table CCN_PRICING_DISTRICT_USA add (STORE_POS_START_DATE DATE, STORE_POS_END_DATE DATE);

Alter table CCN_PRICING_DISTRICT_CAN add (STORE_POS_START_DATE DATE, STORE_POS_END_DATE DATE);

Alter table CCN_PRICING_DISTRICT_MEX add (STORE_POS_START_DATE DATE, STORE_POS_END_DATE DATE);

Alter table CCN_PRICING_DISTRICT_BRB add (STORE_POS_START_DATE DATE, STORE_POS_END_DATE DATE);

Alter table CCN_PRICING_DISTRICT_OTHER add (STORE_POS_START_DATE DATE, STORE_POS_END_DATE DATE);

commit;