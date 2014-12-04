#!/bin/sh
#################################################################
# Script name   : drop_rename.sh
#
# Description   : purpose of this script is to drop and rename customer_details_axk to CUSTOMER_DETAILS table
#				  with all the initLoad and also dailyLoad
# Created  : 12/03/2014 AXK326 CCN PROJECT TEAM....
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="drop_rename"
#LOGDIR=$HOME/dailyLoad/logs
#FILE=CUSTOMER_DETAILS_AXK.sql
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`

echo "Processing Started for $proc_name at $TIME on $DATE"

./EXEC_NOPARAM.csh "drop_rename.sql"

echo "Processing finished for $proc_name at $TIME on $DATE"

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

exit 0
############################################################################