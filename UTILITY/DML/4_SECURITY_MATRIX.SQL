SET SCAN OFF;
REM INSERTING into SECURITY_MATRIX
SET DEFINE OFF;
Insert into SECURITY_MATRIX values ('kdp465','kdppswrd','CCNU');
Insert into SECURITY_MATRIX values ('kdp465','kdppswrd','HWA');
Insert into SECURITY_MATRIX values ('kdp465','kdppswrd','SDA');
Insert into SECURITY_MATRIX values ('jxc517','jxc517','CCNU');
Insert into SECURITY_MATRIX values ('jxc517','jxc517','HWD');
Insert into SECURITY_MATRIX values ('jxc517','jxc517','SDD');
Insert into SECURITY_MATRIX values ('sxh487','sxh487','CCNU');
Insert into SECURITY_MATRIX values ('sxh487','sxh487','HWD');
Insert into SECURITY_MATRIX values ('sxh487','sxh487','SDD');
Insert into SECURITY_MATRIX values ('nxk927','nxk927','CCNU');
Insert into SECURITY_MATRIX values ('nxk927','nxk927','HWD');
Insert into SECURITY_MATRIX values ('nxk927','nxk927','SDD');
Insert into SECURITY_MATRIX values ('batusr','readonly','CCNB');
Insert into SECURITY_MATRIX values ('batusr','readonly','HWB');
Insert into SECURITY_MATRIX values ('batusr','readonly','SDB');
Insert into SECURITY_MATRIX values ('sxd392','what','CCNU');
Insert into SECURITY_MATRIX values ('sxd392','what','HWU');
Insert into SECURITY_MATRIX values ('sxd392','what','SDU');
Insert into SECURITY_MATRIX values ('axc415','what','CCNU');
Insert into SECURITY_MATRIX values ('axc415','what','HWU');
Insert into SECURITY_MATRIX values ('axc415','what','SDU');
Insert into SECURITY_MATRIX values ('pxp301','what','CCNU');
Insert into SECURITY_MATRIX values ('pxp301','what','HWU');
Insert into SECURITY_MATRIX values ('pxp301','what','SDU');
Insert into SECURITY_MATRIX values ('cbd33r','cbd','CCNU');
Insert into SECURITY_MATRIX values ('cbd33r','cbd','HWU');
Insert into SECURITY_MATRIX values ('cbd33r','cbd','SDU');
Insert into SECURITY_MATRIX values ('pmm4br','ccnuser1','CCNU');
Insert into SECURITY_MATRIX values ('pmm4br','ccnuser1','HWU');
Insert into SECURITY_MATRIX values ('pmm4br','ccnuser1','SDU');
Insert into SECURITY_MATRIX values ('lxb8vr','ccnuser2','CCNU');
Insert into SECURITY_MATRIX values ('lxb8vr','ccnuser2','HWU');
Insert into SECURITY_MATRIX values ('lxb8vr','ccnuser2','SDU');
Insert into SECURITY_MATRIX values ('axg280','axg280','CCNU');
Insert into SECURITY_MATRIX values ('mdh01r','mdh000','CCNU');
Insert into SECURITY_MATRIX values ('mdh01r','mdh000','CCND');
Insert into SECURITY_MATRIX values ('mdh01r','mdh000','SDD');
Insert into SECURITY_MATRIX values ('axc539','mdh000','CCNU');
Insert into SECURITY_MATRIX values ('sxm690','sxm690','CCND');
Insert into SECURITY_MATRIX values ('sxm690','sxm690','HWD');
Insert into SECURITY_MATRIX values ('sxm690','sxm690','SDD');
Insert into SECURITY_MATRIX values ('axk326','axk326','SDD');
Insert into SECURITY_MATRIX values ('axk326','axk326','HWD');
Insert into SECURITY_MATRIX values ('axk326','axk326','CCNU');
Insert into SECURITY_MATRIX values ('sxt410','sxt410','SDD');
Insert into SECURITY_MATRIX values ('sxt410','sxt410','HWD');
Insert into SECURITY_MATRIX values ('sxt410','sxt410','CCNU');
insert into SECURITY_MATRIX values ('axt720','axt720','CCNU1');
insert into SECURITY_MATRIX values ('ncj812','ncj812','CCNU1');
insert into SECURITY_MATRIX values ('jek74s','jek74s','SDU');
insert into SECURITY_MATRIX values ('txs130','txs130','SDU');
SELECT * FROM SECURITY_MATRIX WHERE USER_ID IN ('jek74s','ltk464','txs130','kmv600');
DELETE FROM SECURITY_MATRIX WHERE USER_ID IN ('jek74s','txs130') AND ROLE_CODE = 'SDU';
INSERT INTO SECURITY_MATRIX VALUES('jek74s','jek74s','SDU1'); --already have CCNUS and SDU access
INSERT INTO SECURITY_MATRIX VALUES('txs130','txs130','SDU1'); --already have CCNUS and SDU access
INSERT INTO SECURITY_MATRIX VALUES('ltk464','ltk464','SDU1');
INSERT INTO SECURITY_MATRIX VALUES('kmv600','kmv600','SDU1');
INSERT INTO SECURITY_MATRIX VALUES('ltk464','ltk464','CCNUS');
INSERT INTO SECURITY_MATRIX VALUES('kmv600','kmv600','CCNUS');
INSERT INTO SECURITY_MATRIX VALUES('jek74s','jek74s','CCNUS1');
INSERT INTO SECURITY_MATRIX VALUES('txs130','txs130','CCNUS1');
UPDATE SECURITY_MATRIX SET ROLE_CODE = 'CCNUS1' WHERE USER_ID = 'kmv600' AND ROLE_CODE = 'CCNUS';
UPDATE SECURITY_MATRIX SET ROLE_CODE = 'CCNUS1' WHERE USER_ID = 'ltk464' AND ROLE_CODE = 'CCNUS';
SELECT * FROM SECURITY_MATRIX WHERE USER_ID IN ('jek74s','kmv600','ltk464','txs130') order by 1,2,3;
INSERT INTO SECURITY_MATRIX VALUES('drc766','drc766','CCNU');
INSERT INTO SECURITY_MATRIX VALUES('drc766','drc766','HWU');
INSERT INTO SECURITY_MATRIX VALUES('drc766','drc766','SDU');
COMMIT;
--Below scripts will add Greg Nelson and Cody Ray need access to new CCN to update the Territory type business code
INSERT INTO SECURITY_MATRIX VALUES('gxn983','gxn983','CCNU1');
INSERT INTO SECURITY_MATRIX VALUES('ccr88d','ccr88d','CCNU1');
COMMIT;

--Below script will add axt720, ncj812 users to a new role code CCNUS2 to select, as they need access to ccn employee window 

Insert into SECURITY_MATRIX (USER_ID,PASSWORD,ROLE_CODE) values ('axt720','axt720','CCNUS2');
Insert into SECURITY_MATRIX (USER_ID,PASSWORD,ROLE_CODE) values ('ncj812','ncj812','CCNUS2');

--Removing the role code CCNUS2 for user 'axt720','ncj812'
SELECT * FROM SECURITY_MATRIX WHERE USER_ID IN ('axt720','ncj812') AND ROLE_CODE = 'CCNUS2';
--2 Row(s) Selected
DELETE FROM SECURITY_MATRIX WHERE USER_ID IN ('axt720','ncj812') AND ROLE_CODE = 'CCNUS2';
--2 Row(s) Deleted

--Below script will add OTP173, DAF328 users to a new role code CCNUS1,SDUS to select, as they need access on cost center and store drafts to interns ASP-1137

Insert into SECURITY_MATRIX (USER_ID,PASSWORD,ROLE_CODE) values ('OTP173','OTP173','CCNUS1');
Insert into SECURITY_MATRIX (USER_ID,PASSWORD,ROLE_CODE) values ('OTP173','OTP173','SDUS');
Insert into SECURITY_MATRIX (USER_ID,PASSWORD,ROLE_CODE) values ('DAF328','DAF328','CCNUS1');
Insert into SECURITY_MATRIX (USER_ID,PASSWORD,ROLE_CODE) values ('DAF328','DAF328','SDUS');

COMMIT;