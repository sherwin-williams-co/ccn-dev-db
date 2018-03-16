/*
Below script will expire the current record and make new record active as of today with type code as 23

GIT Update alone, scripts already executed in prooduction as urgent request

Created : 03/16/2018 jxc517 CCN Project Team....
Changed :
*/
SELECT * FROM TYPE WHERE COST_CENTER_CODE = '778803';

UPDATE TYPE SET EXPIRATION_DATE = '15-MAR-2018' WHERE COST_CENTER_CODE = '778803';

INSERT INTO TYPE VALUES ('778803','23','16-MAR-2018',NULL);

COMMIT;
