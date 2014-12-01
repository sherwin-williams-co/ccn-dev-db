#!/bin/sh
#################################################################
# Script name   : 1099_mid_monthly_file_gen.sh
#
# Description   : This shell program will initiate the mid-monthly 1099 process
#
# Created  : 10/22/2014 jxc517 CCN Project Team.....
# Modified : 11/24/2014 jxc517 CCN Project Team.....
#            Added date parameter to run for previous month
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc="1099_mid_monthly_file_gen"
LOGDIR="$HOME/initLoad/logs"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
echo "Processing Started for $proc at $TIME on $DATE"

P1=`date --d "20 day ago" "+%m/%d/%Y"`

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;

execute SD_FILE_BUILD_PKG.BUILD_1099_FILE(to_date('$P1','MM/DD/YYYY'),'Y');

exit;
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc at ${TIME} on ${DATE}"  

exit 0
############################################################################
