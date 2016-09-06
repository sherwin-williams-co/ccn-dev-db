/********************************************************************************
Below script will delete from CODE_DETAIL and CODE_HEADER

Created : 09/06/2016 vxv336 CCN Project Team
Modified: 
********************************************************************************/

DELETE FROM CODE_DETAIL WHERE CODE_HEADER_NAME IN ('DCM', 'ACM', 'RCM');
DBMS_OUTPUT.PUT_LINE('CODE_DETAIL - DCM, ACM, RCM : '|| SQL%ROWCOUNT || ' Row(s) deleted ' );

DELETE FROM CODE_HEADER WHERE CODE_HEADER_NAME IN ('DCM', 'ACM', 'RCM');
DBMS_OUTPUT.PUT_LINE('CODE_HEADER - DCM, ACM, RCM : '|| SQL%ROWCOUNT || ' Row(s) deleted ' );

