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

if [ "$IN_FILE_NAME" = "STORE" ]
then
    TIME=$(date +"%H%M%S")
    echo " $PROC_NAME --> Processing STORE started at $DATE:$TIME "
    $SCRIPT_DIR/str_process_pos_polling_file.sh
    TIME=$(date +"%H%M%S")
    echo " $PROC_NAME --> Processing STORE completed at $DATE:$TIME "
elif [ "$IN_FILE_NAME" = "TERR" ]
then 
    TIME=$(date +"%H%M%S")
    echo " $PROC_NAME --> Processing TERR started at $DATE:$TIME "
    $SCRIPT_DIR/ter_process_pos_polling_file.sh
    TIME=$(date +"%H%M%S")
    echo " $PROC_NAME --> Processing TERR completed at $DATE:$TIME "
elif [ "$IN_FILE_NAME" = "PARAM" ]
then 
    TIME=$(date +"%H%M%S")
    echo " $PROC_NAME --> Processing PARAM started at $DATE:$TIME "
    $SCRIPT_DIR/prm_process_pos_polling_file.sh
    TIME=$(date +"%H%M%S")
    echo " $PROC_NAME --> Processing PARAM completed at $DATE:$TIME "
fi

TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Archiving CCD_LIST.queue started at $DATE:$TIME "
$SCRIPT_DIR/polling_dwnld_files_archive_process.sh "CCD_LIST.queue"
TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Archiving CCD_LIST.queue completed at $DATE:$TIME "

TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Archiving $CCD.queue started at $DATE:$TIME "
$SCRIPT_DIR/polling_dwnld_files_archive_process.sh "$CCD.queue"
TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Archiving $CCD.queue completed at $DATE:$TIME "

mv "$ARCHIVEDIR"/"$CCD".queue "$ARCHIVEDIR"/"$CCD"_ws_"$DATE".queue
TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Renaming "$ARCHIVEDIR"/"$CCD".queue to "$ARCHIVEDIR"/"$CCD"_"$DATE".queue completed at $DATE:$TIME "

exit 0

