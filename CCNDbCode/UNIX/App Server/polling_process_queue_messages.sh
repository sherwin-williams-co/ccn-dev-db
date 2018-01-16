#!/bin/sh
###############################################################################################################################
# Script name   : polling_process_queue_messages.sh
# Description   : 
#
#
# Created  : 01/16/2018 rxv940 CCN Project Team.....
# Modified : 
###############################################################################################################################

. /app/ccn/ccn_app_server.config

PROC_NAME="polling_process_queue_messages.sh"
CLASSHOME="$HOME/CcnJavaCode"
DATE=$(date +"%Y-%m-%d")
LOGDIR="$HOME/CcnJavaCode/log"
LOGFILE="polling_process_queue_messages.log"
FILEDIR="$HOME/POSdownloads/POSxmls"
ARCHIVEDIR="$HOME/POSdownloads/POSxmls/archivefiles"
QUEUEFILE=queue_message.queue

echo "*************************************************************************************" >> $LOGDIR/$LOGFILE
TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Processing started at $DATE : $TIME "  >> $LOGDIR/$LOGFILE
DestMessage=`cat $FILEDIR/$QUEUEFILE`

feedLog=$(java com.polling.downloads.InitialLoadProcess "NEW_STR_LD" "STORE" "$DestMessage")
TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> The output of the class file is $feedLog at $DATE:$TIME " >> $LOGDIR/$LOGFILE

feedLog=$(java com.polling.downloads.InitialLoadProcess "NEW_STR_LD" "TERR" "$DestMessage")
TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> The output of the class file is $feedLog at $DATE:$TIME " >> $LOGDIR/$LOGFILE

feedLog=$(java com.polling.downloads.InitialLoadProcess "NEW_STR_LD" "PrimeSub" "$DestMessage")
TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> The output of the class file is $feedLog at $DATE:$TIME " >> $LOGDIR/$LOGFILE

# Once the New store load is run, we immediately run the maintenance process
$SCRIPT_DIR/polling_maintenance_process.sh
# End of call to run the maintenance process

TIME=$(date +"%H%M%S")
mv $FILEDIR/$QUEUEFILE $ARCHIVEDIR/queue_message_"$DATE"_"$TIME".queue 
echo " $PROC_NAME --> Archiving completed at $DATE : $TIME "  >> $LOGDIR/$LOGFILE

TIME="$(date +"%H%M%S")"
echo " $PROC_NAME --> processing completed at $DATE : $TIME "  >> $LOGDIR/$LOGFILE

exit 0