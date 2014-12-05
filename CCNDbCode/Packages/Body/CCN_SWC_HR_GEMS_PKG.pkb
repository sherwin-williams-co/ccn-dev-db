create or replace PACKAGE BODY CCN_SWC_HR_GEMS_PKG
/*********************************************************** 
This package has procedures to load the fieldpayroll table
SWC_HR_GENERIC_TB from the view SWC_HR_GENERIC_V

created : 12/05/2014 SXH487 
revisions: 

************************************************************/
AS

PROCEDURE SWC_HR_GENERIC_VIEW_INFO_SP
/**********************************************************
SWC_HR_GENERIC_VIEW_INFO 
   This procedure is for truncating the SWC_HR_GEMS_TB 
   table and pull the updated data from the SWC_HR_GENERIC_VIEW_INFO
   created : 12/04/2014  SXH487
**********************************************************/

is

SQ NUMBER;
SE VARCHAR2(500);
V_COUNT     INTEGER := 0 ;

cursor SWC_HR_GEMS_INFO_cur is 
SELECT *
FROM SWC_HR_GENERIC_V;

BEGIN
--Truncating the SWC_HR_GEMS_TB table before inserting any data
EXECUTE IMMEDIATE 'TRUNCATE TABLE SWC_HR_GEMS_TB';

    FOR SWC_HR_GEMS_INFO_rec IN SWC_HR_GEMS_INFO_cur LOOP
        BEGIN
            INSERT INTO SWC_HR_GEMS_TB VALUES SWC_HR_GEMS_INFO_rec;
            
        EXCEPTION
            WHEN OTHERS THEN
                SQ := SQLCODE;
                SE := SQLERRM;
                DBMS_OUTPUT.PUT_LINE('FAILED SWC_HR_GEMS_TB ' || ' ' || SQ || ' ' || SE);
        END;
        IF V_COUNT > 100 THEN
            COMMIT; 
            V_COUNT := 0;
        END IF; 
        V_COUNT := V_COUNT + 1;
    END LOOP;
    
    COMMIT;
END SWC_HR_GENERIC_VIEW_INFO_SP;

END CCN_SWC_HR_GEMS_PKG;