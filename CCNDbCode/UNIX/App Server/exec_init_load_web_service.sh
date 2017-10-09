#!/bin/sh
#####################################################################################
# Script name   : exec_init_load_web_service.sh
#
# Description   : This script is to call polling process for based on the input paramt
#               : The input parameters possible are "STORE", "TERR", "PARAM"
# Created  : 09/28/2017 rxv940 CCN Project Team.....
# Modified : 
#####################################################################################

. /app/ccn/ccn_app_server.config

PROC_NAME="exec_init_load_web_service.sh"
DATADIR="$HOME/POSdownloads/POSxmls"
ARCHIVEDIR=$DATADIR/archivefiles
DATE=$(date +"%d%m%Y")

IN_FILE_NAME=$1
CMP_IN_FILE_NAME="$IN_FILE_NAME"_COST_CENTER_DEQUEUE.ws_diff
echo $CMP_IN_FILE_NAME

if [ "$IN_FILE_NAME" = "STORE" ] && [ -s "$DATADIR/StoreUpdate"*".POLLINGDONE" ]
then
    TIME=$(date +"%H%M%S")
    echo " $PROC_NAME --> Processing STORE started at $DATE:$TIME "
	cat $DATADIR/$CMP_IN_FILE_NAME > $DATADIR/COST_CENTER_DEQUEUE.queue
    $SCRIPT_DIR/str_process_pos_polling_file.sh
    TIME=$(date +"%H%M%S")
    echo " $PROC_NAME --> Processing STORE completed at $DATE:$TIME "
elif [ "$IN_FILE_NAME" = "TERR" ] && [ -s "$DATADIR/TerritoryUpdate"*".POLLINGDONE" ]
then 
    TIME=$(date +"%H%M%S")
    echo " $PROC_NAME --> Processing TERR started at $DATE:$TIME "
	cat $DATADIR/$CMP_IN_FILE_NAME > $DATADIR/COST_CENTER_DEQUEUE.queue
    $SCRIPT_DIR/ter_process_pos_polling_file.sh
    TIME=$(date +"%H%M%S")
    echo " $PROC_NAME --> Processing TERR completed at $DATE:$TIME "
elif [ "$IN_FILE_NAME" = "PARAM" ] && [ -s "$DATADIR/ParamUpdate"*".POLLINGDONE" ]
then 
    TIME=$(date +"%H%M%S")
    echo " $PROC_NAME --> Processing PARAM started at $DATE:$TIME "
	cat $DATADIR/$CMP_IN_FILE_NAME > $DATADIR/COST_CENTER_DEQUEUE.queue
    $SCRIPT_DIR/prm_process_pos_polling_file.sh
    TIME=$(date +"%H%M%S")
    echo " $PROC_NAME --> Processing PARAM completed at $DATE:$TIME "
fi

TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Archiving CCD_LIST.ws_diff started at $DATE:$TIME "
$SCRIPT_DIR/polling_dwnld_files_archive_process.sh "$CMP_IN_FILE_NAME"
TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Archiving CCD_LIST.ws_diff completed at $DATE:$TIME "

exit 0

