#!/bin/sh
###############################################################################################################################
# Script name   : pos_term_tran_updt.sh
#
# Description   : This script is to update the last pos tran date and transaction date
# Created       : 12/05/2017 nxk927 CCN Project Team.....
###############################################################################################################################
# below command will get the path for config respective to the environment from which it is run from
. /app/ccn/host.sh

. /app/ccn/bmc_ccn.config

proc="pos_term_tran_updt"
LOGDIR="$HOME/batchJobs"
DATE=`date +"%m-%d-%Y"`
TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc at $TIME on $DATE" 

sqlplus -s -l $sqlplus_user/$sqlplus_pw@$hostname/$service_name >> $LOGDIR/$proc"_"$DATE.log <<END
#sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$DATE.log <<END
set heading off;
set verify off;
set serveroutput on;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
CCN_BATCH_PROCESS.POS_TERM_TRAN_UPDATE;
Exception
 when others then
 :exitCode := 2;
END;
/
exit :exitCode
END

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if test $status -ne 0
then
   TIME=`date +"%H:%M:%S"`
   echo "processing FAILED for $proc at ${TIME} on ${DATE}"
   cd /app/ccn/dev
   ./send_mail.sh "POS_TERM_TRAN_UPT_ERROR"
   exit 1;
fi
#######################################################################################################################

echo "Process to update the last pos tran date and transaction date executed successfully at ${TIME} on ${DATE}"

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"

exit 0
#######################################################################################################################
