--updating the currency code for all territory cost centers to match the home store's currency code for the territory
SET DEFINE OFF;
SELECT CC.COST_CENTER_CODE,
       CC.CURRENCY_CODE,
       (SELECT CURRENCY_CODE
         FROM COST_CENTER CC1,
              TERRITORY T
        WHERE CC.COST_CENTER_CODE = T.COST_CENTER_CODE
          AND T.HOME_STORE        = CC1.COST_CENTER_CODE
          AND T.HOME_STORE IS NOT NULL) CUR_CODE
--SELECT COUNT(*)
  FROM COST_CENTER CC
 WHERE CC.CATEGORY = 'T'
   AND NVL(CC.CURRENCY_CODE,'YYY') <> (SELECT NVL(CURRENCY_CODE,'XXX')
                                         FROM COST_CENTER CC1,
                                              TERRITORY T
                                        WHERE CC.COST_CENTER_CODE = T.COST_CENTER_CODE
                                          AND T.HOME_STORE        = CC1.COST_CENTER_CODE
                                          AND T.HOME_STORE IS NOT NULL);

 UPDATE COST_CENTER CC
    SET CURRENCY_CODE = (SELECT CURRENCY_CODE
                           FROM COST_CENTER CC1,
                                TERRITORY T
                          WHERE CC.COST_CENTER_CODE = T.COST_CENTER_CODE
                            AND T.HOME_STORE        = CC1.COST_CENTER_CODE
                            AND T.HOME_STORE IS NOT NULL)
  WHERE CC.CATEGORY = 'T'
    AND NVL(CC.CURRENCY_CODE,'YYY') <> (SELECT NVL(CURRENCY_CODE,'XXX')
                                          FROM COST_CENTER CC1,
                                               TERRITORY T
                                         WHERE CC.COST_CENTER_CODE = T.COST_CENTER_CODE
                                           AND T.HOME_STORE        = CC1.COST_CENTER_CODE
                                          AND T.HOME_STORE IS NOT NULL);
   COMMIT;
   

