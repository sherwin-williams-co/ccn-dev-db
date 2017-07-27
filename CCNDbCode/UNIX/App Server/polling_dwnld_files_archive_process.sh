#!/bin/sh
###############################################################################################################################
# Script name   : polling_dwnld_files_archive_process.sh
# Description   : This script is to archive the files in app server.
#
# Created  : 07/10/2017 rxv940 CCN Project Team.....
# Modified : 
###############################################################################################################################

. /app/ccn/ccn_app_server.config

PROC_NAME="polling_dwnld_files_archive_process.sh"
FILENAME=$1
DATADIR="$HOME/POSdownloads/POSxmls"
ARCHIVEDIR="$DATADIR/archivefiles"
ERRORDIR="$HOME/POSdownloads/error"
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`

echo " $PROC_NAME --> Archiving $FILENAME into $ARCHIVEDIR started at $DATE:$TIME "

mv "$DATADIR/$FILENAME" "$ARCHIVEDIR/$FILENAME"
status=$?
TIME=$(date +"%H%M%S")
if [ $status -gt 0 ]
then
    $SCRIPT_DIR/send_mail.sh "ARCHIVINGPROCESSFAILURE" "Error in $PROC_NAME while archiving $FILENAME."
    echo " $PROC_NAME --> Process failed while archiving the file $FILENAME at $DATE:$TIME "
    mv "$DATADIR/$FILENAME" "$ERRORDIR"
    echo " $PROC_NAME --> File $FILENAME is moved to $ERRORDIR at $DATE:$TIME "
    exit 1
fi
echo " $PROC_NAME --> File $FILENAME is archived under $ARCHIVEDIR and process completed at $DATE:$TIME "

exit 0