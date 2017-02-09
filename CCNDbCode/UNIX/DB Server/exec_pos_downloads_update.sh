#!/bin/sh
#################################################################
# Script name   : exec_pos_downloads_update.sh
# Description   : This shell script will update the pos_downloads table
#                 with the requestid for the given file name
#                 The first parameter is filename and 2nd parameter is requestid.   
# Created  : 10/03/2016 MXK766 CCN Project ....
# Modified : 
#################################################################
. /app/ccn/host.sh


proc_name="exec_pos_downloads_update.sh";
FILENAME=$1
REQUESTID=$2
LOGFILE=$3
echo "The file name is $FILENAME"
echo "The Requestid is $REQUESTID"
echo "The log file name is $LOGFILE"

TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`

echo "Processing Started for $proc_name at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >>$LOGFILE <<EOF
set heading off;
set serveroutput on;
set verify off;
var exitCode NUMBER;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
DECLARE
V_POS_DOWNLOADS CCN_UTILITY.POS_DOWNLOADS%ROWTYPE;
BEGIN
:exitCode := 0;
V_POS_DOWNLOADS := POS_DATA_GENERATION.RETURN_POS_DOWNLOADS(NULL,'$FILENAME');
V_POS_DOWNLOADS.POLLING_REQUEST_ID:='$REQUESTID';
V_POS_DOWNLOADS.COMMENTS:=V_POS_DOWNLOADS.COMMENTS||CHR(10)||'Polling response is : '||'$REQUESTID';
V_POS_DOWNLOADS.UPDATE_DT:=SYSDATE;
POS_DATA_GENERATION.POS_DOWNLOADS_UPD_SP(V_POS_DOWNLOADS);
COMMIT;
Exception
when others then
ROLLBACK;
:exitCode:=1;
END;
/

exit :exitCode
EOF

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if [ $status -ne 0 ];
then
    TIME=`date +"%H:%M:%S"`
    echo "processing FAILED while executing $proc_name "
    exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing Finished for $proc_name for file name $FILENAME"
exit 0

############################################################################