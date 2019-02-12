#!/bin/sh

##########################################################################################
# Script Name : delete_release_timed_out_old_logs.sh
#
# purpose of this script is to delete old logs files (release_timed_out_objects_*.log)
#     created by the release_timed_out_objects.sh
#
# Date Created: 02/12/2019 mxs216 ASP-1210 CCN Project Team.....
# Date Updated: 
##########################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

LOGDIR="$HOME/batchJobs"

# rm $LOGDIR/release_timed_out_objects_20*.log

 TIME=`date +"%H:%M:%S"`
 echo "Processing finished for $proc at ${TIME} on ${DATE}"

############################################################################
