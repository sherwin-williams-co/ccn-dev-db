-- SXT410 / 06-23-2015 / Updating signature column

SELECT SIGNATURE FROM MAILING_DETAILS;

UPDATE MAILING_DETAILS SET SIGNATURE = 'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT';
COMMIT;