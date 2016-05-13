#!/bin/sh
############################################################################################
# Script Name    :  ccn_dad_load_process.sh
#
# Description    :  This shell program will invoke the procedure from the back end to 
#                   TRUNCATE and LOAD the DAD_VALIDATION table from the temp table 
#                   TEMP_DAD_VALIDATION when ever comparison file is placed on the ccn 
#                   db server by the mainframe
#                   
# Created        :  AXK326 05/15/2015
############################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

proc="ccn_dad_load_process"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
LOGDIR="$HOME/batchJobs"

echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$Time.log <<END
set heading off;
set verify off;

execute DAD_FILE_COMPARISON.DAD_VALIDATION_I_SP();
execute DAD_FILE_COMPARISON.DAD_COMPARISON_FILE_SP();

exit;
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"  

############################################################################
