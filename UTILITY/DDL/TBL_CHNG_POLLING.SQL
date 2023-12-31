-- created by rxv940 on 10/18/2017
-- Run the below in Utility schema

ALTER TABLE POS_DOWNLOADS ADD TEMP CLOB;

UPDATE POS_DOWNLOADS
SET TEMP     = COMMENTS, 
    COMMENTS = NULL;
    
    COMMIT;
    
ALTER TABLE POS_DOWNLOADS 
DROP COLUMN COMMENTS;

ALTER TABLE POS_DOWNLOADS 
RENAME COLUMN TEMP TO COMMENTS;

-- Below conversion is for GLPS

ALTER TABLE POS_DOWNLOADS_GL_PS ADD TEMP CLOB;

UPDATE POS_DOWNLOADS_GL_PS
SET TEMP     = COMMENTS, 
    COMMENTS = NULL;
    
    COMMIT;
    
ALTER TABLE POS_DOWNLOADS_GL_PS 
DROP COLUMN COMMENTS;

ALTER TABLE POS_DOWNLOADS_GL_PS 
RENAME COLUMN TEMP TO COMMENTS;