/*
This script alters administration table to add columns ALLOCATION_CC, DIVISION_OFFSET

Created : 12/26/2017 axt754 CCN Project Team....
Changed :
*/
ALTER TABLE ADMINISTRATION
ADD (ALLOCATION_CC VARCHAR2(6)
     ,DIVISION_OFFSET VARCHAR2(6));