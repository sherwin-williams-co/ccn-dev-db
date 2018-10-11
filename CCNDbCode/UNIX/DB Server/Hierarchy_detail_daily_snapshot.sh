#!/bin/sh
###############################################################################################################################
# Script name   : Hierarchy_detail_daily_snapshot.sh
# Description : Purpose of this script is to invoke HIERARCHY_BATCH_PKG.HIERARCHY_DETAIL_SNAPSHOT
#               at Daily base to load data from HIERARCHY_DETAIL Table to HIERARCHY_DETAIL_DAILY_SNAP Table
#
# Date Created: 10/11/2018 SXG151
###############################################################################################################################
cd /app/ccn/dev

# below command will get the path for config respective to the environment from which it is run from
. /app/ccn/BMChost.sh

proc="Hierarchy_detail_daily_snapshot"
LOGDIR="$HOME/batchJobs"
DATE=`date +"%m-%d-%Y"`
TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc at $TIME on $DATE" 

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$DATE.log <<END
set heading off;
set verify off;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1

execute HIERARCHY_BATCH_PKG.HIERARCHY_DETAIL_SNAPSHOT;

exit;
END

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]
then
    echo " $proc_name --> processing FAILED while executing Hierarchy_detail_daily_snapshot.sh at $DATE:$TIME "
    $HOME/send_mail.sh HIERARCHY_DETAIL_SNAPSHOT_ERROR
     exit 1
fi

echo " $proc_name --> Processing Finished at $DATE:$TIME "
exit 0

############################################################################
