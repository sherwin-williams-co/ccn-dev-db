/*
Script Name: DML_FSA_mailing_list_change
Purpose    : "Cara M. DiDonato" requested to stop sending "STINSINV file" email to "FACTS AP@SWCBD" group, 
             as they are retiring that group. Instead the email needs to be sent to "BPI FIN AP NOAM@SWCBD" group. 

Created : 05/02/2017 gxg192 CCN Project....
Changed : 05/02/2017 gxg192 Changes to use group id.
*/

SELECT * FROM MAILING_GROUP WHERE GROUP_ID = '27';
--1 Row(s) Selected

UPDATE MAILING_GROUP
   SET mail_id = 'ccnoracle.team@sherwin.com; bpi.fin.ap.noam@sherwin.com'
 WHERE group_id = '27';
--1 Row(s) Updated

COMMIT;