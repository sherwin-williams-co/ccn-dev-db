PROCEDURE send_mail(IN_MAIL_CATEGORY VARCHAR2)
IS
/*
DROP TYPE MY_RECEPIENT_TYPE;
CREATE OR REPLACE TYPE MY_RECEPIENT_TYPE AS TABLE OF VARCHAR2(300);
DROP TABLE MAILING;
CREATE TABLE MAILING(MAIL_CATEGORY VARCHAR2(100),
                     SUBJECT       VARCHAR2(1000),
                     FROM_P        VARCHAR2(1000),
                     MESSAGE       VARCHAR2(4000),
                     RECEPIENTS    MY_RECEPIENT_TYPE,
                     SIGNATURE     VARCHAR2(4000))
NESTED TABLE RECEPIENTS STORE AS RECEPIENTS_TAB;
SET DEFINE OFF;
INSERT INTO MAILING VALUES('INIT_LOAD_START','InitLoad Status Updates','Jaydeep.Cheruku@sherwin.com','Init Load Process has been Started',MY_RECEPIENT_TYPE('Nirajan.Karki@sherwin.com','Shahla.Husain@sherwin.com','Keith.D.Parker@sherwin.com'),'Thanks & Regards'||CHR(10)||'Jaydeep Cheruku - Consultant'||CHR(10)||'Phone:860-965-3860');
INSERT INTO MAILING VALUES('INIT_LOAD_END','InitLoad Status Updates','Jaydeep.Cheruku@sherwin.com','Init Load Process Completed Successfully',MY_RECEPIENT_TYPE('Nirajan.Karki@sherwin.com','Shahla.Husain@sherwin.com','Keith.D.Parker@sherwin.com'),'Thanks & Regards'||CHR(10)||'Jaydeep Cheruku - Consultant'||CHR(10)||'Phone:860-965-3860');
INSERT INTO MAILING VALUES('HIER_LOAD_START','Hierarchy Loading Status Updates','Jaydeep.Cheruku@sherwin.com','Hierarchy Loading Process has been Started',MY_RECEPIENT_TYPE('Nirajan.Karki@sherwin.com','Shahla.Husain@sherwin.com','Keith.D.Parker@sherwin.com'),'Thanks & Regards'||CHR(10)||'Jaydeep Cheruku - Consultant'||CHR(10)||'Phone:860-965-3860');
INSERT INTO MAILING VALUES('HIER_LOAD_END','Hierarchy Loading Status Updates','Jaydeep.Cheruku@sherwin.com','Hierarchy Loading Process Completed Successfully',MY_RECEPIENT_TYPE('Nirajan.Karki@sherwin.com','Shahla.Husain@sherwin.com','Keith.D.Parker@sherwin.com'),'Thanks & Regards'||CHR(10)||'Jaydeep Cheruku - Consultant'||CHR(10)||'Phone:860-965-3860');
INSERT INTO MAILING VALUES('STOP_JBOSS','JBoss Status Updates','Jaydeep.Cheruku@sherwin.com','JBoss Shutdown Successfully to speed up the database loading process',MY_RECEPIENT_TYPE('Nirajan.Karki@sherwin.com','Shahla.Husain@sherwin.com','Keith.D.Parker@sherwin.com'),'Thanks & Regards'||CHR(10)||'Jaydeep Cheruku - Consultant'||CHR(10)||'Phone:860-965-3860');
INSERT INTO MAILING VALUES('START_JBOSS','JBoss Status Updates','Jaydeep.Cheruku@sherwin.com','Data loading completed successfully and JBoss Started Again',MY_RECEPIENT_TYPE('Nirajan.Karki@sherwin.com','Shahla.Husain@sherwin.com','Keith.D.Parker@sherwin.com'),'Thanks & Regards'||CHR(10)||'Jaydeep Cheruku - Consultant'||CHR(10)||'Phone:860-965-3860');
*/
   v_mail_host   VARCHAR2 (30) := 'smtp.sherwin.com'; --'sthq.sherwin.com';
   v_mail_conn   UTL_SMTP.connection;
   v_recipient   VARCHAR2(32000);
   v_index       number;
   crlf          VARCHAR2 (2) := CHR (13) || CHR (10);
BEGIN
   FOR rec IN (SELECT * FROM MAILING WHERE MAIL_CATEGORY = IN_MAIL_CATEGORY) LOOP
      v_index := 0;
      v_index := rec.RECEPIENTS.FIRST;
      v_mail_conn := UTL_SMTP.open_connection (v_mail_host, 25);
      UTL_SMTP.helo (v_mail_conn, v_mail_host);
      UTL_SMTP.mail (v_mail_conn, rec.FROM_P);
      WHILE v_index IS NOT NULL LOOP
         UTL_SMTP.rcpt (v_mail_conn, rec.RECEPIENTS(v_index));
         v_recipient := v_recipient || ', '||rec.RECEPIENTS(v_index);
         v_index := rec.RECEPIENTS.NEXT(v_index);
      END LOOP;
      UTL_SMTP.data (v_mail_conn,
                    'Date: ' || TO_CHAR (SYSDATE, 'Dy, DD Mon YYYY hh24:mi:ss') || crlf
                    || 'From: ' || rec.FROM_P || crlf 
                    || 'Subject: ' || rec.SUBJECT || crlf
                    || 'To: ' || v_recipient || crlf || crlf
                    || 'Hi All' || crlf || crlf
                    || rec.MESSAGE || crlf || crlf
                    || 'Please let us know if there are any issues' || crlf || crlf
                    || rec.SIGNATURE || crlf);
      UTL_SMTP.quit (v_mail_conn);
   END LOOP;
EXCEPTION
   WHEN UTL_SMTP.transient_error OR UTL_SMTP.permanent_error
   THEN
      raise_application_error (-20000, 'Unable to send mail: ' || SQLERRM);
END;
/

