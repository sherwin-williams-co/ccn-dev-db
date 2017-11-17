#!/bin/sh
#################################################################
# Script name   : Royal_Bank_dailyRun.sh
#
# Description   : This shell script will perform below tasks
#                 1. rename the files accordingly to be used for the process
#                 2. invoke the procedure that performs the core process
#
# Created  : 11/17/2015 sxh487 CCN Project Team.....
# Modified : 
#           
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="Royal_Bank_dailyRun"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
echo "Processing Started for $proc_name at $TIME on $DATE"

#################################################################
# Rename the input file
#################################################################
./Royal_Bank_Rename_file.sh

status=$?
if test $status -ne 0
then
    TIME=`date +"%H:%M:%S"`
    echo "processing FAILED for Royal_Bank_Rename_file script at ${TIME} on ${DATE}"
    exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for Royal_Bank_Rename_file script at ${TIME} on ${DATE}"

#################################################################
# ROYAL_BANK_REPORT_LOAD.ROYAL_BANK_REPORT_LOAD_MAIN_SP
#################################################################
echo "Processing started for Royal Bank data load at ${TIME} on ${DATE}"
./Load_royal_bank_data.sh

status=$?
if test $status -ne 0
then
    TIME=`date +"%H:%M:%S"`
    echo "processing FAILED for Royal Bank data load at ${TIME} on ${DATE}"
    exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  
exit 0
