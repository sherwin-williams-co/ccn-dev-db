
/********************************************************************************** 
validate the data in banking concentration report for records fetched by below statements in prod.

Created : 11/29/2018 pxa852 CCN Project ASP-1141....
Modified: 
**********************************************************************************/
--below returns lead/independant/member records which are effetive in history after the current record
SELECT *
  FROM LEAD_BANK_CC_HIST H
 WHERE EXISTS (SELECT 1
                 FROM LEAD_BANK_CC
                WHERE EFFECTIVE_DATE < H.EFFECTIVE_DATE
                  AND LEAD_STORE_NBR = H.LEAD_STORE_NBR);

SELECT *
  FROM MEMBER_BANK_CC_HIST H
 WHERE EXISTS (SELECT 1
                 FROM MEMBER_BANK_CC
                WHERE EFFECTIVE_DATE < H.EFFECTIVE_DATE
                  AND MEMBER_STORE_NBR = H.MEMBER_STORE_NBR);
