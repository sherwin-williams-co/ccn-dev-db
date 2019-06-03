  /*
  This script creates the table POS_NEW_STORES_VALIDATION_BYPASS
  for any polling 2.0 emergency on demand new store load if the status is 'P'
  Created by sxh487 06/03/2019
*/
  CREATE TABLE POS_NEW_STORES_VALIDATION_BYPASS 
     ( COST_CENTER_CODE     VARCHAR2(6), 
       CREATE_DATE          DATE, 
       CREATED_BY           VARCHAR2(6),
       CREATED_REASON       VARCHAR2(200), 
       PROCESSED_DATE       DATE
   );