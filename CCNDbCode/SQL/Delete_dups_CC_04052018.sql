/*
  Created: 04/05/2018 nxk927 
           Deleting cost centers '7AB072','7CU088','7AU149','7AU263','80V120','7AU087','7AU148','776531','76Q364','76Q414','76Q513','76Q546'

  SELECT COST_CENTER_CODE 
    FROM COST_CENTER
   WHERE COST_CENTER_CODE IN ('7AB072','7CU088','7AU149','7AU263','80V120','7AU087','7AU148','776531','76Q364','76Q414','76Q513','76Q546');

   SELECT * FROM AUDIT_LOG WHERE SUBSTR(TRANSACTION_ID,2,6) IN ('7AB072','7CU088','7AU149','7AU263','80V120','7AU087','7AU148','776531','76Q364','76Q414','76Q513','76Q546');

*/


DECLARE
CURSOR CUR IS
  SELECT COST_CENTER_CODE 
    FROM COST_CENTER
   WHERE COST_CENTER_CODE IN ('7AB072','7CU088','7AU149','7AU263','80V120','7AU087','7AU148','776531','76Q364','76Q414','76Q513','76Q546');

BEGIN
  FOR REC IN CUR LOOP
    CCN_UI_INTERFACE_APP_PKG.DELETE_COST_CENTER(REC.COST_CENTER_CODE);
  END LOOP;
END;

COMMIT;