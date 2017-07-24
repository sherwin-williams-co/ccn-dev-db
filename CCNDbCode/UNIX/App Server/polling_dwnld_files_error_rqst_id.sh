#!/bin/bash
###############################################################################################################################
# Script name   : polling_dwnld_files_error_rqst_id.sh
# Description   : This script is to parse the request id and act accordingly
#
# Created  : 07/21/2017 rxv940 CCN Project Team.....
# Modified : 
###############################################################################################################################

. /app/ccn/ccn.config

files=$1
FILENAME=$2
REQUESTID=$3

PROC_NAME="polling_dwnld_files_error_rqst_id.sh"
ERRORDIR="$HOME/POSdownloads/error"
DATE=$(date +"%d%m%Y")
TIME=$(date +"%H%M%S")

$SCRIPT_DIR/send_mail.sh "RequestidFailure"
echo " $PROC_NAME --> Polling class PollingRequest failed while processing file: $FILENAME %s\n" "Error returned by class com.webservice.PollingRequest is $REQUESTID at $DATE:$TIME "				
mv {"$files","$FILENAME"} "$ERRORDIR"
echo " $PROC_NAME -->  Polling process failed so moving $FILENAME and $files to error directory $ERRORDIR at $DATE:$TIME. " 

exit 1