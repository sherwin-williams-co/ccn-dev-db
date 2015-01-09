UPDATE COST_CENTER 
set POS_NON_STORE_IND = 'Y'
Where substr(cost_center_code,3) in ('5498','7480','1990','2751','2752','2753','2754','2764','2775','3850','3900','2799','2874','3986','1487','1800','7478','7479');


UPDATE COST_CENTER 
set POS_NON_STORE_IND = 'N'
Where substr(cost_center_code,3) not in ('5498','7480','1990','2751','2752','2753','2754','2764','2775','3850','3900','2799','2874','3986','1487','1800','7478','7479');
