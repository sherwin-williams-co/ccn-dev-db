#!/bin/sh
###############################################################################################################################
# Script name   : ccn_monthly_snapshot_load.sh
#
# Description   : This script is to Load the data into snapshot table from CCN Table's
#
# Created       : 01/25/2019 sxg151 CCN Project Team....
#               : ASP-1202 Monthly-views
# 
###############################################################################################################################
cd /app/ccn/dev

# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

proc="ccn_monthly_snapshot_load"
LOGDIR="$HOME/batchJobs"
DATE=`date +"%m/%d/%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc at $TIME on $DATE"   >> $LOGDIR/$proc"_"$TimeStamp.log

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set serveroutput on;
set heading off;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
CCN_BATCH_PROCESS.CCN_MONTHLY_SNAPSHOT_SP;
Exception
when others then
DBMS_OUTPUT.PUT_LINE('ccn_monthly_snapshot_load Load FAILED AT '||SQLERRM || ' : ' ||SQLCODE);
:exitCode:=2;
END;
/
exit :exitCode
END


############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if test $status -ne 0
then
    echo " $proc_name --> processing FAILED while executing $proc at $DATE:$TIME "     >> $LOGDIR/$proc"_"$TimeStamp.log
    cd $HOME || exit
    ./send_mail.sh "CCN_MONTHLY_SNAPSHOT_LOAD"
   exit 1
else
   echo "Processing finished for $proc at ${TIME} on ${DATE}"   >> $LOGDIR/$proc"_"$TimeStamp.log
fi

exit 0
#######################################################################################################################
