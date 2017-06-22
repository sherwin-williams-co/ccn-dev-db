#!/bin/bash
#####################################################################################
# Script name   : banking_reconcile_data_process.sh
# Description   : This shell script will call scripts to generate
#                 reconcile diff report for Gift Cards and deposit ticket/bag process
# Created  : 06/21/2017 gxg192 CCN Project Team
# Modified :
#####################################################################################
. /app/banking/dev/banking.config

proc_name="banking_reconcile_data_process"
DATE=`date +"%d-%b-%Y"`
TIME=`date +"%H:%M:%S"`
RUNDATE=`date +"%d-%b-%Y"`

echo "Processing Started for $proc_name at $TIME on $DATE"

############################################################################
#   UNIX Function to send the email and track the status of email
############################################################################
SENDEMAIL()
{
CATEGORY="$1"
ERROR_MSG="$2"
echo $ERROR_MSG
TIME=`date +"%H:%M:%S"`
./send_mail.sh $CATEGORY "$ERROR_MSG"
status=$?
if [ $status -ne 0 ];
then
   TIME=`date +"%H:%M:%S"`
   echo "send_mail.sh process FAILED for $CATEGORY at ${TIME} on ${DATE}"
fi
}

#####################################################################################
# Copy the mainframe files from qa on banking app server to load the data 
# so that data is available in external tables used for creating the diff report.
#####################################################################################
./copy_mainframe_files.sh

status=$?
TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]; then
     ERR_MSG="Processing failed for copy_mainframe_files.sh at $TIME on $DATE"
     SENDEMAIL BANKING_DIFF_PROCESS_ERROR "$ERR_MSG"
     TIME=`date +"%H:%M:%S"`
     exit 1;
fi

#####################################################################################
# Load data from Main frame into FF tables for Gift card and Ticket/Bag
#####################################################################################
./EXEC_PROC_1PARAM.sh "BNK_RECONCILE_DIFF_REPORT_PKG.BANKING_MF_FF_DATA_LOAD_SP" "$RUNDATE"

status=$?
if [ $status -ne 0 ]; then
     ERR_MSG="Processing failed for loading data from MainFrame files into CCN Diff tables"
     SENDEMAIL BANKING_DIFF_PROCESS_ERROR "$ERR_MSG"
     TIME=`date +"%H:%M:%S"`
     echo "Processing failed for $proc_name at $TIME on $DATE"
     exit 1;
fi

#####################################################################################
# Run the below shell script to invoke the delta file generation process
#####################################################################################
./banking_reconcile_file_gen.sh "$RUNDATE"

status=$?
if [ $status -ne 0 ]; then
     ERR_MSG="Processing failed for generating delta files for banking."
     SENDEMAIL BANKING_DIFF_PROCESS_ERROR "$ERR_MSG"
     TIME=`date +"%H:%M:%S"`
     echo "Processing failed for $proc_name at $TIME on $DATE"
     exit 1;
fi

#####################################################################################
#                           ERROR STATUS CHECK
#####################################################################################
./banking_archive_dailyfiles.sh

status=$?
if [ $status -ne 0 ]; then
     ERR_MSG="Archiving the mainframe files failed."
     SENDEMAIL BANKING_DIFF_PROCESS_ERROR "$ERR_MSG"
     TIME=`date +"%H:%M:%S"`
     echo "Processing failed for $proc_name at $TIME on $DATE"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"

exit 0;
#####################################################################################
#                Process END
#####################################################################################