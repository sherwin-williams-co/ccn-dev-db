#!/bin/sh
#################################################################
# Script name   : SRA11000_load_data_test.sh
#
# Description   : This shell script will perform below tasks
#                 1. load the data needed for the position_file
# Created       : 07/27/2017 nxk927 CCN Project Team.....
# Modified      : This script is created for running parallel process.
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/test/banking.config

proc_name="SRA11000_load_data_test"
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
LOAD_DATE=`date +"%d-%^b-%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"

#################################################################
#                  STR_BNK_DPST_RCNCL_PRCSS_TST.LOAD_DATA
#################################################################
echo "Processing started for STR_BNK_DPST_RCNCL_PRCSS_TST.LOAD_DATA at ${TIME} on ${DATE}"
./EXEC_PROC_1PARAM.sh "STR_BNK_DPST_RCNCL_PRCSS_TST.LOAD_DATA" "$LOAD_DATE"

status=$?
if test $status -ne 0
then
    TIME=`date +"%H:%M:%S"`
    echo "processing FAILED for STR_BNK_DPST_RCNCL_PRCSS_TST.LOAD_DATA at ${TIME} on ${DATE}"
    exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"

proc_name="SRA11000_generate_files_test"
TIME=`date +"%H:%M:%S"`
#################################################################
#                  STR_BNK_DPST_RCNCL_PRCSS_TST.GENERATE_FILES
#################################################################
echo "Processing started for STR_BNK_DPST_RCNCL_PRCSS_TST.GENERATE_FILES at ${TIME} on ${DATE}"
./EXEC_PROC_1PARAM.sh "STR_BNK_DPST_RCNCL_PRCSS_TST.GENERATE_FILES" "$LOAD_DATE"
status=$?
if test $status -ne 0
then
    TIME=`date +"%H:%M:%S"`
    echo "processing FAILED for STR_BNK_DPST_RCNCL_PRCSS_TST.GENERATE_FILES at ${TIME} on ${DATE}"
    exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  
exit 0