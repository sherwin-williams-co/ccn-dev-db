/*
Script Name: DML_FSA_mailing_list_change
Purpose    : "Cara M. DiDonato" requested to stop sending "STINSINV file" email to "FACTS AP@SWCBD" group, 
             as they are retiring that group. Instead the email needs to be sent to "BPI FIN AP NOAM@SWCBD" group. 

Created : 05/02/2017 gxg192 CCN Project....
Changed :
*/

UPDATE MAILING_GROUP
   SET mail_id = 'ccnoracle.team@sherwin.com; bpi.fin.ap.noam@sherwin.com'
 WHERE group_id = (SELECT group_id
                     FROM MAILING_DETAILS
                    WHERE subject = 'STINSINV file');

COMMIT;