-- created by rxv940 on 11/27/2017
-- Run this in Utility
-- removes the flag column JOB_GRP_EXCLD. The flag is now made a filter condition
-- in the POS_DATA_GENERATION table 

ALTER TABLE JOB_TITLE_GROUP
DROP COLUMN JOB_GRP_EXCLD;