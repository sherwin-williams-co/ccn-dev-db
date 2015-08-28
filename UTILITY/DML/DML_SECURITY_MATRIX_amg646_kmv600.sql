/*
created: 08/28/2015 dxv848  updating the user(amg626) with user(kmv600) in SECURITY_MATRIX table.
*/

UPDATE  SECURITY_MATRIX
   SET USER_ID='amg626',PASSWORD='amg626'
 WHERE USER_ID='kmv600' and PASSWORD='kmv600';

COMMIT;

select * from SECURITY_MATRIX where USER_ID in ('kmv600','amg626');

