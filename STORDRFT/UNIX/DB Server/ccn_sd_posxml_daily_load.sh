#!/bin/sh
###############################################################################################################################
# Script name   : ccn_sd_posxml_daily_load.sh
#
# Description   : This script is to run the POSXML_SD_DAILY_LOAD_TMP.POSXML_SD_DAILY_LOAD_SP
#
# Created  : 04/14/2016 axk326 CCN Project Team.....
# Modified : 
###############################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="POSXML_SD_DAILY_LOAD_SP"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%d-%^b-%Y"`

echo "Processing Started for $proc_name at $TIME on $DATE"

./EXEC_PROC_1PARAM.sh "POSXML_SD_DAILY_LOAD_TMP.POSXML_SD_DAILY_LOAD_SP" "$DATE"

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################
