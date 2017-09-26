#!/bin/sh
###############################################################################################################################
# Script name   : Storedrafts_reconcile_data_process.sh
#
# Description   : This script is to process the storedrafts reconcilation process
#
# Created  : 01/05/2017 mxk766 CCN Project Team.....
# Modified :
###############################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="Storedrafts_reconcile_data_process"
LOGDIR=$HOME/dailyLoad/logs
DATE=`date +"%d-%b-%Y"`
DAYSBACK=0
RUNDATE=`date -d "$DAILY_LOAD_RUNDATE - $DAYSBACK days" +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc_name at $TIME on $DATE"

#######################################################################################################################
# Run the below shell script to move the store draft and customer labor files from archive folder to data files folder
#######################################################################################################################
proc_name="mv_sd_reconcile_arch_to_initload.sh"
TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc_name at $TIME on $DATE"

./mv_sd_reconcile_arch_to_initload.sh
#######################################################################################################################
#                           ERROR STATUS CHECK
#######################################################################################################################
status=$?
if [ $status -ne 0 ]; then
     echo "Moving archived files to datafiles folder process failed"
     ./send_err_status_email.sh SD_BATCH_PROCESSING_ERROR
     TIME=`date +"%H:%M:%S"`
     echo "Processing failed for $proc_name at $TIME on $DATE"
     exit 1;
fi


############################################################################
proc_name="SD_RECONCILE_DIFF_REPORT_PKG.SD_MF_FF_DATA_LOAD_SP"
TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc_name at $TIME on $DATE"

./EXEC_PROC_1PARAM.sh "SD_RECONCILE_DIFF_REPORT_PKG.SD_MF_FF_DATA_LOAD_SP" "$RUNDATE"

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if [ $status -ne 0 ]; then
     echo "Loading process failed for loading data into POSXML new temp tables"
     ./send_err_status_email.sh SD_BATCH_PROCESSING_ERROR
     TIME=`date +"%H:%M:%S"`
     echo "Processing failed for $proc_name at $TIME on $DATE"
     exit 1;
fi

#######################################################################################################################
# Run the below shell script to invoke the delta file generation process
#######################################################################################################################
proc_name="storedrafts_reconcile_file_gen.sh"
TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc_name at $TIME on $DATE"

./storedrafts_reconcile_file_gen.sh $RUNDATE
#######################################################################################################################
#                           ERROR STATUS CHECK
#######################################################################################################################
status=$?
if [ $status -ne 0 ]; then
     echo "Generating delta files process failed"
     ./send_err_status_email.sh SD_BATCH_PROCESSING_ERROR
     TIME=`date +"%H:%M:%S"`
     echo "Processing failed for $proc_name at $TIME on $DATE"
     exit 1;
fi
#######################################################################################################################
# Run the below shell script to delete the store draft and customer labor files from data files folder at the end
#######################################################################################################################
proc_name="rm_sd_reconcile_dailyfiles"
TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc_name at $TIME on $DATE"

./rm_sd_reconcile_dailyfiles.sh
#######################################################################################################################
#                           ERROR STATUS CHECK
#######################################################################################################################
status=$?
if [ $status -ne 0 ]; then
     echo "Removing the store draft and customer labor files from datafiles folder process failed"
     ./send_err_status_email.sh SD_BATCH_PROCESSING_ERROR
     TIME=`date +"%H:%M:%S"`
     echo "Processing failed for $proc_name at $TIME on $DATE"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"

exit 0
#######################################################################################################################