-- Created :  AXD783 01/08/2016
-- Purpose : This is to remove access from user 'DRC766' and gave access to user 'ACJ469' CCN User,Hierarchy Window User and Store Drafts User

INSERT INTO SECURITY_MATRIX values ('ACJ469','ACJ469','CCNU');
INSERT INTO SECURITY_MATRIX values ('ACJ469','ACJ469','HWU');
INSERT INTO SECURITY_MATRIX values ('ACJ469','ACJ469','SDU');

DELETE FROM SECURITY_MATRIX WHERE UPPER(USER_ID) = UPPER('drc766');

COMMIT;


