#!/bin/bash
#####################################################################################
# Script name   : banking_reconcile_diff_rpt.sh
# Description   : This shell script will call scripts to generate
#                 reconcile diff report for Gift Cards and deposit ticket/bag process
# Created  : 06/16/2017 gxg192 CCN Project Team
# Modified :
#####################################################################################
. /app/banking/dev/banking.config

proc_name="banking_reconcile_diff_rpt"
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`

echo "Processing Started for $proc_name at $TIME on $DATE"

############################################################################
#   Call gc_reconcile_diff_rpt.sh to create Reconcile diff report for 
#   Banking Gift Cards process.
############################################################################
./gc_reconcile_diff_rpt.sh

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     echo "Processing failed for Generating Reconcile Diff Report for Gift Card at $TIME on $DATE"
fi

############################################################################
#   Call dep_tick_reconcile_diff_rpt.sh to create Reconcile diff report for 
#   Banking Gift Cards process.
############################################################################
./dep_tick_reconcile_diff_rpt.sh

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     echo "Processing failed for Generating Reconcile Diff Report for Deposit Ticket at $TIME on $DATE"
fi

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"
exit 0
############################################################################
#                Process END
############################################################################

