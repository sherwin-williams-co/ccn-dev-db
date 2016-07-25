#!/bin/sh
###############################################################################################################################
# Script name   : ccn_sd_posxml_daily_load.sh
#
# Description   : This script is to run the following:
#                 1. POSXML_PNP_TO_STRDRT_LOAD_PKG.PNP_TO_SD_LOAD_SP()
#                 2. NEW_POSXML_SD_DAILY_LOAD_TMP.POSXML_SD_DAILY_LOAD_SP('$DATE')
#
# Created  : 06/03/2016 axk326 CCN Project Team.....
# Modified :
###############################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="PNP_TO_SD_LOAD_SP"
LOGDIR=$HOME/dailyLoad/logs
DATE=${DAILY_LOAD_RUNDATE}
TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc_name at $TIME on $DATE"

./EXEC_PROC_NOPARAM.sh "POSXML_PNP_TO_STRDRT_LOAD_PKG.PNP_TO_SD_LOAD_SP"

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if [ $status -ne 0 ]; then
     echo "Loading process failed for loading data from PNP tables to STORDRFT CCN_* tables"
     ./send_err_status_email.sh SD_BATCH_PROCESSING_ERROR
     TIME=`date +"%H:%M:%S"`
     echo "Processing failed for $proc_name at $TIME on $DATE"
     exit 1;
fi
############################################################################
proc_name="POSXML_SD_DAILY_LOAD_SP"
TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc_name at $TIME on $DATE"

./EXEC_PROC_1PARAM.sh "NEW_POSXML_SD_DAILY_LOAD_TMP.POSXML_SD_DAILY_LOAD_SP" "$DATE"

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
# Run the below shell script to move the store draft and customer labor files from archive folder to data files folder
#######################################################################################################################
proc_name="mv_file_arch_to_datafiles"
TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc_name at $TIME on $DATE"

./mv_file_arch_to_datafiles.sh
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

#######################################################################################################################
# Run the below shell script to invoke the delta file generation process
#######################################################################################################################
proc_name="ccn_sd_posxml_diff_process"
TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc_name at $TIME on $DATE"

./ccn_sd_posxml_diff_process.sh
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
proc_name="rm_sd_cl_dailyfiles"
TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc_name at $TIME on $DATE"

./rm_sd_cl_dailyfiles.sh
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