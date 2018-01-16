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

echo "*************************************************************************************" >> $LOGDIR/$LOGFILE
TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Processing started at $DATE : $TIME "  >> $LOGDIR/$LOGFILE
ValidatedNewStoreList=`cat $FILEDIR/$POS_DWNLD_QUEUE_FILE`

feedLog=$(java com.polling.downloads.InitialLoadProcess "NEW_STR_LD" "STORE" "$ValidatedNewStoreList")
TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> The output of the class file is $feedLog at $DATE:$TIME " >> $LOGDIR/$LOGFILE

feedLog=$(java com.polling.downloads.InitialLoadProcess "NEW_STR_LD" "TERR" "$ValidatedNewStoreList")
TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> The output of the class file is $feedLog at $DATE:$TIME " >> $LOGDIR/$LOGFILE

feedLog=$(java com.polling.downloads.InitialLoadProcess "NEW_STR_LD" "PrimeSub" "$ValidatedNewStoreList")
TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> The output of the class file is $feedLog at $DATE:$TIME " >> $LOGDIR/$LOGFILE

# Once the New store load is run, we immediately run the maintenance process
$SCRIPT_DIR/polling_maintenance_process.sh
# End of call to run the maintenance process

TIME=$(date +"%H%M%S")
mv $FILEDIR/$POS_DWNLD_QUEUE_FILE $ARCHIVEDIR/$(POS_DWNLD_QUEUE_FILE)_"$DATE"_"$TIME".queue 
echo " $PROC_NAME --> Archiving completed at $DATE : $TIME "  >> $LOGDIR/$LOGFILE

TIME="$(date +"%H%M%S")"
echo " $PROC_NAME --> processing completed at $DATE : $TIME "  >> $LOGDIR/$LOGFILE

exit 0