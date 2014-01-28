create or replace PACKAGE mail_pkg AS

   PROCEDURE send_mail(IN_GROUP_ID VARCHAR2,
                       IN_TERMINL_NUMBER NUMBER);
END;

