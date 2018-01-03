#!/bin/sh

##########################################################################################
# Script Name : Hierarchy_Detail_Snapshot.sh
# Description : Purpose of this script is to invoke HIERARCHY_BATCH_PKG.HIERARCHY_DETAIL_SNAPSHOT
#               at Daily base to load data from HIERARCHY_DETAIL Table to HIERARCHY_DETAIL_SNAPSHOT Table
#
# Date Created: 12/20/2017 SXG151
#
##########################################################################################

# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

exec &> Hierarchy_Detail_Snapshot_load_$(date '+%Y%m%d%H%M%S').log

echo "Begin Hierarchy_Detail_Snapshot.sh script"

proc="HIERARCHY_BATCH_PKG.HIERARCHY_DETAIL_SNAPSHOT"

echo "Processing Started for $proc at $(date '+%H:%M:%S') on $(date '+%H:%M:%S')"

sqlplus -s -l $sqlplus_user/$sqlplus_pw <<END
set heading off;
set verify off;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
execute HIERARCHY_BATCH_PKG.HIERARCHY_DETAIL_SNAPSHOT;

exit
END

#############################################################################
##                           ERROR STATUS CHECK 
#############################################################################
status=$?
if test $status -ne 0
then
     echo "Processing FAILED for $proc at $(date '+%H:%M:%S') on $(date '+%H:%M:%S')"

     cd $HOME
     ./send_mail.sh HIERARCHY_DETAIL_SNAPSHOT_ERROR
     status=$?
     TIME=`date +"%H:%M:%S"`
     if test $status -ne 0
     then
        echo "Sending email for $proc FAILED at $TIME on $DATE"
     fi

     exit 1
fi

echo "Processing finished for $proc at $(date '+%H:%M:%S') on $(date '+%H:%M:%S')" 

echo "End of Hierarchy_Detail_Snapshot.sh script"

exit 0

############################################################################
