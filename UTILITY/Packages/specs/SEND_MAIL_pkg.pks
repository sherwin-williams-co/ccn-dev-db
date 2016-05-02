create or replace PACKAGE SEND_MAIL_pkg AS 
/**************************************************************************
This procedure will attched the multiple files in the mail and send it to the receipiants 

created : 04/04/2016 AXD783 Send Mail Package
changed :
**************************************************************************/

PROCEDURE SEND_MAIL (
/**************************************************************** 
This procedure is used to send the mail for the given 'MAIL_CATEGORY'

created : 04/14/2016 AXD783 Send Mail Procedure
changed :
*****************************************************************/
 in_MAIL_CATEGORY IN  VARCHAR2
,in_MAIL_SET_NAME IN  VARCHAR2
                      );
          
END;