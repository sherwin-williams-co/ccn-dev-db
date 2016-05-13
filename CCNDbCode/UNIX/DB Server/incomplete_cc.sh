#!/bin/sh
#############################################################################
# Script Name   :  incomplete_cc.sh
#
# Description    :  This shell program will send email with incomplete cost centers
#                   details attached as a csv
#
# Created           :  JXC517 11/08/2013
############################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. `cut -d/ -f1-4 <<<"${PWD}"`/ccn.config

 proc="incomplete cost center email"
 LOGDIR="$HOME/batchJobs/backFeed/Archive"
 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
 TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;

execute MAIL_PKG.send_mail('INCOMPLETE_CC');

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

############################################################################

