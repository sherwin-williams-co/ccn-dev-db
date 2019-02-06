/********************************************************************************** 
Below script is created to insert data into MAILING_DETAILS table to send an email 
if Hierarchy Bulk attribute update process fails.

Created : 12/18/2018 mxs216 CCN Project ASP-1169....
Modified: 
**********************************************************************************/

-- Checking if the mailing group already exists
SELECT * FROM mailing_group WHERE group_id = '106';
-- Group found

-- INSERTING into MAILING_DETAILS table
INSERT INTO MAILING_DETAILS (MAIL_CATEGORY, GROUP_ID, SUBJECT, FROM_P, MESSAGE, SIGNATURE) 
                     VALUES ('HIERARCHY_BULK_ATTR_UPDATE_FAIL', 
                             '106', 
                             'Hierarchy Bulk Attribute Update Failures', 
                             'ccnoracle.team@sherwin.com', 
                             'Please see the attached files for details about the hierarchy attributes that failed during Hierarchy Bulk Attribute Update Process.', 
                             'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
COMMIT;
 