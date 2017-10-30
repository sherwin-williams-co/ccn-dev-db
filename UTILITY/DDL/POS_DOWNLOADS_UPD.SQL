-- This is a fix to update the polling request ID
-- created by rxv940 on 10/30/2017
-- run in utils

UPDATE POS_DOWNLOADS
SET PREREQ_EQUIV_RQST_ID = CHR(13) 
WHERE POS_ID = 42853;

COMMIT;