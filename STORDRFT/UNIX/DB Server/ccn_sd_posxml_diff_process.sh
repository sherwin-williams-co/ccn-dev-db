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

TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
proc_name1="GEN_DELTA_FILES_sp"
proc_name2="SEND_MAIL"

echo "Processing Started for $proc_name1 at $TIME on $DATE" 

./EXEC_PROC_NOPARAM.sh "SD_POSXML_INTF_DIFF_pkg.GEN_DELTA_FILES_sp"; 

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]; then     
     echo "processing FAILED for $proc_name1 at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc_name1 at ${TIME} on ${DATE}"
############################################################################

echo "Processing Started for $proc_name2 at $TIME on $DATE"

## Below call works for Character input parameters only.
./EXEC_PROC_2PARAM.sh "SEND_MAIL_pkg.SEND_MAIL" "POSXML_DELTA_FILES_GEN" "POSXML"; 

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]; 
then     
     echo "processing FAILED for $proc_name2 at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc_name2 at ${TIME} on ${DATE}"
exit 0
############################################################################
