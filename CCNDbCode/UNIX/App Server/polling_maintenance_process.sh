#!/bin/sh
############################################################################
# Script name : polling_maintenance_process.sh
# Description : This shell script is used to process polling Maintenance
#             : this will be scheduled to run on the hour
# Created  : 11/02/2017 rxv940 CCN Project ....
# Modified : 
#              
############################################################################

. /app/ccn/ccn_app_server.config

DATADIR="$HOME"/POSdownloads/POSxmls
FILENM=pollingMntncInProcess.trg
CLASSHOME="$HOME/CcnJavaCode"
DATE=$(date +"%d%m%Y")
LOGDIR="$HOME/CcnJavaCode/log"
LOGFILE="polling_maintenance_process.log"


#Check for .trg file 
if ! ls "$DATADIR/$FILENM" 1>/dev/null 2>&1
then
    TIME=$(date +"%H%M%S")
    echo " *********************************************************** " >> $LOGDIR/$LOGFILE
    echo " Process started at $DATE:$TIME "                              >> $LOGDIR/$LOGFILE
    echo " This trigger file is created at $DATE:$TIME "                 > $DATADIR/$FILENM
    
    TIME=$(date +"%H%M%S")
    echo " Trigger file is created at $DATE:$TIME "                      >> $LOGDIR/$LOGFILE
    
    cd "$CLASSHOME" || exit
    logdata=$(java com.polling.downloads.MaintenanceLoadProcess)
    echo "logData is $logdata "                                          >> $LOGDIR/$LOGFILE
    TIME=$(date +"%H%M%S")
    echo " Call to JAVA Class file completed at $DATE:$TIME "            >> $LOGDIR/$LOGFILE
    
    cd $DATADIR || exit
    rm -rf $FILENM
    TIME=$(date +"%H%M%S")
    echo " Trigger file $FILENM purged at $DATE:$TIME "                  >> $LOGDIR/$LOGFILE
fi

exit 0

