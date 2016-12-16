/*
created : 12/15/2016 jxc517 CCN Project Team....
          Below script is to 
          1) give Diana Gomez with same roles as Cindy
          2) give Cindy and Jerri SELECT access on cost center tab
          

SELECT SM.*, (SELECT ROLE_DESCRIPTION FROM ROLE_DETAILS WHERE ROLE_CODE = SM.ROLE_CODE) ROLE_DESC
  FROM SECURITY_MATRIX SM
 WHERE LOWER(USER_ID) IN ('gxm577','cmaarr','jep01r','dlgarr')
 ORDER BY 1,2,3;

gxm577 : Gretchen Moorhead
    CCN Credit Hierarchy Picklist User Select
    Hierarchy Window User -  Credit Hierarchy Select
    CCN User - Main Window Select for Credit User
cmaarr : Cindy M Appell
    CCN Credit Hierarchy Picklist User Select
    Hierarchy Window Credit Hierarchy User
    ADD > CCN User - Main Window Select for Credit User
jep01r : Jarrett E Krizan (Jerri)
    CCN Credit Hierarchy Picklist User Select
    Hierarchy Window Credit Hierarchy User
    ADD > CCN User - Main Window Select for Credit User
dlgarr : Diana L Gomez
    ADD > CCN Credit Hierarchy Picklist User Select
    ADD > CCN User - Main Window Select for Credit User
    ADD > Hierarchy Window Credit Hierarchy User
*/
INSERT INTO SECURITY_MATRIX VALUES ('dlgarr','dlgarr','CCNPUS');
INSERT INTO SECURITY_MATRIX VALUES ('dlgarr','dlgarr','CCNUS3');
INSERT INTO SECURITY_MATRIX VALUES ('dlgarr','dlgarr','HWCU');

INSERT INTO SECURITY_MATRIX VALUES ('cmaarr','cmaarr','CCNUS3');
INSERT INTO SECURITY_MATRIX VALUES ('jep01r','jep01r','CCNUS3');

COMMIT;
