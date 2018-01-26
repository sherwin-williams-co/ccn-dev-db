#!/bin/sh
###############################################################################################################################
# Script name   : polling_futures_load_process.sh
# Description   : This calls the POS_FUTURE_DOWNLOADS package load data into POS table
#
#
# Created  : 01/18/2018 rxv940 CCN Project Team.....
# Modified : 
###############################################################################################################################

. /app/ccn/host.sh
. /app/ccn/bmc_ccn.config

cd $HOME || exit
PROC_NAME="polling_futures_load_process.sh"
DATE=$(date +"%Y-%m-%d")
LOGDIR="$HOME/datafiles/log"
LOGFILE="polling_futures_load_process.log"

echo "*************************************************************************************" >> $LOGDIR/$LOGFILE
TIME=`date +"%H:%M:%S"`
echo " $PROC_NAME --> Processing future downloads starting at $DATE:$TIME "

sqlplus -s -l $ccn_utility_un/$ccn_utility_pwd@$hostname/$service_name >> $LOGDIR/$LOGFILE <<EOF
set heading off;
set serveroutput on;
set verify off;
var exitCode NUMBER;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1

BEGIN
:exitCode := 0;

POS_FUTURE_DOWNLOADS.PROCESS_FUTURE_POS_DOWNLOADS('$dbfldserver_host', '$LOGDIR/$LOGFILE');

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
    echo " $PROC_NAME --> processing FAILED while executing at $DATE:$TIME "
    ./send_mail.sh "POLLING_FAILURE_MAIL" "Error while loading the future records into the POS_DOWNLOADS table"
     exit 1
fi

TIME=`date +"%H:%M:%S"`
echo " $PROC_NAME --> Processing Finished  at $DATE:$TIME "
exit 0

############################################################################


