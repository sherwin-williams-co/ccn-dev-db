-- Re-structuring the POS tables per new design 
-- Changed by rxv940 on 10/26/2017
-- Run this in Util schema



CREATE INDEX POS_DOWNLOADS_FILE_NAME_INDX ON POS_DOWNLOADS (FILE_NAME);


************************************************************************************************

ALTER TABLE POS_DOWNLOADS_GL_PS 
ADD PREREQ_EQUIV_RQST_ID	VARCHAR2(36);

ALTER TABLE POS_DOWNLOADS_GL_PS 
DROP COLUMN COMMENTS;



************************************************************************************************

ALTER TABLE POS_DOWNLOADS_NON_TAXWARE 
ADD PREREQ_EQUIV_RQST_ID	VARCHAR2(36);

ALTER TABLE POS_DOWNLOADS_NON_TAXWARE 
DROP COLUMN COMMENTS;

CREATE INDEX POS_DWNLD_NON_TAX_FL_NM_IDX ON POS_DOWNLOADS_NON_TAXWARE (FILE_NAME);
CREATE INDEX POS_DWNLD_GL_PS_FL_NM_IDX ON POS_DOWNLOADS_GL_PS (FILE_NAME);

************************************************************************************************
GRANT EXECUTE ON POS_DOWNLOADS_INTERFACE_PKG TO COSTCNTR;   --> Utils



