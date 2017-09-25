/**************************************************
Created : nxk927 09/25/2017
          Inserting the missing data in REFEED_LOOKUP_TB
****************************************************/
select * from REFEED_LOOKUP_TB where TCODE in('2898');
INSERT INTO REFEED_LOOKUP_TB VALUES('2898','3898');
COMMIT;