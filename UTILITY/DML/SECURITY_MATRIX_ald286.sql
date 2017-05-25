-- Created : pxb712 05/25/2017
-- Purpose : This is to give access to Abbey Dorn('ald286') in replacement of User Toni Thomey('axt720'). 
--           Tony Thomey had access in below role codes..
--			 CCNU1:	  CCN Territory User
--			 CCNUS2:  CCN User - Employee Window Select
--			 HWU1:	  Hierarchy Window Territory User

INSERT INTO SECURITY_MATRIX values ('ald286','ald286','CCNU1');
INSERT INTO SECURITY_MATRIX values ('ald286','ald286','HWU1');
INSERT INTO SECURITY_MATRIX values ('ald286','ald286','CCNUS2');

DELETE FROM SECURITY_MATRIX WHERE UPPER(USER_ID) = UPPER('axt720');

COMMIT;