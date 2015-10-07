#!/bin/sh

##########################################################################################
# Script Name : Hierarchy_batch_load.sh
# Description : Purpose of this script is to invoke HIERARCHY_BATCH.HRCHY_DELETE_EXPIRED_REC
#               at Daily base.
#
# Date Created: 10/02/2015 SXT410
# Date Updated: 
##########################################################################################

# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

exec &> Hierarchy_batch_load_$(date '+%Y%m%d%H%M%S').log

echo "Begin Hierarchy_batch_load.sh script"

proc="HIERARCHY_BATCH.HRCHY_DELETE_EXPIRED_REC"

echo "Processing Started for $proc at $(date '+%H:%M:%S') on $(date '+%H:%M:%S')"

sqlplus -s -l $sqlplus_user/$sqlplus_pw <<END
set heading off;
set verify off;

execute HIERARCHY_BATCH_PKG.HIERARCHY_BATCH_PROCESS();

execute MAIL_PKG.SEND_MAIL('HIERARCHY_BATCH_END', null, null, null);

exit;
END

#############################################################################
##                           ERROR STATUS CHECK 
#############################################################################
status=$?
if test $status -ne 0
then
     echo "Processing FAILED for $proc at $(date '+%H:%M:%S') on $(date '+%H:%M:%S')"
     exit 1;
fi

echo "Processing finished for $proc at $(date '+%H:%M:%S') on $(date '+%H:%M:%S')" 

echo "End of Hierarchy_batch_load.sh script"

exit 0

############################################################################