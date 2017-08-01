#!/bin/sh
###############################################################################################################################
# Script name   : process_archive_queue_file.sh
#
# Description   : This script is to call archive process which archives the queue file. 
#                 This is intended to be scheduled aftrer 30 mins of process_message_queue.sh schedule
# Created       : 08/01/2017 rxv940 CCN Project Team.....
# Modified      : 
###############################################################################################################################

. /app/ccn/ccn_app_server.config

PROC_NAME="process_archive_queue_file.sh"
DATE=$(date +"%d%m%Y")

TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Process started at $DATE:$TIME "

FILENAME=$CCD.queue
$SCRIPT_DIR/polling_dwnld_files_archive_process.sh "$FILENAME"

TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Process completed at $DATE:$TIME "