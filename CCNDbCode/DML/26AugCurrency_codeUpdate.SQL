--updating the currency code for all territory cost centers to match the home store's currency code for the territory
SET DEFINE OFF;
select cost_center_code,currency_code, cur_code
from(
select cc.cost_center_code,
       cc.currency_code,
       (select currency_code
         from cost_center cc1,
              territory t
        where cc.cost_center_code = t.cost_center_code
          and t.HOME_STORE = cc1.cost_center_code
          and t.HOME_STORE is not null) cur_code
  from cost_center cc
 where cc.category = 'T')
 where cur_code is not null
   and nvl(currency_code, 'XX') <> nvl(cur_code, 'YY');
  
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

