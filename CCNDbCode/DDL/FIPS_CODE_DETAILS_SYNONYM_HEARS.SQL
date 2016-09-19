/*
Created : 09/07/2016 jxc517 CCN Project Team....
          Below synonym is to avoid multiple codes in each environment based on the table names over links
          The script executed will be based on the environment we are going to compile the code in
*/
--Development
CREATE OR REPLACE SYNONYM FIPS_CODE_DETAILS FOR EHRS.V_AOM_PL_FIPS@HEARS_DEV;

--Test
CREATE OR REPLACE SYNONYM FIPS_CODE_DETAILS FOR EHRS.V_AOM_PL_FIPS@HEARS_TEST;

--QA
CREATE OR REPLACE SYNONYM FIPS_CODE_DETAILS FOR EHRS.V_AOM_PL_FIPS@HEARS_QA;

--Production
CREATE OR REPLACE SYNONYM FIPS_CODE_DETAILS FOR EHRS.V_AOM_PL_FIPS@HEARS_PROD;
