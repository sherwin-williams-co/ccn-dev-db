--------------------------------------------------------
--  File created - Friday-May-12-2017   rxa457 for asp-781
--------------------------------------------------------
REM INSERTING into MAILING_DETAILS
SET DEFINE OFF;
Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('MONTHLY_REPORTS_RUN_BP','25','Store Draft Monthly Reports Process Run Failed','ccnoracle.team@sherwin.com','Store Draft Monthly Reports Process Run Failed and no output files were sent using FTP. Please review attached Log file for more details and reschedule the job after taking necessary actions.','Thanks,
Keith D. Parker
IT Manager
Sherwin Williams - Stores IT');
commit;
