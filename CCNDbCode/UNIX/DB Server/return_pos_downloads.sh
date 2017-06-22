#!/bin/sh
#################################################################
# Script name   : RETURN_POS_DOWNLOADS.sh
# Description   : This shell script will call connect to sqlplus and run the 
#                 necessary program to update the pos_downloads table
#                   
# Created  : 06/20/2017 rxv940 CCN Project ....
# Modified : 
#              
#################################################################
. /app/ccn/host.sh

proc_name="return_pos_downloads.sh";
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
V_POS_DOWNLOADS CCN_UTILITY.POS_DOWNLOADS%ROWTYPE;
V_ERROR VARCHAR2(1000);
BEGIN
:exitCode := 0;
V_POS_DOWNLOADS := POS_DATA_GENERATION.RETURN_POS_DOWNLOADS(NULL,'$FILENAME');
V_POS_DOWNLOADS.POLLING_REQUEST_ID:='$REQUESTID';
V_POS_DOWNLOADS.COMMENTS:=V_POS_DOWNLOADS.COMMENTS||CHR(10)||'. Polling response is : '||'$REQUESTID';
V_POS_DOWNLOADS.UPDATE_DT:=SYSDATE;


POS_DATA_GENERATION.POS_DOWNLOADS_UPD_SP(V_POS_DOWNLOADS);


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
    echo " $proc_name --> processing FAILED while executing POS_DATA_GENERATION.RETURN_POS_DOWNLOADS at $DATE $TIME "
    ./send_mail.sh "POLLING_FAILURE_MAIL" 
    exit 1
fi

TIME=`date +"%H:%M:%S"`
echo " $proc_name --> Processing Finished for $proc_name for file name $FILENAME at $DATE $TIME"
exit 0

############################################################################
