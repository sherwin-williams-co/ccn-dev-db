#!/bin/sh
###############################################################################################################################
# Script name   : polling_new_str_load.sh
# Description   : 
#
#
# Created  : 01/16/2018 rxv940 CCN Project Team.....
# Modified : 
###############################################################################################################################

. /app/ccn/ccn_app_server.config

PROC_NAME="polling_new_str_load.sh"
DATE=$(date +"%Y-%m-%d")
LOGDIR="$HOME/CcnJavaCode/log"
LOGFILE="polling_new_str_load.log"

TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Processing New Store Downloads started at $DATE : $TIME "  >> $LOGDIR/$LOGFILE

TIME=$(date +"%H%M%S")
$SCRIPT_DIR/polling_download_queue_messages.sh 
echo " $PROC_NAME --> New Stores downloaded from the Queue at $DATE : $TIME "  >> $LOGDIR/$LOGFILE

TIME=$(date +"%H%M%S")
$SCRIPT_DIR/polling_validate_queue_messages.sh 
echo " $PROC_NAME --> New Stores downloaded from the Queue at $DATE : $TIME "  >> $LOGDIR/$LOGFILE

TIME=$(date +"%H%M%S")
$SCRIPT_DIR/polling_process_queue_messages.sh 
echo " $PROC_NAME --> New Stores downloaded from the Queue at $DATE : $TIME "  >> $LOGDIR/$LOGFILE

TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Processing New Store Downloads completed at $DATE : $TIME "  >> $LOGDIR/$LOGFILE

exit 0