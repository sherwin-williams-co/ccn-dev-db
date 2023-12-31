/*
created : 08/11/2017 nxk927
          Change the date for which we need to delete the data.
*/
DECLARE
IN_DATE DATE := IN_DATE;
BEGIN
DELETE FROM ACH_DRFTS_EXT_CTRL WHERE LOAD_DATE = IN_DATE;
DELETE FROM UAR_ACH_DRFTS_EXT_CTRL WHERE LOAD_DATE = IN_DATE;
DELETE FROM SUMMARY_EXTRCT_CNTRL_FL WHERE LOAD_DATE = IN_DATE;
DELETE FROM UAR_SUMMARY_EXTRCT_CNTRL_FL WHERE LOAD_DATE = IN_DATE;
DELETE FROM MISCTRAN WHERE LOAD_DATE = IN_DATE;
DELETE FROM UAR_MISCTRAN WHERE LOAD_DATE = IN_DATE;
COMMIT;
END;