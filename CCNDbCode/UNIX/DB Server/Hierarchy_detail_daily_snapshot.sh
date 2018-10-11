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
 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
 TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $proc at $TIME on $DATE" >> $LOGDIR/$proc"_"$TimeStamp.log

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;
set serveroutput on;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1

DECLARE
BEGIN
    :exitCode := 0;
    HIERARCHY_BATCH_PKG.HIERARCHY_DETAIL_SNAPSHOT;
Exception
    when others then
        DBMS_OUTPUT.PUT_LINE('Hierarchy_detail_daily_snapshot FAILED '||SQLERRM || ' : ' ||SQLCODE);
    :exitCode:=1;
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
   echo "processing FAILED for $proc at ${TIME} on ${DATE}" >> $LOGDIR/$proc"_"$TimeStamp.log

   cd $HOME/
   ./send_mail.sh HIERARCHY_DETAIL_SNAPSHOT_ERROR

   exit 1
fi

TIME=`date +"%H:%M:%S"`
echo "Process to create/update standardized address executed successfully at ${TIME} on ${DATE}" >> $LOGDIR/$proc"_"$TimeStamp.log

exit 0
############################################################################