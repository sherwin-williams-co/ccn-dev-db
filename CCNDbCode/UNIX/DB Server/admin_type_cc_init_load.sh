#!/bin/sh
#############################################################################
# Script Name   :  admin_type_cc_init_load.sh
#
# Description    :  This shell program will initiate the INIT_LOAD_PROCESS 
#                   for ALLOCATION_CC and DIVISION_OFFSET fields in 
#                   ADMINISTRATION Table
#
# Created :  axt754 01/17/2018
############################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

 proc="ADMIN_TYPE_CC_INIT_LOAD"
 LOGDIR="$HOME/initLoad"
 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
 TimeStamp=`date '+%Y%m%d%H%M%S'`
 

echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;
SET SERVEROUTPUT ON;
execute CCN_ADMIN_TYPE_CC_LOAD.INIT_LOAD_PROCESS();

exit;
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if test $status -ne 0
then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"  

exit 0

############################################################################
