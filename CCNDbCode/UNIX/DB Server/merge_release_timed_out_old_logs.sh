#!/bin/sh

##########################################################################################
# Script Name : merge_release_timed_out_old_logs.sh
#
# This is a one-time script to merge old logs into one new log file: release_timed_out_objects.log
#
# Date Created: 02/12/2019 mxs216 ASP-1210 CCN Project Team.....
# Date Updated: 
##########################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

proc="release_timed_out_objects"
LOGDIR="$HOME/batchJobs"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`

echo "<<Old Files Data>>" >> $LOGDIR/$proc.log

for i in `ls release_timed_out_objects_20*.log`
do
    # extracting datetimestamp from the file name
    var1="${i//[!0-9]/}"
    # removing the blank lines
    var2=$(cat "$i" | awk 'NF')
    echo "$var1 : $var2" >> $LOGDIR/$proc.log
done
echo "<<New writes>>" >> $LOGDIR/$proc.log

TIME=`date +"%H:%M:%S"`
echo "Merging log files finished for $proc at ${TIME} on ${DATE}"

############################################################################
