#!/bin/bash
#####################################################################################
# Script name   : banking_reconcile_data_process.sh
# Description   : This shell script will call scripts to generate
#                 reconcile diff report for Gift Cards and deposit ticket/bag process
# Created  : 06/21/2017 gxg192 CCN Project Team
# Modified : 06/26/2017 gxg192 Removed SENDEMAIL function. Changes to pass only category
#                              while calling send_mail.sh 
#####################################################################################
. /app/banking/dev/banking.config

proc_name="banking_reconcile_data_process"
DATE=`date +"%d-%b-%Y"`
TIME=`date +"%H:%M:%S"`
RUNDATE=`date +"%d-%b-%Y"`

echo "Processing Started for $proc_name at $TIME on $DATE"

#####################################################################################
# Copy the mainframe files from qa on banking app server to load the data 
# so that data is available in external tables used for creating the diff report.
#####################################################################################
./copy_mainframe_files.sh

status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     echo "Processing failed for copy_mainframe_files.sh at $TIME on $DATE"
     ./send_mail.sh BANKING_DIFF_PROCESS_ERROR
     exit 1
fi

#####################################################################################
# Load data from Main frame into FF tables for Gift card and Ticket/Bag
#####################################################################################
./EXEC_PROC_1PARAM.sh "BNK_RECONCILE_DIFF_REPORT_PKG.BANKING_MF_FF_DATA_LOAD_SP" "$RUNDATE"
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     echo "Processing failed for loading data from MainFrame files into CCN Diff tables at $TIME on $DATE"
     ./send_mail.sh BANKING_DIFF_PROCESS_ERROR
     exit 1
fi

#####################################################################################
# Run the below shell script to invoke the delta file generation process
#####################################################################################
./banking_reconcile_file_gen.sh "$RUNDATE"

status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     echo "Processing failed for generating delta files for banking at $TIME on $DATE"
     ./send_mail.sh BANKING_DIFF_PROCESS_ERROR
     exit 1
fi

#####################################################################################
#                           ERROR STATUS CHECK
#####################################################################################
./banking_archive_dailyfiles.sh

status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     echo "Archiving the mainframe files failed at $TIME on $DATE"
     ./send_mail.sh BANKING_DIFF_PROCESS_ERROR
     exit 1
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"

exit 0
#####################################################################################
#                Process END
#####################################################################################
