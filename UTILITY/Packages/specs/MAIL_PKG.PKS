create or replace PACKAGE mail_pkg AS

PROCEDURE SEND_MAIL( 
/**********************************************************
SEND_MAIL

  This procedure will send emails based on the MAIL_CATEGORY of the mail
  Currently we have below categories:
                    INIT_LOAD_START
                    INIT_LOAD_END
                    HIER_LOAD_START
                    HIER_LOAD_END
                    STOP_JBOSS
                    START_JBOSS
                    INCOMPLETE_CC
                    ADD_TERMINAL
for more info please refer to the documentation on mail_pkg

IN_MAIL_CATEGORY  - Input MAIL CATEGORY for which email needs to be sent
IN_TERMINL_NUMBER - The Terminal Number being added
IN_COST_CENTER_CD - The Cost Center for which the terminal number was added to

created : 03/03/2013 sxh487 CCN Project....
**********************************************************/
IN_MAIL_CATEGORY VARCHAR2,
IN_TERMINL_NUMBER IN NUMBER default NULL,
IN_COST_CENTER_CD IN VARCHAR2 default NULL,
IN_CLOB IN CLOB DEFAULT NULL);

END mail_pkg;