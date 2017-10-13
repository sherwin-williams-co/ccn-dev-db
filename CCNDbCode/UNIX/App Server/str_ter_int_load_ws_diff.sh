#!/bin/sh
###############################################################################################################################
# Script name   : str_ter_int_load_ws_diff.sh
# Description   : This script is to call the Init loads for Store and TERR. This also creates a "COST_CENTER_DEQUEUE.queue" file
#               : which has a list of stores that were newly added to the Web Service.
#               : Generation and processing of Init loads happens only when there are new stores added in the webservice
#
#
# Created  : 10/12/2017 rxv940 CCN Project Team.....
# Modified : 
###############################################################################################################################

. /app/ccn/ccn_app_server.config

PROC_NAME="str_ter_int_load_ws_diff.sh"
DATADIR="$HOME/POSdownloads/POSxmls/"
CLASSHOME="$HOME/POSdownloads/java"
DATE=$(date +"%d%m%Y")
APPNAME=$1
ARCHIVEDIR=$DATADIR/archivefiles
LOGDIR="$HOME/POSdownloads/log"
LOGFILE="str_ter_int_load_ws_diff.log"

TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Processing $APPNAME Init Loads starting at $DATE : $TIME " >> $LOGDIR/$LOGFILE
echo " $PROC_NAME --> Call to the JAVA class started at $DATE : $TIME "  >> $LOGDIR/$LOGFILE

cd "$CLASSHOME" || exit
wsDiff=$(java com.webservice.initLoads_WSDiff "$APPNAME" "$ccn_utility_pwd" "$ccn_utility_un" "$jdbc_url" "$DATADIR") 

echo " $PROC_NAME --> The output of the class file is $wsDiff at $DATE:$TIME " >> $LOGDIR/$LOGFILE

if  [[ "$wsDiff" == *"Error"* ]]
then
    $SCRIPT_DIR/send_mail.sh "POLLING_FAILURE_MAIL" "Error while processing the Init loads for $APPNAME from $PROC_NAME at $DATE:$TIME "
    exit 1
elif [[ "$wsDiff" == *"No new stores found in Web Service"* ]]
then
    echo "There are no new Stores added in the Web Service for $APPNAME at $DATE:$TIME " >> $LOGDIR/$LOGFILE
else 
    if [ "$APPNAME" = "STORE" ]
    then
        $SCRIPT_DIR/str_process_pos_polling_file.sh    >> $LOGDIR/$LOGFILE
    elif [ "$APPNAME" = "TERR" ] 
    then 
        $SCRIPT_DIR/ter_process_pos_polling_file.sh    >> $LOGDIR/$LOGFILE
    fi

    TIME=$(date +"%H%M%S")
    echo " $PROC_NAME --> Archiving $CCD.queue started at $DATE:$TIME "   >> $LOGDIR/$LOGFILE
    $SCRIPT_DIR/polling_dwnld_files_archive_process.sh "$CCD.queue"
    TIME=$(date +"%H%M%S")
    echo " $PROC_NAME --> Archiving $CCD.queue completed at $DATE:$TIME " >> $LOGDIR/$LOGFILE
    
    TIME=$(date +"%H%M%S")
    echo " $PROC_NAME --> Archiving $CCD.queue_trgrfile started at $DATE:$TIME "  >> $LOGDIR/$LOGFILE
    $SCRIPT_DIR/polling_dwnld_files_archive_process.sh "$CCD.queue_trgrfile"
    TIME=$(date +"%H%M%S")
    echo " $PROC_NAME --> Archiving $CCD.queue_trgrfile completed at $DATE:$TIME "  >> $LOGDIR/$LOGFILE
    
    mv "$ARCHIVEDIR"/"$CCD".queue "$ARCHIVEDIR"/"$CCD"_ws_"$APPNAME"_"$DATE".queue
    TIME=$(date +"%H%M%S")
    echo " $PROC_NAME --> Renaming "$ARCHIVEDIR"/"$CCD".queue to "$ARCHIVEDIR"/"$CCD"_ws_"$APPNAME"_"$DATE".queue completed at $DATE:$TIME "  >> $LOGDIR/$LOGFILE

fi



TIME="$(date +"%H%M%S")"
echo " $PROC_NAME --> processing completed at $DATE : $TIME "  >> $LOGDIR/$LOGFILE
exit 0

