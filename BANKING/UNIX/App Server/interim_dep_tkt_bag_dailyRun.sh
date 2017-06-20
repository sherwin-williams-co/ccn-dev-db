#!/bin/sh
#################################################################
# Script name   : interim_dep_tkt_bag_dailyRun.sh
#                 This script should be executed before our daily batch run (dep_tkt_bag_dailyRun.sh) for the deposit tickets and bag.
#
# Description   : This shell script will perform below tasks
#                 1. rename the files accordingly
#                 2. invoke the procedure that performs the core process
#                 3. archieve the files in it's corresponding folder
#
# Created  : 09/09/2016 nxk927 CCN Project Team.....
# Modified : 06/16/2017 gxg192 Removed the logic to Archive files to a folder
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="interim_dep_tkt_bag_dailyRun"
LOGDIR=$HOME/logs
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $proc_name at $TIME on $DATE"

#################################################################
#                  DPST_TCKTS_UPDATE_BATCH_PKG.INTRM_DPST_TKT_PROCESS
#                  DPST_BAGS_UPDATE_BATCH_PKG.INTRM_DPST_BAG_PROCESS
#################################################################
echo "Processing started for Interim Dep tickets and bags batch process at ${TIME} on ${DATE}"
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
DPST_TCKTS_UPDATE_BATCH_PKG.INTRM_DPST_TKT_PROCESS('$HOSTNAME','$LOGDIR/$LOGNAME');
DPST_BAGS_UPDATE_BATCH_PKG.INTRM_DPST_BAG_PROCESS('$HOSTNAME','$LOGDIR/$LOGNAME');

Exception
 when others then
 :exitCode := 2;
 END;
 /
exit :exitCode
END

status=$?
if test $status -ne 0
then
    TIME=`date +"%H:%M:%S"`
    echo "processing FAILED for Interim Dep tickets and bags batch process at ${TIME} on ${DATE}"
    exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for Interim Dep tickets and bags batch process at ${TIME} on ${DATE}"

#################################################################
#                                              Process complete
#################################################################
TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"
exit 0


