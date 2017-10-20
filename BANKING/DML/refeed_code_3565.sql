/**************************************************
Created : nxk927 10/20/2017
          Inserting the missing TCODE and REFEED_TCODE in 
          REFEED_LOOKUP_TB
****************************************************/
select * from REFEED_LOOKUP_TB where TCODE = '2565';

INSERT INTO REFEED_LOOKUP_TB VALUES ('2565','3565');

COMMIT;
