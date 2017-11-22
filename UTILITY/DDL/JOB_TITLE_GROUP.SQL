-- craeted by rxv940 on 11/22/2017
-- Run this in Utils

UPDATE JOB_TITLE_GROUP
SET job_grp_excld = 'Y'
WHERE job_title = 'OPS MGR';

COMMIT;