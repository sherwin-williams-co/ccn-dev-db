/***************************************************************************************************
Description : This file has commands to create synonyms for tables that are present on PNP schema
              and required to be accessed on Banking schema
Created  : 05/10/2017 gxg192 CCN Project Team.....
Modified :
****************************************************************************************************/

CREATE OR REPLACE SYNONYM PNP_CCN_LOAD_STATUS FOR PNP.CCN_LOAD_STATUS;

CREATE OR REPLACE SYNONYM PNP_CCN_ACCUMS FOR PNP.CCN_ACCUMS;

CREATE OR REPLACE SYNONYM PNP_CCN_GIFT_CARD_LOG FOR PNP.CCN_GIFT_CARD_LOG;

CREATE OR REPLACE SYNONYM PNP_CCN_BATCH_SUMMARY FOR PNP.CCN_BATCH_SUMMARY;
   
CREATE OR REPLACE SYNONYM PNP_CCN_HEADERS FOR PNP.CCN_HEADERS;