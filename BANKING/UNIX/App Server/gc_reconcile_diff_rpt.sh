#!/bin/bash
#####################################################################################
# Script name   : gc_reconcile_diff_rpt.sh
# Description   : This shell script will call GC_RECONCILE_DIFF_RPT_PKG to generate
#                 a reconcile diff report for Gift Cards
# Created  : 01/05/2017 vxv336 CCN Project Team
# Modified : 01/05/2017 gxg192 Changes to load main frame file into FF_GIFT_CARD_POS_TRANS
#                              table and added send email function
#####################################################################################
. /app/banking/dev/banking.config

proc_name="gc_reconcile_diff_rpt"
LOGDIR=$HOME/logs
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
YYMMDD=`date +"%y%m%d"`

echo "Processing Started for $proc_name at $TIME on $DATE"

############################################################################
#   UNIX Function to send the email and track the status of email
############################################################################
SENDEMAIL()
{
ERROR_MSG="$1"
echo $ERROR_MSG
TIME=`date +"%H:%M:%S"`
./send_mail.sh GIFT_CARD_PROCESS_ERROR "$ERROR_MSG"
status=$?
if [ $status -ne 0 ];
then
   TIME=`date +"%H:%M:%S"`
   echo "send_mail.sh process FAILED for GIFT_CARD_PROCESS_ERROR at ${TIME} on ${DATE}"
fi
}

############################################################################
#         Copy the SRA30000 file into GIFT_CARD_POS_TRANS_file
#         and load the data into FF_GIFT_CARD_POS_TRANS table
############################################################################
cp $HOME/initLoad/SRA30000_D$YYMMDD* $HOME/initLoad/GIFT_CARD_POS_TRANS_file.TXT

./EXEC_PROC_NOPARAM.sh "GC_RECONCILE_DIFF_RPT_PKG.LOAD_GC_TRANS_FILE"
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     ERR_MSG="Processing failed for Loading Gift Card File at $TIME on $DATE"
     SENDEMAIL "$ERR_MSG"
     exit 1;
fi

############################################################################
#         Ganerate the reconcile diff report
############################################################################

./EXEC_PROC_1PARAM.sh "GC_RECONCILE_DIFF_RPT_PKG.DATA_CHECK" "$1"

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     ERR_MSG="Processing failed for Generating Reconcile Diff Report at $TIME on $DATE"
     SENDEMAIL "$ERR_MSG"
     exit 1;
fi

###########################################################################
#                     Sending Email with Attachment
###########################################################################
./send_mail.sh POS_GIFT_CARD_TRAN_FILE
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     ERR_MSG="Processing failed for Sending email for POS_GIFT_CARD_TRAN_FILE at $TIME on $DATE"
     SENDEMAIL "$ERR_MSG"
     exit 1;
fi

#################################################################
#         ARCHIVE mainframe output file
#################################################################
./SRA30000_Arch_Output_file.sh
status=$?
TIME=`date +"%H:%M:%S"`
if test $status -ne 0
then
    ERR_MSG="Processing FAILED for SRA30000_Arch_Output_file script at ${TIME} on ${DATE}"
    SENDEMAIL "$ERR_MSG"
    exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"
exit 0
############################################################################
#                Process END
############################################################################
