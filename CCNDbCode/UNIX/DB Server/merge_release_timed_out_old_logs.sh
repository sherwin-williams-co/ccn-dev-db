#!/bin/sh

##########################################################################################
# Script Name : merge_release_timed_out_old_logs.sh
#
# This is a one-time script to merge old logs into one new log file: release_timed_out_objects.log
# After merging deleting the old log files.
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

echo "Merging log files process started for $proc at ${TIME} on ${DATE}"

##############################################
echo "<<Old Files Data>>" >> $LOGDIR/$proc.log
#Creating file filelist.txt to save all log filename
find /$LOGDIR -maxdepth 1 -name "release_timed_out_objects_20*.log" > filelist.txt

while read -r filename
do
    # extracting datetimestamp from the file name
    var1="${filename//[!0-9]/}"
    # removing the blank lines
    var2=$(cat "$filename" | awk 'NF')
    echo "$var1 : $var2" >> $LOGDIR/$proc.log
    rm $filename
done < filelist.txt

rm $LOGDIR/filelist.txt
echo "<<New writes>>" >> $LOGDIR/$proc.log
##############################################

TIME=`date +"%H:%M:%S"`
echo "Merging log files process finished for $proc at ${TIME} on ${DATE}"
