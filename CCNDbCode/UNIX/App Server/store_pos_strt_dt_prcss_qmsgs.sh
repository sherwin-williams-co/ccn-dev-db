#!/bin/sh
###############################################################################################################################
# Script name   : store_pos_strt_dt_prcss_qmsgs.sh
# Description   : 
#
#
# Created  : 04/10/2018 nxk927 CCN Project Team.....
# Modified : 
###############################################################################################################################

. /app/ccn/ccn_app_server.config

PROC_NAME="store_pos_strt_dt_prcss_qmsgs.sh"
CLASSHOME="$HOME/CcnJavaCode"
DATE=$(date +"%Y-%m-%d")
LOGDIR="$HOME/CcnJavaCode/log"
LOGFILE="store_pos_strt_dt_prcss_qmsgs.log"
FILEDIR="$HOME/POSdownloads/POSxmls"
ARCHIVEDIR="$HOME/POSdownloads/POSxmls/archivefiles"

echo "*************************************************************************************" >> $LOGDIR/$LOGFILE
TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Call to the JAVA class started at $DATE : $TIME "  >> $LOGDIR/$LOGFILE

cd "$CLASSHOME" || exit

QueueMessage=`cat $FILEDIR/$POS_STRT_DT_QUEUE_FILE`
echo $QueueMessage
chmod 755 $FILEDIR/$POS_STRT_DT_QUEUE_FILE
ValidatedMessages=$(java com.polling.downloads.MessageQueueProcess "processStorePosStrtDtLoad" "$QueueMessage")

#If the response has errors, then log the error and move it to the error folder.
if  [[ `echo "$ValidatedMessages" | egrep -i 'ORA|SP2|exception|error'` > 0 ]];
then
    $SCRIPT_DIR/send_mail.sh "QueueDownloadFAILURE" 
    exit 1
fi

echo $ValidatedMessages >> $LOGDIR/$LOGFILE

TIME="$(date +"%H%M%S")"
echo " $PROC_NAME --> processing completed at $DATE : $TIME "  >> $LOGDIR/$LOGFILE

TIME=$(date +"%H%M%S")
mv $FILEDIR/$POS_STRT_DT_QUEUE_FILE $ARCHIVEDIR/"$POS_STRT_DT_QUEUE_FILE"_"$DATE"_"$TIME".queue 
echo " $PROC_NAME --> Archiving completed at $DATE : $TIME "  >> $LOGDIR/$LOGFILE

TIME="$(date +"%H%M%S")"
echo " $PROC_NAME --> processing completed at $DATE : $TIME "  >> $LOGDIR/$LOGFILE


exit 0
