#!/bin/sh
###############################################################################################################################
# Script name   : polling_validate_queue_messages.sh
# Description   : 
#
#
# Created  : 01/16/2018 rxv940 CCN Project Team.....
# Modified : 
###############################################################################################################################

. /app/ccn/ccn_app_server.config

PROC_NAME="polling_validate_queue_messages.sh"
CLASSHOME="$HOME/CcnJavaCode"
DATE=$(date +"%Y-%m-%d")
LOGDIR="$HOME/CcnJavaCode/log"
LOGFILE="polling_validate_queue_messages.log"
FILEDIR="$HOME/POSdownloads/POSxmls"
QUEUEFILE=queue_message.queue

echo "*************************************************************************************" >> $LOGDIR/$LOGFILE
TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Call to the JAVA class started at $DATE : $TIME "  >> $LOGDIR/$LOGFILE

cd "$CLASSHOME" || exit

QueueMessage=`cat $FILEDIR/$QUEUEFILE`
chmod 755 $FILEDIR/$QUEUEFILE
ValidatedMessages=$(java com.polling.downloads.MessageQueueProcess "$QueueMessage")

echo $ValidatedMessages >> $LOGDIR/$LOGFILE
echo $ValidatedMessages > $FILEDIR/$QUEUEFILE

TIME="$(date +"%H%M%S")"
echo " $PROC_NAME --> processing completed at $DATE : $TIME "  >> $LOGDIR/$LOGFILE

exit 0