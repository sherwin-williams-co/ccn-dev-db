#!/bin/bash
###########################################################################
# Script name   : pos_dep_tick_dailyRun.sh
# Description   : This shell script will load the Ticket/Bag related data
#                 from POS to CCN Banking.
#
# Created  : 06/16/2017 gxg192 CCN Project Team....
# Modified :
###########################################################################
. /app/banking/dev/banking.config

proc_name="pos_dep_tick_dailyRun"
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
IN_DATE=`date +"%d-%b-%Y"`

echo "Processing Started for $proc_name at $TIME on $DATE"

./EXEC_PROC_1PARAM.sh "POS_BANKING_DAILY_LOAD.TICKET_BAG_DATA_LOAD_SP" "$IN_DATE"
status=$?
TIME=`date +"%H:%M:%S"`
############################################################################
#                           ERROR STATUS CHECK
############################################################################
if [ $status -ne 0 ]; then
     echo "Processing Failed for loading data from POS into banking tables at $TIME on $DATE"
     ./send_mail.sh POS_BANK_DEP_TICK_ERROR
     status=$?
     if [ $status -ne 0 ];
     then
        TIME=`date +"%H:%M:%S"`
        echo "send_mail.sh process FAILED for POS_BANK_DEP_TICK_ERROR at ${TIME} on ${DATE}"
     fi
     exit 1;
fi

./send_mail.sh POS_BANK_DEP_TICK_SUCCESS
status=$?
if [ $status -ne 0 ];
then
   TIME=`date +"%H:%M:%S"`
   echo "send_mail.sh process FAILED for POS_BANK_DEP_TICK_SUCCESS at ${TIME} on ${DATE}"
fi

echo "Processing finished for $proc_name at $TIME on $DATE"
exit 0
############################################################################
#                Process END 
############################################################################
