#!/bin/sh
#############################################################################
# Script Name   :  1099_monthly_file_gen
#
# Description    : This shell program will initiate the monthly 1099 process 
#
# Created           :  10/02/2014
# Modified          : 
############################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

 proc="1099_monthly_file_gen"
 LOGDIR="$HOME/initLoad/STORDRFT"
 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
 TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $strdrft_sqlplus_user/$strdrft_sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;

execute SD_FILE_BUILD_PKG.BUILD_1099_FILE();

exit;
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"  

exit 0
############################################################################

