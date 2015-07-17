#!/bin/sh
#################################################################
# Script name   : banking_current_to_hist.sh
#
# Description   : This script will invoke CURR_TO_HIST_BATCH_PKG.PROCESS
#
# Created  : 07/10/2015 nxk927 CCN Project Team.....
# Modified :
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/host.sh

proc_name="CURR_TO_HIST_BATCH_PKG"
LOGDIR=$HOME/dailyLoad/logs
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
echo "Processing Started for $proc_name at $TIME on $DATE"

echo " BATCH PROCESS CURRENT TO HIST LOADING : Process Started at $TIME on $DATE "

sqlplus -s -l $banking_sqlplus_user/$banking_sqlplus_pw >> $LOGDIR/$proc_name"_"$TimeStamp.log <<END
set heading off;
set verify off;
set serveroutput on;

EXECUTE CURR_TO_HIST_BATCH_PKG.PROCESS();

exit
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################
