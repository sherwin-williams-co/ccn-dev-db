/*
Below script will expire the current Aruba taxes and activate new taxes with 0 as their values

Based on discussion with Ellen, even though the data is passed to polling 2.0 it will be used by their batch only at 1 AM the next day

So we will be performing the updates and triggering the non taxware downloads to below stores on 30-Nov-2019 with 
current records expiration date as 30-Nov-2019 and new records expiration date as 01-Dec-2019
702886	ARUBA-ORANJESTAD
702836	ARUBA-NOORD
*/
SELECT * FROM NON_TAXWARE_RATES WHERE COUNTRY_CODE = 'ABW' ORDER BY TAX_TYPE, TAX_RATE;
UPDATE NON_TAXWARE_RATES SET EXPIRATION_DATE = '30-NOV-2019' WHERE COUNTRY_CODE = 'ABW' AND EXPIRATION_DATE IS NULL;
INSERT INTO NON_TAXWARE_RATES VALUES ('ABW','AW','Health Care','H','0','HEALTH TAX',NULL,'01-DEC-2019',NULL,'pmm4br');
INSERT INTO NON_TAXWARE_RATES VALUES ('ABW','AW','VAT','70001','0','0.000%',NULL,'01-DEC-2019',NULL,'pmm4br');
SELECT * FROM NON_TAXWARE_RATES WHERE COUNTRY_CODE = 'ABW' ORDER BY TAX_TYPE, TAX_RATE;
COMMIT;

EXEC POS_DATA_GENERATION_NON_TAXWAR.POS_TRG_EVENT_LOG('ABW', 'NON_TAXWARE_RATES', 'CHANGE', 'POS_NON_TXWR_RT_UPDATE', NULL);
COMMIT;
