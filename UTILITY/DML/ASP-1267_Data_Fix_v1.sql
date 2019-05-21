/*******************************************************************************
ASP-1267: Script to insert email address of Nicole Divita and Matthew Kosarko to CCN Accounting/EPM Reports email distribution list. 
Created : 05/20/2019 sxc403
*******************************************************************************/
COLUMN GROUP_ID FORMAT A8 HEADING 'Group|Identity';
COLUMN Mail_ID FORMAT A200 HEADING 'Mail|Identity';
 
 select * from MAILING_GROUP
    WHERE GROUP_ID IN (SELECT GROUP_ID
                        FROM MAILING_DETAILS
                        WHERE MAIL_CATEGORY = 'CCN_ACCNT_EPM_REPORT');
                        
    UPDATE MAILING_GROUP
       SET MAIL_ID = MAIL_ID ||';Nicole.M.DiVita@sherwin.com;matthew.kosarko@sherwin.com'
    WHERE GROUP_ID IN (SELECT GROUP_ID
                        FROM MAILING_DETAILS
                        WHERE MAIL_CATEGORY = 'CCN_ACCNT_EPM_REPORT');
                        
 select * from MAILING_GROUP
    WHERE GROUP_ID IN (SELECT GROUP_ID
                        FROM MAILING_DETAILS
                        WHERE MAIL_CATEGORY = 'CCN_ACCNT_EPM_REPORT');
                        
                        
 commit;                        

 
 
 