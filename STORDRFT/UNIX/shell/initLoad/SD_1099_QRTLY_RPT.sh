#!/bin/sh
#############################################################################################################################
# Script name   : SD_1099_QRTLY_RPT
#
# Description   : This script is to run the store draft reports that includes stops and voids for every quarterly
#
# Created  : 02/18/2016 mxr916 CCN Project Team.....
#          : 03/18/2016 nxk927 CCN Project Team.....
#            Changed the order of declaring variables after capturing the STATUS to avoid the scenario where
#            the ERROR CODE that needs to be captured, will not be overwritten in the ERROR STATUS CHECK block
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
