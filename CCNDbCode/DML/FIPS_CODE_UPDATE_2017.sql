/******************************************************************************
Below scripts is to update the ADDRESS_USA table that had a NULL FIPS_CODE
created : 09/21/2017 jxc517 CCN Project Team....
modified: 
*******************************************************************************/
SET SERVEROUTPUT ON;
BEGIN
   FOR each_rec IN (select * from ADDRESS_USA where FIPS_CODE IS NULL AND EXPIRATION_DATE IS NULL order by COST_CENTER_CODE) 
   LOOP
     UPDATE ADDRESS_USA
        SET FIPS_CODE = COMMON_TOOLS.GET_FIPS_CODE(each_rec.STATE_CODE, each_rec.COUNTY,each_rec.CITY, each_rec.ZIP_CODE)
       WHERE COST_CENTER_CODE = each_rec.COST_CENTER_CODE
         AND EXPIRATION_DATE IS NULL;
   END LOOP;
   COMMIT;
EXCEPTION
    WHEN OTHERS THEN
      dbms_output.put_line('In main exception ');
END;
/