CREATE OR REPLACE VIEW MEMBER_BANK_CONCENT_CC_VW AS
SELECT 
/*******************************************************************************
Created  : 10/31/2015 SXG151 CCN
*******************************************************************************/
*
FROM MEMBER_BANK_CONCENTRATION_CC
WHERE LOAD_DATE in (SELECT MAX(LOAD_DATE) FROM MEMBER_BANK_CONCENTRATION_CC);