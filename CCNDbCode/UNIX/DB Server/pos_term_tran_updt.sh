#!/bin/sh
###############################################################################################################################
# Script name   : pos_term_tran_updt.sh
#
# Description   : This script is to update the last pos tran date and transaction date
# Created       : 12/05/2017 nxk927 CCN Project Team.....
###############################################################################################################################
# below command will get the path for config respective to the environment from which it is run from
. /app/ccn/host.sh

proc="pos_term_tran_updt"
LOGDIR="$HOME/batchJobs"
DATE=`date +"%m-%d-%Y"`
TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc at $TIME on $DATE" 

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$DATE.log <<END
set heading off;
set verify off;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1

execute CCN_BATCH_PROCESS.POS_TERM_TRAN_UPDATE;

exit;
END

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if test $status -ne 0
then
   echo "processing FAILED for $proc at ${TIME} on ${DATE}"
   exit 1;
fi
#######################################################################################################################

echo "Process to update the last pos tran date and transaction date executed successfully at ${TIME} on ${DATE}"

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"

exit 0
#######################################################################################################################
