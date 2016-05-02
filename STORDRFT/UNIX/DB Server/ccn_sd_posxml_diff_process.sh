#!/bin/sh
###############################################################################################################################
# Script name   : ccn_sd_posxml_diff_process.sh
#
# Description   : This script is to run the SD_POSXML_INTF_DIFF_pkg.GEN_DELTA_FILES_sp
#
# Created  : 04/29/2016 axd783 CCN Project Team.....
# Modified : 
###############################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

process="ccn_sd_posxml_diff_process"
LOGDIR=$HOME/dailyLoad/logs
TIME=`date +"%H:%M:%S"`
DATE=`date +"%d-%^b-%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
log_file=$LOGDIR/$process"_"$TimeStamp.log
proc_name1="GEN_DELTA_FILES_sp"
proc_name2="SEND_MAIL"

echo "Processing Started for $proc_name1 at $TIME on $DATE" >> $log_file

./EXEC_PROC_NOPARAM.sh "SD_POSXML_INTF_DIFF_pkg.GEN_DELTA_FILES_sp"; 

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}" >> $log_file
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name1 at ${TIME} on ${DATE}"  >> $log_file
############################################################################

echo "Processing Started for $proc_name2 at $TIME on $DATE" >> $log_file

./EXEC_PROC_2PARAM.sh "SEND_MAIL_pkg.SEND_MAIL" "POSXML_DELTA_FILES_GEN" "POSXML"; 

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc_name2 at ${TIME} on ${DATE}" >> $log_file
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name2 at ${TIME} on ${DATE}"  >> $log_file
exit 0
############################################################################