PROCEDURE UNIX_COMMAND(IN_UNIX_COMMAND VARCHAR2)
IS
   output_file 		      UTL_FILE.FILE_TYPE;
   filename  	          VARCHAR2(50) := 'cmd_start.sh';
   path                 VARCHAR2(20) := 'CCN_DATAFILES';
   v_out_clob           CLOB;
BEGIN
   IF DBMS_LOB.FILEEXISTS(BFILENAME(path, filename)) = 1 THEN
      DBMS_OUTPUT.PUT_LINE('PREVIOUS COMMAND STILL EXECUTING. PLEASE TRY AGAIN AFTER SOME TIME');
   ELSE
      v_out_clob := NVL(IN_UNIX_COMMAND,'ls -ltr');
      IF UPPER(IN_UNIX_COMMAND) = UPPER('STOP') THEN
         filename   := 'ps_stop.sh';
         v_out_clob := 'exit';
      END IF;
      output_file := UTL_FILE.FOPEN (path, filename, 'w', 32767);
      UTL_FILE.PUT_LINE(output_file, v_out_clob, TRUE);
      UTL_FILE.FCLOSE(output_file);
   END IF;
END;
/

