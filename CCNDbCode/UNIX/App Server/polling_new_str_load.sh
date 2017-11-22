#!/bin/sh
###############################################################################################################################
# Script name   : polling_new_str_load.sh
# Description   : 
#
#
# Created  : 10/16/2017 jxc517 CCN Project Team.....
# Modified : 10/26/2017 rxv940 CCN Project Team.....
#          : Added calls to PrimeSub
###############################################################################################################################

. /app/ccn/ccn_app_server.config

PROC_NAME="polling_new_str_load.sh"
CLASSHOME="$HOME/CcnJavaCode"
DATE=$(date +"%Y-%m-%d")
LOGDIR="$HOME/CcnJavaCode/log"
LOGFILE="polling_new_str_load.log"

echo "*************************************************************************************" >> $LOGDIR/$LOGFILE
TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Call to the JAVA class started at $DATE : $TIME "  >> $LOGDIR/$LOGFILE

cd "$CLASSHOME" || exit
QueueMessage=$(java \
-Djavax.net.ssl.keyStore="$MQ_CCN_KEY_UN" \
-Djavax.net.ssl.trustStore="$MQ_CCN_KEY_UN" \
-Djavax.net.ssl.keyStorePassword="$MQ_CCN_KEY_PWD" \
-Djavax.net.ssl.trustStorePassword="$MQ_CCN_KEY_PWD" \
com.polling.downloads.MessageQueueProcess "/app/ccn/CcnJavaCode/CCN-v8.ccdt" "$QUEUE_MGR" "$CNSMR_NM")

#If the response has errors, then log the error and move it to the error folder.
if  [[ `echo "$QueueMessage" | egrep -i 'invalid number of arguments passed|invalid file path provided|exception|error'` > 0 ]];
then
    $SCRIPT_DIR/send_mail.sh "QueueDownloadFAILURE" 
    exit 1
fi

echo "$QueueMessage" >> $LOGDIR/$LOGFILE 

feedLog=$(java com.polling.downloads.InitialLoadProcess "NEW_STR_LD" "STORE" "$QueueMessage")
TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> The output of the class file is $feedLog at $DATE:$TIME " >> $LOGDIR/$LOGFILE

feedLog=$(java com.polling.downloads.InitialLoadProcess "NEW_STR_LD" "TERR" "$QueueMessage")
TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> The output of the class file is $feedLog at $DATE:$TIME " >> $LOGDIR/$LOGFILE

feedLog=$(java com.polling.downloads.InitialLoadProcess "NEW_STR_LD" "PrimeSub" "$QueueMessage")
TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> The output of the class file is $feedLog at $DATE:$TIME " >> $LOGDIR/$LOGFILE

TIME="$(date +"%H%M%S")"
echo " $PROC_NAME --> processing completed at $DATE : $TIME "  >> $LOGDIR/$LOGFILE
exit 0

