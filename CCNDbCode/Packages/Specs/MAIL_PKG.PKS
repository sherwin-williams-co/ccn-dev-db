create or replace
PACKAGE mail_pkg AS

   PROCEDURE send_mail(IN_MAIL_CATEGORY VARCHAR2,
                       IN_TERMINL_NUMBER IN NUMBER default NULL);
END;