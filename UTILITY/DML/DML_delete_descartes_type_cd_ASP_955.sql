/******************************************************************************************************************* 
Below script is created to delete Descartes category type data from  TRANSLATION_DETAIL and TRANSLATION_HEADER table.
Created : 01/11/2018 sxp130 CCN Project ASP-955....
********************************************************************************************************************/

DELETE FROM TRANSLATION_DETAIL WHERE HEADER_NAME = 'DSCRTS_CTGRY_TYP_CD';
DELETE FROM TRANSLATION_HEADER WHERE HEADER_NAME = 'DSCRTS_CTGRY_TYP_CD';

commit;