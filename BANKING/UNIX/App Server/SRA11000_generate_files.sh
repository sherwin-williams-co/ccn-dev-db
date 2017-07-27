#!/bin/sh
#################################################################
# Script name   : SRA11000_generate_files.sh
#
# Description   : This shell script will perform below tasks
#                 1. generate the uar.position and serial.dat file
# Created       : 07/27/2017 nxk927 CCN Project Team.....
# Modified 
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="SRA11000_generate_files"
LOGDIR=$HOME/logs
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
LOAD_DATE=`date +"%d-%^b-%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"

#################################################################
#                  STR_BNK_DPST_DLY_RCNCL_PROCESS.GENERATE_FILES
#################################################################
echo "Processing started for STR_BNK_DPST_DLY_RCNCL_PROCESS.GENERATE_FILES at ${TIME} on ${DATE}"
./EXEC_PROC_1PARAM.sh "STR_BNK_DPST_DLY_RCNCL_PROCESS.GENERATE_FILES" "$LOAD_DATE"
status=$?
if test $status -ne 0
then
    TIME=`date +"%H:%M:%S"`
    echo "processing FAILED for STR_BNK_DPST_DLY_RCNCL_PROCESS.GENERATE_FILES at ${TIME} on ${DATE}"
    exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  
exit 0
