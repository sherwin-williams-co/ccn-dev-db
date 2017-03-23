#!/bin/bash
#####################################################################################
# Script name   : pos_gift_card_file_diff.sh
# Description   : This shell script will perform the following:
#                 1. Load the data into UAR_GIFT_CARD_POS_TRANS table on daily basis
# Created  : 11/01/2016 AXK326 CCN Project Team.....
# Modified : 12/08/2016 vxv336 added IN_DATE parameter and GIFT_CARD_POS_TRANS_file.txt
#####################################################################################
. /app/banking/dev/banking.config

proc_name="pos_gift_card_file_diff"
LOGDIR=$HOME/logs
DATE=`date +"%m/%d/%Y"`
IN_DATE=`date +"%d-%b-%Y"`
TIME=`date +"%H:%M:%S"`

echo "Processing Started for $proc_name at $TIME on $DATE"

cd $HOME
./EXEC_PROC_1PARAM.sh "UAR_GIFT_CARD_PROCESS.POS_GC_DATA_LOAD_SP" "$IN_DATE"

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if [ $status -ne 0 ]; then
     echo "Loading process failed for loading data into POS temp tables"
     ./send_mail.sh SD_BATCH_PROCESSING_ERROR
     TIME=`date +"%H:%M:%S"`
     echo "Processing failed for $proc_name at $TIME on $DATE"
     exit 1;
fi
############################################################################
proc1="POS_GIFT_CARD_DIFF_sp"
proc2="SEND_MAIL"
TIME=`date +"%H:%M:%S"`

echo "Processing Started for $proc1 at $TIME on $DATE"

./EXEC_PROC_NOPARAM.sh "POS_GIFT_CARD_DIFF_PKG.POS_GIFT_CARD_DIFF_sp";
############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]; then     
     echo "processing FAILED for $proc1 at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc1 at ${TIME} on ${DATE}"
############################################################################
TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc2 at $TIME on $DATE"

sqlplus -s -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw << END 
set heading off;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
MAIL_PKG.send_mail('POS_GIFT_CARD_TRAN_FILE');
 Exception
 when others then
 :exitCode := 2;
 END;
 /
exit :exitCode
END
############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]; 
then     
     echo "processing FAILED for $proc2 at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc2 at ${TIME} on ${DATE}"
exit 0
############################################################################
#                Process END 
############################################################################ 