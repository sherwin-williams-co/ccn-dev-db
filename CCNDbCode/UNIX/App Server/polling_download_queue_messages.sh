#!/bin/sh
###############################################################################################################################
# Script name   : polling_download_queue_messages.sh
# Description   : This shell script connects to the queue, downloads the message and places it on the file system
#
#
# Created  : 01/16/2018 rxv940 CCN Project Team.....
# Modified : 06/06/2019 sxh487 ASP -1247 Polling downloads Cipher issue with version upgrade
#            Added "-Dcom.ibm.mq.cfg.useIBMCipherMappings=false" before java calls
###############################################################################################################################

. /app/ccn/ccn_app_server.config

PROC_NAME="polling_download_queue_messages.sh"
CLASSHOME="$HOME/CcnJavaCode"
DATE=$(date +"%Y-%m-%d")
LOGDIR="$HOME/CcnJavaCode/log"
LOGFILE="polling_download_queue_messages.log"
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
-Dcom.ibm.mq.cfg.useIBMCipherMappings=false \
com.polling.downloads.MessageQueueProcess "downloadQueueMessages" "/app/ccn/CcnJavaCode/CCN-v8.ccdt" "$QUEUE_MGR" "$CNSMR_NM")

#If the response has errors, then log the error and move it to the error folder.
if  [[ `echo "$QueueMessage" | egrep -i 'invalid number of arguments passed|invalid file path provided|exception|error'` > 0 ]];
then
    $SCRIPT_DIR/send_mail.sh "QueueDownloadFAILURE" 
    exit 1
fi

TIME="$(date +"%H%M%S")"
echo " $PROC_NAME --> Writing messages to the Queue file started at $DATE : $TIME "  >> $LOGDIR/$LOGFILE
echo "$QueueMessage" >> $LOGDIR/$LOGFILE
echo "$QueueMessage" > $FILEDIR/$POS_DWNLD_QUEUE_FILE

TIME="$(date +"%H%M%S")"
echo " $PROC_NAME --> processing completed at $DATE : $TIME "  >> $LOGDIR/$LOGFILE

exit 0