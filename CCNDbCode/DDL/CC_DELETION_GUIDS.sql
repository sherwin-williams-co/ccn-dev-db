/**********************************************************
This script contains the DDL for table that stores the GUIDs
for the cost center being removed from CCN

created : 05/03/2016 jxc517 CCN Project....
modified: 05/06/2016 jxc517 CCN Project....
          As per the change in requirement user wants to
          store the newly generated cost center also
**********************************************************/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE CC_DELETION_GUIDS';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

CREATE TABLE CC_DELETION_GUIDS(
    GUID                     VARCHAR2(16),
    ARCHIVE_COST_CENTER_CODE VARCHAR2(6),
    COST_CENTER_CODE         VARCHAR2(6),
    PROCESS_DATE             DATE,
    CONSTRAINT CC_DELETION_GUIDS_PK PRIMARY KEY (GUID));
