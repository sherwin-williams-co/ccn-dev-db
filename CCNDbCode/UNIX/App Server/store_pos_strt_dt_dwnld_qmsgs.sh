#!/bin/sh
###############################################################################################################################
# Script name   : pos_start_date_queue_messages.sh
# Description   : This shell script connects to the queue, downloads the message and places it on the file system
#
#
# Created  : 04/9/2018 xxxxxx CCN Project Team.....
# Modified : 
###############################################################################################################################

. /app/ccn/ccn_app_server.config

PROC_NAME="pos_start_date_queue_messages.sh"
CLASSHOME="$HOME/CcnJavaCode"
DATE=$(date +"%Y-%m-%d")
LOGDIR="$HOME/CcnJavaCode/log"
LOGFILE="pos_start_date_queue_messages.log"
FILEDIR="$HOME/POSdownloads/POSxmls"

echo "*************************************************************************************" >> $LOGDIR/$LOGFILE
TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Call to the JAVA class started at $DATE : $TIME "  >> $LOGDIR/$LOGFILE

cd "$CLASSHOME" || exit
QueueMessage=$(java \
-Djavax.net.ssl.keyStore="$MQ_CCN_KEY_UN" \
-Djavax.net.ssl.trustStore="$MQ_CCN_KEY_UN" \
-Djavax.net.ssl.keyStorePassword="$MQ_CCN_KEY_PWD" \
-Djavax.net.ssl.trustStorePassword="$MQ_CCN_KEY_PWD" \
com.polling.downloads.MessageQueueProcess "downloadQueueMessages" "/app/ccn/CcnJavaCode/CCN-v8.ccdt" "$QUEUE_MGR" "$POS_STRT_DT_CNSMR_NM")

#If the response has errors, then log the error and move it to the error folder.
if  [[ `echo "$QueueMessage" | egrep -i 'invalid number of arguments passed|invalid file path provided|exception|error'` > 0 ]];
then
    $SCRIPT_DIR/send_mail.sh "QueueDownloadFAILURE" 
    exit 1
fi

TIME="$(date +"%H%M%S")"
echo " $PROC_NAME --> Writing messages to the Queue file started at $DATE : $TIME "  >> $LOGDIR/$LOGFILE
echo "$QueueMessage" >> $LOGDIR/$LOGFILE
echo "$QueueMessage" > $FILEDIR/$POS_STRT_DT_QUEUE_FILE

TIME="$(date +"%H%M%S")"
echo " $PROC_NAME --> processing completed at $DATE : $TIME "  >> $LOGDIR/$LOGFILE

exit 0