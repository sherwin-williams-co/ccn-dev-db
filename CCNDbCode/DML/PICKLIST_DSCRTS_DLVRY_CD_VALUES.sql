

  ********************************************************************************** 
This script is used to create picklist values for descartes delivery code field in ccn.

Created : 08/09/2018 pxa852 CCN Project ASP-1109....
Modified: 
**********************************************************************************/

SET DEFINE OFF;

--inserting header record into code_header table

INSERT INTO CODE_HEADER VALUES ('DESCARTES_DELIVERY_CODE','COD','DESCARTES DELIVERY CODES','N',NULL, NULL,1 ,NULL, 'kdp465',TRUNC(SYSDATE),NULL );

--inserting descartes delivery code lookup values into code_detail table

INSERT INTO CODE_DETAIL VALUES ('DESCARTES_DELIVERY_CODE','COD','G', 'GOLD', NULL, NULL, NULL,1, 'kdp465',TRUNC(SYSDATE));

INSERT INTO CODE_DETAIL VALUES ('DESCARTES_DELIVERY_CODE','COD','S', 'SILVER', NULL, NULL, NULL,2, 'kdp465',TRUNC(SYSDATE));

INSERT INTO CODE_DETAIL VALUES ('DESCARTES_DELIVERY_CODE','COD','B', 'BRONZE', NULL, NULL, NULL,3, 'kdp465',TRUNC(SYSDATE));

commit;
