#!/bin/sh
#################################################################
# Script name   : store_drafts_detail_fix.sh
#
# Description   : purpose of this script is to fix store_drafts_detail table
#				  with all the initLoad and also dailyLoad
# Created  : 12/11/2014 NXK927 CCN PROJECT TEAM....
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="STORE_DRAFTS_DETAIL_FIX"
proc_name1="initLoad_fix"
proc_name2="dailyLoad_fix"
LOGDIR=$HOME/dailyLoad/logs
TimeStamp=`date '+%Y%m%d%H%M%S'`
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`

find $HOME/dailyLoad/archieve/drafts -name STORE_DRAFT.TXT -print0 | xargs -0 -I file cat file > $HOME/initLoad/STORE_DRAFT.TXT

 echo "Processing Started for $proc_name1 at $TIME on $DATE"

./EXEC_NOPARAM.sh "initload_fix.sql" >> $LOGDIR/$proc_name1"_"$TimeStamp.log

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name1 at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc_name1 at ${TIME} on ${DATE}"  

###########################################################################


echo "Processing Started for $proc_name2 at $TIME on $DATE"

./EXEC_NOPARAM.sh "daily_load_fix.sql" >> $LOGDIR/$proc_name2"_"$TimeStamp.log

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name2 at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc_name2 at ${TIME} on ${DATE}"  

############################################################################

