#!/bin/sh
#################################################################
# Script name   : gl_ps_exec_pos_downloads_update.sh
# Description   : This shell script will update the pos_downloads table
#                 with the requestid for the given file name
#                 The first parameter is filename and 2nd parameter is requestid.   
# Created       : 07/06/2016 rxv940 CCN Project ....
# Modified      : 10/17/2017 rxv940 CCN Project ....
#               :  Code to remove update to COMMENTS
#
#################################################################
. /app/ccn/host.sh

proc_name="gl_ps_exec_pos_downloads_update.sh";
FILENAME=$1
REQUESTID=`echo $2| cut -c 1-36`
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`

echo " $proc_name --> Processing starting at $DATE:$TIME "
echo " $proc_name --> The file name is $FILENAME and Requestid is $REQUESTID at $DATE:$TIME " 



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
TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]
then
    echo " $proc_name --> processing FAILED while executing return_pos_downloads.sh at $DATE:$TIME "
    ./send_mail.sh "POLLING_FAILURE_MAIL" "Error while updating REQUESTID $REQUESTID for file $FILENAME in to the POS_DOWNLOADS table"
     exit 1
fi

echo " $proc_name --> Processing Finished for file name $FILENAME at $DATE:$TIME "
exit 0

############################################################################

