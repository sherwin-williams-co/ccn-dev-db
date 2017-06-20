#!/bin/sh
#################################################################
# Script name   : dep_tkt_bag_dailyRun.sh
#
# Description   : This shell script will perform below tasks
#                 1. rename the files accordingly
#                 2. invoke the procedure that performs the core process
#                 3. archieve the files in it's corresponding folder
#
# Created  : 08/16/2016 nxk927 CCN Project Team.....
# Modified : 08/19/2016 nxk927 CCN Project Team.....
#             passing parameter logname and the servername to be inserted in batch_job table
#          : 08/25/2016 nxk927 CCN Project Team.....
#            creating trigger file to stop deposits_order_bp.sh background process to kick off for this batch
#          : 06/16/2017 gxg192 Removed the logic to Archive files to a folder
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="dep_tkt_bag_dailyRun"
LOGDIR=$HOME/logs
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
export HOSTNAME=`hostname`
echo "Processing Started for $proc_name at $TIME on $DATE"

# Generating a dep_tkt_bag_dailyRun.trigger file using the redirection command to make sure deposits_order_bp.sh background process will not kick off.
printf "deposit ticket and bag batch Process started" > dep_tkt_bag_dailyRun.trigger

#################################################################
#                  DPST_TCKTS_UPDATE_BATCH_PKG.PROCESS
#                  DPST_BAGS_UPDATE_BATCH_PKG.PROCESS
#################################################################
echo "Processing started for Dep tickets and bags batch process at ${TIME} on ${DATE}"
LOGNAME=$proc_name"_"$TimeStamp.log
sqlplus -s -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw >> $LOGDIR/$LOGNAME <<END
set heading off;
set serveroutput on;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
DPST_TCKTS_UPDATE_BATCH_PKG.PROCESS('$HOSTNAME','$LOGDIR/$LOGNAME');
DPST_BAGS_UPDATE_BATCH_PKG.PROCESS('$HOSTNAME','$LOGDIR/$LOGNAME');

Exception
 when others then
 :exitCode := 2;
 END;
 /
exit :exitCode
END

status=$?
TIME=`date +"%H:%M:%S"`
if test $status -ne 0
then
    echo "processing FAILED for Dep tickets and bags batch process at ${TIME} on ${DATE}"
    exit 1;
fi
echo "Processing finished for Dep tickets and bags batch process at ${TIME} on ${DATE}"

#################################################################
#                                   ftp the tickets and the files
#################################################################
TIME=`date +"%H:%M:%S"`
echo "Processing Started for ftping the deposit ticket and bag at $TIME on $DATE"
./deposit_bag_order_files_ftp.sh
./deposit_ticket_order_files_ftp.sh
TIME=`date +"%H:%M:%S"`
echo "Processing Completed for ftping the deposit ticket and bag at $TIME on $DATE"

TIME=`date +"%H:%M:%S"`
echo "Removing the trigger file as the batch process completed at $TIME on $DATE"
rm -f dep_tkt_bag_dailyRun.trigger

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  
exit 0

#################################################################
#                                              Process complete
#################################################################
