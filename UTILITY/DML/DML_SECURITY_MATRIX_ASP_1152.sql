/*
Below script will grant CCN View access on cost center to Lee and remove for Kaite
Lee Niedenthal:  LXN782 
Katie Pschesang: KMP440

Created :10/25/2018 kxm302 CCN Project Team....
Changed :
*/

DELETE FROM SECURITY_MATRIX WHERE USER_ID='KMP440';

INSERT INTO SECURITY_MATRIX VALUES ('lxn782', 'lxn782', 'CCNUS1');
INSERT INTO SECURITY_MATRIX VALUES ('lxn782', 'lxn782', 'SDU');

COMMIT;