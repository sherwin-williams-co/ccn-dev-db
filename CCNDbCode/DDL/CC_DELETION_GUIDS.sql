/**********************************************************
This script contains the DDL for table that stores the GUIDs
for the cost center being removed from CCN

created : 05/03/2016 jxc517 CCN Project....
modified: 
**********************************************************/
CREATE TABLE CC_DELETION_GUIDS(
    GUID                     VARCHAR2(16),
    COST_CENTER_CODE         VARCHAR2(6),
    PROCESS_DATE             DATE,
    CONSTRAINT CC_DELETION_GUIDS_PK PRIMARY KEY (GUID));
