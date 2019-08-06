#!/bin/sh
#######################################################################
# Script name   : daily_banking_deposit_bag_tickets_reports.sh
#
# Description   : Calls the Banking Daily Reports
#
# Created  : 07/30/2019 axm868 CCN Project Team.....CCNBN-12
# Modified : 08/05/2019 axm868 CCN Project Team.....CCNBN-12
                        added "cd /app/banking/<<environment>>" path
#######################################################################
cd /app/banking/dev

# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="daily_banking_deposit_bag_tickets_reports"
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
LOAD_DATE=`date +"%d-%^b-%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"

###########################################################################
#                  BANKING_REPORTING_PKG.GENERATE_DEP_TICK_BAG_DLY_RPRTS
###########################################################################
echo "Processing started for BANKING_REPORTING_PKG.GENERATE_DEP_TICK_BAG_DLY_RPRTS at ${TIME} on ${DATE}"
./EXEC_PROC_NOPARAM.sh "BANKING_REPORTING_PKG.GENERATE_DEP_TICK_BAG_DLY_RPRTS"
status=$?
if test $status -ne 0
then
    TIME=`date +"%H:%M:%S"`
    echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
    exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"
exit 0
