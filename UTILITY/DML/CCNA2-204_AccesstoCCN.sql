/*
Below script will provide Vince Tromba same access on CCN as Bill Hinkel

Created : 10/29/2019 jxc517 CCN Project Team...
Changed :
*/
SELECT */*insert*/ FROM SECURITY_MATRIX WHERE LOWER(USER_ID) = 'wdh255';

INSERT INTO SECURITY_MATRIX (USER_ID,PASSWORD,ROLE_CODE) VALUES ('vjt590','vjt590','CCNUS1');
INSERT INTO SECURITY_MATRIX (USER_ID,PASSWORD,ROLE_CODE) VALUES ('vjt590','vjt590','CCNUS2');
INSERT INTO SECURITY_MATRIX (USER_ID,PASSWORD,ROLE_CODE) VALUES ('vjt590','vjt590','HWUAGS');

COMMIT;