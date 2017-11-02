CREATE OR REPLACE VIEW MEMBER_BANK_CONCENT_CC_VW AS
SELECT 
/*******************************************************************************
Created  : 10/31/2015 SXG151 CCN
*******************************************************************************/
*
From Member_Bank_Concentration_Cc
WHERE LOAD_DATE = (SELECT MAX(LOAD_DATE) FROM MEMBER_BANK_CONCENTRATION_CC);