/**************************************************
Created : sxh487 08/23/2017
          Inserting the missing TCODE and REFEED_TCODE in 
          REFEED_LOOKUP_TB
****************************************************/
select * from REFEED_LOOKUP_TB where TCODE in('2656','2856','2895','2899','2999');

INSERT INTO REFEED_LOOKUP_TB VALUES('2656','3656');
INSERT INTO REFEED_LOOKUP_TB VALUES('2856','3856');
INSERT INTO REFEED_LOOKUP_TB VALUES('2895','3895');
INSERT INTO REFEED_LOOKUP_TB VALUES('2899','3899');
INSERT INTO REFEED_LOOKUP_TB VALUES('2999','3999');

COMMIT;
