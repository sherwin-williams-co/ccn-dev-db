/*
Below script will expire the unwanted three account from PrimeSub

Created : jxc517 CCN Project Team
Changed :
*/
SELECT * FROM PRGM_GL_ACCNT_RLTN_DTLS WHERE GL_PS_ACCOUNT_NUMBER IN ('3700101','3700122','3700123');
UPDATE PRGM_GL_ACCNT_RLTN_DTLS SET EXPIRATION_DATE = TRUNC(SYSDATE) WHERE GL_PS_ACCOUNT_NUMBER IN ('3700101','3700122','3700123');

COMMIT;