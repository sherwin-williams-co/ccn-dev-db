/*******************************************************************************
CCNCC-51: Script to Replace Toni E Thomey <Antoinette.E.Thomey@sherwin.com> with virginia.knight@sherwin.com and Abbey.L.Dorn@sherwin.com 
Created : 07/10/2019 sxc403
*******************************************************************************/
COLUMN GROUP_ID FORMAT A8 HEADING 'Group|Identity';
COLUMN Mail_ID FORMAT A200 HEADING 'Mail|Identity';
 
 select * from MAILING_GROUP
    WHERE GROUP_ID IN (SELECT GROUP_ID
                        FROM MAILING_DETAILS
                        WHERE MAIL_CATEGORY = 'HIER_TRNSFR_TERRITORY');
                        
    --Development/Test/QA
    UPDATE MAILING_GROUP
       SET MAIL_ID = 'ccnoracle.team@sherwin.com'
    WHERE GROUP_ID IN (SELECT GROUP_ID
                        FROM MAILING_DETAILS
                        WHERE MAIL_CATEGORY = 'HIER_TRNSFR_TERRITORY');
                        
     --Prodcution
    UPDATE MAILING_GROUP
       SET MAIL_ID = 'ccnsupport.team@sherwin.com;pmmalloy@sherwin.com;virginia.knight@sherwin.com;Abbey.L.Dorn@sherwin.com'
    WHERE GROUP_ID IN (SELECT GROUP_ID
                        FROM MAILING_DETAILS
                        WHERE MAIL_CATEGORY = 'HIER_TRNSFR_TERRITORY');
                        
 select * from MAILING_GROUP
    WHERE GROUP_ID IN (SELECT GROUP_ID
                        FROM MAILING_DETAILS
                        WHERE MAIL_CATEGORY = 'HIER_TRNSFR_TERRITORY');
                        
                        
 commit;             
 
 