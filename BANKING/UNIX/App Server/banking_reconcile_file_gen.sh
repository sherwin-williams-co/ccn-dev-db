#!/bin/sh
###############################################################################################################################
# Script name   : banking_reconcile_file_gen.sh
#
# Description   : This script is to process the Banking reconcilation process
#
# Created  : 06/21/2017 gxg192 CCN Project Team.....
# Modified :
###############################################################################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="banking_reconcile_file_gen"
DATE=`date +"%d-%b-%Y"`
TIME=`date +"%H:%M:%S"`
RUNDATE=$1

echo "Processing Started for $proc_name at $TIME on $DATE"

############################################################################
#          Generating all difference files on server.
############################################################################
./EXEC_PROC_1PARAM.sh "BNK_RECONCILE_DIFF_REPORT_PKG.GEN_DELTA_FILES_SP" "$RUNDATE"

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if [ $status -ne 0 ]; then
   TIME=`date +"%H:%M:%S"` 
   echo "Processing failed for generating difference files on server at $TIME on $DATE"
   exit 1
fi

############################################################################
#    Sending email with Banking Reconcile Diff files as attachment
############################################################################
./send_mail.sh BANKING_RECONCILE_FILES_GEN
status=$?
if [ $status -ne 0 ];
then
   TIME=`date +"%H:%M:%S"`
   echo "send_mail.sh process FAILED for BANKING_RECONCILE_FILES_GEN at ${TIME} on ${DATE}"
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"

exit 0
###################################################################################
#                Process END
###################################################################################
