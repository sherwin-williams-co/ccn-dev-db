#!/bin/sh
#############################################################################################################################
# Script name   : SD_1099_QRTLY_RPT
#
# Description   : This script is to run the store draft reports that includes stops and voids for every quarterly
#
# Created  : 02/18/2016 mxr916 CCN Project Team.....
# 
#            
##############################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="SD_1099_QRTLY_RPT"
TIME=`date +"%H:%M:%S"`
DATE=${DAILY_LOAD_RUNDATE}
IN_DATE=${QTLY_1099_RUNDATE}
echo "Processing Started for $proc_name at $TIME on $DATE"

./EXEC_PROC_1PARAM.sh "SD_FILE_BUILD_PKG.SD_1099_QRTLY_RPT" "$IN_DATE"

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################
