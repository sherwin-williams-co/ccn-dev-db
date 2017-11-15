/*################################################################
     Created: 11/15/2017 sxg151 CCN Project Team..
     This script do the inserts to security matrix for role
     codes 'CCNMU' for users 'GAP54C','TLC82C''BEO162'
	 ASP-916
--################################################################	 
*/
SET DEFINE OFF;
Insert into SECURITY_MATRIX values ('gap54c','gap54c','CCNMU');
Insert into SECURITY_MATRIX values ('tlc82c','tlc82c','CCNMU');
Insert into SECURITY_MATRIX values ('beo162','beo162','CCNMU');
COMMIT;

