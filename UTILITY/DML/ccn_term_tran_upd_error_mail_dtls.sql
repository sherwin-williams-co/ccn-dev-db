SET DEFINE OFF;
/*********************************************************** 
 Added a new Mailing details for term_tran_update error
 created : 01/22/2018 nxk927 CCN project
 revisions: 
************************************************************/
Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('73','ccnoracle.team@sherwin.com');

Insert into MAILING_DETAILS values ('POS_TERM_TRAN_UPT_ERROR','73','Pos terminal latest transaction number,date  and version number update error','ccnoracle.team@sherwin.com','Error while updating the transaction number, date and pos version number.','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');


COMMIT;