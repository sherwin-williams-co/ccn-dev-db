#!/bin/sh
#################################################################
# Script name   : SRA30000_dailyRun.sh
#
# Description   : This script performs below tasks
#                 1. Generates the file from POS and difference file
#                 2. FTP the output file
#
# Created  : 10/31/2016 vxv336 CCN Project Team
# Modified : 12/08/2016 vxv336 Added POS file generation and Diff
#            03/27/2017 gxg192 Added DATE variable and changes to remove cd command
#            05/18/2017 gxg192 Moved SRA30000_Arch_Output_file.sh in gc_reconcile_diff_rpt.sh
#            06/09/2017 gxg192 Added logic to send email if process fails
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="SRA30000_dailyRun"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
IN_DATE=`date +"%d-%b-%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"

###################################################################################
#  Load gift card data from POS tables and Generate the gift card file from POS
###################################################################################
./EXEC_PROC_1PARAM.sh "UAR_GIFT_CARD_PROCESS.POS_GC_DATA_LOAD_SP" "$IN_DATE"
status=$?
TIME=`date +"%H:%M:%S"`
if test $status -ne 0
then
     ERR_MSG="Processing FAILED for Loading Gift card data from POS at ${TIME} on ${DATE}"
     echo $ERR_MSG
     ./send_mail.sh GIFT_CARD_PROCESS_ERROR "$ERR_MSG"
     status=$?
     if [ $status -ne 0 ];
     then
        TIME=`date +"%H:%M:%S"`
        echo "send_mail.sh process FAILED for GIFT_CARD_PROCESS_ERROR at ${TIME} on ${DATE}"
     fi
     exit 1;
fi

#################################################################
#         FTP mainframe output file
#################################################################
./SRA30000_dailyRun_ftp.sh
status=$?
TIME=`date +"%H:%M:%S"`
if test $status -ne 0
then
     ERR_MSG="Processing FAILED for SRA30000_dailyRun_ftp at ${TIME} on ${DATE}"
     echo $ERR_MSG
     ./send_mail.sh GIFT_CARD_PROCESS_ERROR "$ERR_MSG"
     status=$?
     if [ $status -ne 0 ];
     then
        TIME=`date +"%H:%M:%S"`
        echo "send_mail.sh process FAILED for GIFT_CARD_PROCESS_ERROR at ${TIME} on ${DATE}"
     fi
     exit 1;
fi

./send_mail.sh GIFT_CARD_PROCESS_SUCCESS
status=$?
if [ $status -ne 0 ];
then
   TIME=`date +"%H:%M:%S"`
   echo "send_mail.sh process FAILED for GIFT_CARD_PROCESS_SUCCESS at ${TIME} on ${DATE}"
fi

echo "Processing finished for $proc_name at $TIME on $DATE"
exit 0
############################################################################
#                Process END
############################################################################
