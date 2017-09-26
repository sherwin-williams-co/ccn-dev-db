#!/bin/sh
################################################################################################################
# Script name   : rm_sd_reconcile_dailyfiles.sh
#
# Description   : This shell program will remove the store_draft and customer_labor text files from initLoad folder
#
# Created  : 07/11/2016 axk326 CCN Project Team.....
# Modified : 
################################################################################################################

# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="rm_sd_reconcile_dailyfiles"
DATE=`date +"%m/%d/%Y"`
INITLOAD_PATH="$HOME/initLoad"
TIME=`date +"%H:%M:%S"`


echo "Processing Started for $proc_name at $TIME on $DATE"

#remove STORE_DRAFT.TXT file from initLoad back

if 
			ls $INITLOAD_PATH/STORE_DRAFT.TXT &> /dev/null; then
			echo "Removing the files "$INITLOAD_PATH/STORE_DRAFT.TXT
			rm $INITLOAD_PATH/STORE_DRAFT.TXT
else
			echo "STORE_DRAFT.TXT file is not available in "$INITLOAD_PATH
fi

#remove CUSTOMER_LABOR.TXT file from initLoad

if 
			ls $INITLOAD_PATH/CUSTOMER_LABOR.TXT &> /dev/null; then
			echo "Removing the files "$INITLOAD_PATH/CUSTOMER_LABOR.TXT
			rm $INITLOAD_PATH/CUSTOMER_LABOR.TXT
else
			echo " CUSTOMER_LABOR.TXT file is not available in "$INITLOAD_PATH
fi

#############################################################################
##                           ERROR STATUS CHECK 
#############################################################################
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
#############################################################################
