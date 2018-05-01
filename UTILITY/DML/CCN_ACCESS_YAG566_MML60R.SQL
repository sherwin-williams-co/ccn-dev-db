/*
  Created : nxk927 05/01/2018
            CCN and polling window access to Yvonne Gant, User ID YAG566 and Margaret Lewis, User ID MML60R
            
            SELECT * FROM SECURITY_MATRIX WHERE USER_ID IN ('yag566','mml60r');
*/
INSERT INTO SECURITY_MATRIX values ('yag566','yag566','CCNUS1');
INSERT INTO SECURITY_MATRIX values ('yag566','yag566','HWGUS');

INSERT INTO SECURITY_MATRIX values ('mml60r','mml60r','CCNUS1');
INSERT INTO SECURITY_MATRIX values ('mml60r','mml60r','HWGUS');

COMMIT;
