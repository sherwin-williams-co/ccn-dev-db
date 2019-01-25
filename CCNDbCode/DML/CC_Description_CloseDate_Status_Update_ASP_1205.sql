/*
This Script will insert/Update data into STATUS Table and UPDATE COST_CENTER Table based on given COST_CENTER.
Created : sxg151 CCN Team...
        : ASP-1205 Close Date, Status and Description update
*/
SELECT *
  FROM STATUS
 WHERE COST_CENTER_CODE IN ('70C611','70C612','70C613','70C614','7S032V','7S0H15','7S0H19','7S0H21','7S0H22','7S0H23','7S0H27','7S0H28','7S0H29','7S0H31','7S0H33','7S0H42','7S0H45','7S0H47','7S0H48','7S0H51','7S0H52','7S0H53','7S0H55','7S0H56','7S0H57','7S0H58','7S0H59','7S0H61','7S0H62','7S0H64','7S0H65','7S0H66','7S0H71','7S0H72','7S0H75','7S0H76','7S0H77','7S0H79','7S0H81','7S0H82','7S0H83','7VALS0','8SP001','8SP002','8SP003','8SP007','8SP008','8SP995','8SP997','8SPA00','8SPA04','8VALS1','40060V','40130V','40310V','40390V','40620V','40720V','60H28V','60H57V','60H61V','66745V','6SP999','7S0H14','7S0H16','7S0H17','7S0H18','7S0H26','7S0H32','7S0H38','7S0H43','7S0H44','7S0H46','7S0H49','7S0H54','7S0H63','7S0H67','7S0H68','7S0H69','7S0H73','7S0H78','7S700V','7SH770','8SP004','8SP005','8SP992','8SP993','8SP994','8SP996','8SP998','8SPA01','8SPA02','8SPA03','8SPA05')
   AND EXPIRATION_DATE IS NULL;

INSERT INTO STATUS
SELECT COST_CENTER_CODE, '8', '01-JAN-2019', EXPIRATION_DATE
  FROM STATUS
 WHERE COST_CENTER_CODE IN ('70C611','70C612','70C613','70C614','7S032V','7S0H15','7S0H19','7S0H21','7S0H22','7S0H23','7S0H27','7S0H28','7S0H29','7S0H31','7S0H33','7S0H42','7S0H45','7S0H47','7S0H48','7S0H51','7S0H52','7S0H53','7S0H55','7S0H56','7S0H57','7S0H58','7S0H59','7S0H61','7S0H62','7S0H64','7S0H65','7S0H66','7S0H71','7S0H72','7S0H75','7S0H76','7S0H77','7S0H79','7S0H81','7S0H82','7S0H83','7VALS0','8SP001','8SP002','8SP003','8SP007','8SP008','8SP995','8SP997','8SPA00','8SPA04','8VALS1','40060V','40130V','40310V','40390V','40620V','40720V','60H28V','60H57V','60H61V','66745V','6SP999','7S0H14','7S0H16','7S0H17','7S0H18','7S0H26','7S0H32','7S0H38','7S0H43','7S0H44','7S0H46','7S0H49','7S0H54','7S0H63','7S0H67','7S0H68','7S0H69','7S0H73','7S0H78','7S700V','7SH770','8SP004','8SP005','8SP992','8SP993','8SP994','8SP996','8SP998','8SPA01','8SPA02','8SPA03','8SPA05');
--94 Row(s) Inserted

UPDATE STATUS
   SET EXPIRATION_DATE = '31-DEC-2018'
 WHERE COST_CENTER_CODE IN ('70C611','70C612','70C613','70C614','7S032V','7S0H15','7S0H19','7S0H21','7S0H22','7S0H23','7S0H27','7S0H28','7S0H29','7S0H31','7S0H33','7S0H42','7S0H45','7S0H47','7S0H48','7S0H51','7S0H52','7S0H53','7S0H55','7S0H56','7S0H57','7S0H58','7S0H59','7S0H61','7S0H62','7S0H64','7S0H65','7S0H66','7S0H71','7S0H72','7S0H75','7S0H76','7S0H77','7S0H79','7S0H81','7S0H82','7S0H83','7VALS0','8SP001','8SP002','8SP003','8SP007','8SP008','8SP995','8SP997','8SPA00','8SPA04','8VALS1','40060V','40130V','40310V','40390V','40620V','40720V','60H28V','60H57V','60H61V','66745V','6SP999','7S0H14','7S0H16','7S0H17','7S0H18','7S0H26','7S0H32','7S0H38','7S0H43','7S0H44','7S0H46','7S0H49','7S0H54','7S0H63','7S0H67','7S0H68','7S0H69','7S0H73','7S0H78','7S700V','7SH770','8SP004','8SP005','8SP992','8SP993','8SP994','8SP996','8SP998','8SPA01','8SPA02','8SPA03','8SPA05')
   AND EXPIRATION_DATE IS NULL
   AND EFFECTIVE_DATE < '01-JAN-2019';
--94 Row(s) Updated

SELECT *
  FROM COST_CENTER
 WHERE COST_CENTER_CODE IN ('70C611','70C612','70C613','70C614','7S032V','7S0H15','7S0H19','7S0H21','7S0H22','7S0H23','7S0H27','7S0H28','7S0H29','7S0H31','7S0H33','7S0H42','7S0H45','7S0H47','7S0H48','7S0H51','7S0H52','7S0H53','7S0H55','7S0H56','7S0H57','7S0H58','7S0H59','7S0H61','7S0H62','7S0H64','7S0H65','7S0H66','7S0H71','7S0H72','7S0H75','7S0H76','7S0H77','7S0H79','7S0H81','7S0H82','7S0H83','7VALS0','8SP001','8SP002','8SP003','8SP007','8SP008','8SP995','8SP997','8SPA00','8SPA04','8VALS1','40060V','40130V','40310V','40390V','40620V','40720V','60H28V','60H57V','60H61V','66745V','6SP999','7S0H14','7S0H16','7S0H17','7S0H18','7S0H26','7S0H32','7S0H38','7S0H43','7S0H44','7S0H46','7S0H49','7S0H54','7S0H63','7S0H67','7S0H68','7S0H69','7S0H73','7S0H78','7S700V','7SH770','8SP004','8SP005','8SP992','8SP993','8SP994','8SP996','8SP998','8SPA01','8SPA02','8SPA03','8SPA05')
 ORDER BY 1;
--94 Row(s) Selected

SET SERVEROUTPUT ON
DECLARE
    OUT_ID     NUMBER;
BEGIN
    POS_DATA_GENERATION.SET_FLAG_POLLING_BULK_LOADS('MANUAL-ASP-1205', OUT_ID);

UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-MATTESON LATEX',
       POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '40060V';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS - RKFD CLRNT',
       POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '40130V';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS - STATESVILLE',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '40310V';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS - WHEELING',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '40390V';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS - LEBANON',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '40620V';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS - MOLINE',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '40720V';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS - DALLAS R&D',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '60H28V';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS - PHOENIX R&D',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '60H57V';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS - R&D',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '60H61V';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-DEV LAB-FORMLTN',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '66745V';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-TTL PT DROP R&D',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '6SP999';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 VALSPAR SHUTDOWN COSTS-MWD',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '70C611';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 VALSPAR SHUTDOWN COSTS-EAD',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '70C612';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 VALSPAR SHUTDOWN COSTS-SED',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '70C613';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 VALSPAR SHUTDOWN COSTS-SWD',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '70C614';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS - ROMEOVILLE',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S032V';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTNS-CON IMG CNSGN WRH',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H14';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-SAN ANTONIO ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H15';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-ORLANDO ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H16';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-AUSTIN ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H17';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-CHICAGO ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H18';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-LONGWOOD ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H19';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-BRIDGEVIEW ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H21';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-ROMEOVILLE ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H22';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-LAKELAND ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H23';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-TAMPA ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H26';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-LEWISVILLE ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H27';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-DALLAS ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H28';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-PLANO ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H29';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-HOUSTON ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H31';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-WEBSTER ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H32';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-STAFFORD ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H33';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-KATY ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H38';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-RICHLAND HILLS ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H42';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-AUSTIN ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H43';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-FORT MYERS ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H44';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-DAYTONA BEACH ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H45';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-JACKSONVILLE ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H46';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-STUART',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H47';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-WEST PALM BEACH',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H48';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-DORAL',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H49';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-MIRAMAR',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H51';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-FOREST PARK ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H52';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-FORT LAUDERDALE',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H53';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-NORCROSS ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H54';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-LAS VEGAS ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H55';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-ANNAPLS JUNCTN ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H56';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-PHOENIX ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H57';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-ROSEDALE ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H58';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-ALEXANDRIA ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H59';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-ATLANTA ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H61';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-ROSELLE ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H62';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-WHEELING ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H63';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-ARLINGTON ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H64';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-JACKSONVILLE',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H65';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-ROWLETT ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H66';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-HOUSTON ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H67';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-SPRING ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H68';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-LAS VEGAS',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H69';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-SARASOTA',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H71';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-KENNESAW ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H72';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-AUSTIN',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H73';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-MIDDLEBURG',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H75';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-KISSIMMEE',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H76';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-ORLANDO',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H77';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-PHOENIX ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H78';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-TEMPE ',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H79';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-SAN ANTONIO',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H81';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-MIAMI',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H82';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-CLEARWATER',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S0H83';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-TECH-GENERAL',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7S700V';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLTNS-ST PAUL CNTRCT STR',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7SH770';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-SELLING UNDIST',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '7VALS0';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-CHICAGO DISTRCT',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '8SP001';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-HOUSTON DISTRCT',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '8SP002';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-TEXAS N DISTRCT',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '8SP003';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-CENTRAL FL DIST',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '8SP004';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-SE FLORIDA DIST',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '8SP005';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-GEORGIA DISTRCT',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '8SP007';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-S TEXAS DISTRCT',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '8SP008';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-WEST REGION',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '8SP992';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-CENTRAL REGION',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '8SP993';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-SOUTHEAST REGN',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '8SP994';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-TRAING/IMPLMNT',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '8SP995';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS - MARKETING',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '8SP996';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-NATIONAL ACCTS',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '8SP997';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-TOTAL SLS&MKTG',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '8SP998';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-GEN MGMT 1',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '8SPA00';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-GEN MGMT 2',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '8SPA01';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-COMMS DEPT',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '8SPA02';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS - MARKETING',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '8SPA03';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS - SALES ADMIN 1',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '8SPA04';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS - SALES ADMIN 2',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '8SPA05';
--1 Row(s) Updated
UPDATE COST_CENTER
   SET CLOSE_DATE = '01-JAN-2019',
       COST_CENTER_NAME = '01/19 PRO SOLUTIONS-ADMIN UNDISTRBD',
	   POS_NON_STORE_IND = 'Y'
 WHERE COST_CENTER_CODE = '8VALS1';
--1 Row(s) Updated

    POS_DATA_GENERATION.RESET_FLAG_POLLING_BULK_LOADS(OUT_ID);

    COMMIT;
END;
/
SELECT *
  FROM STATUS
 WHERE COST_CENTER_CODE IN ('70C611','70C612','70C613','70C614','7S032V','7S0H15','7S0H19','7S0H21','7S0H22','7S0H23','7S0H27','7S0H28','7S0H29','7S0H31','7S0H33','7S0H42','7S0H45','7S0H47','7S0H48','7S0H51','7S0H52','7S0H53','7S0H55','7S0H56','7S0H57','7S0H58','7S0H59','7S0H61','7S0H62','7S0H64','7S0H65','7S0H66','7S0H71','7S0H72','7S0H75','7S0H76','7S0H77','7S0H79','7S0H81','7S0H82','7S0H83','7VALS0','8SP001','8SP002','8SP003','8SP007','8SP008','8SP995','8SP997','8SPA00','8SPA04','8VALS1','40060V','40130V','40310V','40390V','40620V','40720V','60H28V','60H57V','60H61V','66745V','6SP999','7S0H14','7S0H16','7S0H17','7S0H18','7S0H26','7S0H32','7S0H38','7S0H43','7S0H44','7S0H46','7S0H49','7S0H54','7S0H63','7S0H67','7S0H68','7S0H69','7S0H73','7S0H78','7S700V','7SH770','8SP004','8SP005','8SP992','8SP993','8SP994','8SP996','8SP998','8SPA01','8SPA02','8SPA03','8SPA05')
   AND EXPIRATION_DATE IS NULL;
--94 Row(s) Selected

SELECT COST_CENTER_CODE, COST_CENTER_NAME, CLOSE_DATE
  FROM COST_CENTER
 WHERE COST_CENTER_CODE IN ('70C611','70C612','70C613','70C614','7S032V','7S0H15','7S0H19','7S0H21','7S0H22','7S0H23','7S0H27','7S0H28','7S0H29','7S0H31','7S0H33','7S0H42','7S0H45','7S0H47','7S0H48','7S0H51','7S0H52','7S0H53','7S0H55','7S0H56','7S0H57','7S0H58','7S0H59','7S0H61','7S0H62','7S0H64','7S0H65','7S0H66','7S0H71','7S0H72','7S0H75','7S0H76','7S0H77','7S0H79','7S0H81','7S0H82','7S0H83','7VALS0','8SP001','8SP002','8SP003','8SP007','8SP008','8SP995','8SP997','8SPA00','8SPA04','8VALS1','40060V','40130V','40310V','40390V','40620V','40720V','60H28V','60H57V','60H61V','66745V','6SP999','7S0H14','7S0H16','7S0H17','7S0H18','7S0H26','7S0H32','7S0H38','7S0H43','7S0H44','7S0H46','7S0H49','7S0H54','7S0H63','7S0H67','7S0H68','7S0H69','7S0H73','7S0H78','7S700V','7SH770','8SP004','8SP005','8SP992','8SP993','8SP994','8SP996','8SP998','8SPA01','8SPA02','8SPA03','8SPA05')
 ORDER BY 1;
--94 Row(s) Selected
