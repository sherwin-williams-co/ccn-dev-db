#!/bin/sh
#############################################################################
# Script Name   :  marketing_sqft_batch_load.sh
#
# Description    :  This shell program will initiate the BATCH_PROCESS_SQ_FT_LD 
#                    for MARKETING SQ_FT_FIELDS 
#
# Created :  axt754 02/09/2018
############################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

 proc="MARKETING_SQFT_BATCH_LOAD"
 LOGDIR="$HOME/batchJobs"
 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
 TimeStamp=`date '+%Y%m%d%H%M%S'`
 

echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;
SET SERVEROUTPUT ON;
execute CCN_MARKETING_SQ_FT_LOAD.BATCH_PROCESS_SQ_FT_LD();

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
