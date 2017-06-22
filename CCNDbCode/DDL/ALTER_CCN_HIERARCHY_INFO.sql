/**********************************************************

Script Name: ALTER_CCN_HIERARCHY_INFO.sql
Description: Script to alter CCN_HIERARCHY_INFO table to drop COST_CENTER field
             since it is containing the same data as it is in COST_CENTER_CODE field.

Created    : gxg192 06/01/2017

**********************************************************/

ALTER TABLE CCN_HIERARCHY_INFO
DROP COLUMN COST_CENTER;