#!/bin/sh
#################################################################
# Script name   : POS_DOWNLOADS_GL_PS_UPD_SP.sh
# Description   : This shell script will call connect to sqlplus and run the 
#                 necessary program to update the pos_downloads table
#                   
# Created  : 06/20/2017 rxv940 CCN Project ....
# Modified : 
#              
#################################################################
. /app/ccn/host.sh

proc_name="pos_downloads_gl_ps_upd.sh";
FILENAME=$1
REQUESTID=$2

TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`

echo " $proc_name --> Connecting to the DB at $DATE $TIME "

sqlplus -s -l $sqlplus_user/$sqlplus_pw <<EOF
set heading off;
set serveroutput on;
set verify off;
var exitCode NUMBER;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
DECLARE
    V_POS_DOWNLOADS_GL_PS CCN_UTILITY.POS_DOWNLOADS_GL_PS%ROWTYPE;
    V_ERROR VARCHAR2(1000);
BEGIN
    :exitCode := 0;
    V_POS_DOWNLOADS_GL_PS := PRIME_SUB_PROCESS.RETRIEVE_POS_DATA_FNC(NULL, '$FILENAME');
    V_POS_DOWNLOADS_GL_PS.POLLING_REQUEST_ID:='$REQUESTID';
    V_POS_DOWNLOADS_GL_PS.COMMENTS:=V_POS_DOWNLOADS_GL_PS.COMMENTS||CHR(10)||'. Polling response is : '||'$REQUESTID';
    V_POS_DOWNLOADS_GL_PS.UPDATE_DT:=SYSDATE;
    V_POS_DOWNLOADS_GL_PS.FILE_PROCESSED:='Y';

PRIME_SUB_PROCESS.POS_DOWNLOADS_GL_PS_UPD_SP(V_POS_DOWNLOADS_GL_PS);

COMMIT;

Exception
when others then
    :exitCode := 1;
END;
/
exit :exitCode

EOF


############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if [ $status -ne 0 ]
then
    TIME=`date +"%H:%M:%S"`
    echo " $proc_name --> processing FAILED while executing PRIME_SUB_PROCESS.POS_DOWNLOADS_GL_PS_UPD_SP at $DATE $TIME "
    ./send_mail.sh "POLLING_FAILURE_MAIL" 
    exit 1
fi

TIME=`date +"%H:%M:%S"`
echo " $proc_name --> Processing finished successfully for file name $FILENAME at $DATE $TIME"
exit 0

############################################################################
