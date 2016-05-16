#!/bin/sh
#################################################################
# Script name   : customer_details_correction.sh
#
# Description   : purpose of this script is to load CUSTOMER_DETAILS_AXK table
#				  with all the initLoad and also dailyLoad
# Created  : 12/03/2014 AXK326 CCN PROJECT TEAM....
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="CUSTOMER_DETAILS_AXK"
proc_name1="initLoad_AXK"
proc_name2="dailyLoad_AXK"
proc_name3="initload_count_validation"
proc_name4="dailyload_count_validation"
LOGDIR=$HOME/dailyLoad/logs
TimeStamp=`date '+%Y%m%d%H%M%S'`
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`

echo "Processing Started for $proc_name at $TIME on $DATE"

./EXEC_NOPARAM.sh "CUSTOMER_DETAILS_AXK.sql" >> $LOGDIR/$proc_name"_"$TimeStamp.log

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

############################################################################

echo "Processing Started for $proc_name1 at $TIME on $DATE"

./EXEC_NOPARAM.sh "initLoad_AXK.sql" >> $LOGDIR/$proc_name1"_"$TimeStamp.log

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

############################################################################

echo "Processing Started for $proc_name3 at $TIME on $DATE"

./EXEC_NOPARAM.sh "initload_count_validation.sql" >> $LOGDIR/$proc_name3"_"$TimeStamp.log

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name3 at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc_name3 at ${TIME} on ${DATE}"  

############################################################################

echo "Processing Started for $proc_name2 at $TIME on $DATE"

./EXEC_NOPARAM.sh "dailyLoad_AXK.sql" >> $LOGDIR/$proc_name2"_"$TimeStamp.log

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

echo "Processing Started for $proc_name4 at $TIME on $DATE"

./EXEC_NOPARAM.sh "dailyload_count_validation.sql" >> $LOGDIR/$proc_name4"_"$TimeStamp.log

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name4 at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc_name4 at ${TIME} on ${DATE}"  

exit 0
############################################################################
