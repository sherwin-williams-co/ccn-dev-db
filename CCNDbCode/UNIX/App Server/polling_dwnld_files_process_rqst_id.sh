#!/bin/bash
###############################################################################################################################
# Script name   : polling_dwnld_files_process_rqst_id.sh
# Description   : This script is to parse the request id and act accordingly
#
# Created  : 07/21/2017 rxv940 CCN Project Team.....
# Modified : 
###############################################################################################################################

. /app/ccn/ccn.config

files=$1
FILENAME=$2
REQUESTNAME=$3
REQUESTID=$4

PROC_NAME="polling_dwnld_files_process_rqst_id.sh"
DATADIR="$HOME/POSdownloads/POSxmls"
ERRORDIR="$HOME/POSdownloads/error"
ARCHIVEDIR="$HOME/POSdownloads/POSxmls/archivefiles"
DATE=$(date +"%d%m%Y")
TIME=$(date +"%H%M%S")

# check to see if the .REQUEST file is already present. Do not create if already present.
if [ "$(ls "$DATADIR/$REQUESTNAME" 2>/dev/null | wc -l)" -eq 0 ]
then 

    echo "$REQUESTID" > "$DATADIR/$REQUESTNAME" 
    echo " $PROC_NAME --> Created a REQUEST file $DATADIR/$REQUESTNAME at $DATE:$TIME "
    mv {"$files","$FILENAME"} "$ARCHIVEDIR"
    
    status=$?
    TIME="$(date +"%H%M%S")"
    if [ "$status" -gt 0 ]
    then
        $SCRIPT_DIR/send_mail.sh "ARCHIVINGPROCESSFAILURE"
        echo " $PROC_NAME --> Moving of files to the archive directory failed at $DATE:$TIME ."
        mv {"$files","$FILENAME"} "$ERRORDIR"
        echo " $PROC_NAME -->  Polling process failed so moving $FILENAME and $files to error directory $ERRORDIR at $DATE:$TIME. " 
        exit 1
    else
        echo " $PROC_NAME --> Archiving of $files and $FILENAME to $ARCHIVEDIR done at $DATE:$TIME." 
    fi
fi

echo " $PROC_NAME --> Processing completed successfully at $DATE:$TIME."



