#!/bin/sh
#####################################################################################
# Script name   : polling_archv_init_loads.sh
#
# Description   : This script is to call polling process for TERR, STORE and PARAM 
#               : inits on arrival of .queue and .queue_trgr files in the APP Server
# Created  : 08/17/2017 rxv940 CCN Project Team.....
# Modified : 
#####################################################################################

. /app/ccn/ccn_app_server.config

PROC_NAME="polling_archv_init_loads.sh"
DATADIR="$HOME/POSdownloads/POSxmls"
ARCHIVEDIR=$DATADIR/archivefiles
DATE=$(date +"%d%m%Y")

TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Processing STORE started at $DATE:$TIME "
$SCRIPT_DIR/str_process_pos_polling_file.sh
TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Processing STORE completed at $DATE:$TIME "

TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Processing TERR started at $DATE:$TIME "
$SCRIPT_DIR/ter_process_pos_polling_file.sh
TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Processing TERR completed at $DATE:$TIME "

TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Processing PARAM started at $DATE:$TIME "
$SCRIPT_DIR/prm_process_pos_polling_file.sh
TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Processing PARAM completed at $DATE:$TIME "

TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Archiving $CCD.queue started at $DATE:$TIME "
$SCRIPT_DIR/polling_dwnld_files_archive_process.sh "$CCD.queue"
TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Archiving $CCD.queue completed at $DATE:$TIME "

TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Archiving $CCD.queue_trgrfile started at $DATE:$TIME "
$SCRIPT_DIR/polling_dwnld_files_archive_process.sh "$CCD.queue_trgrfile"
TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Archiving $CCD.queue_trgrfile completed at $DATE:$TIME "

mv "$ARCHIVEDIR"/"$CCD".queue "$ARCHIVEDIR"/"$CCD"_"$DATE".queue
TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Renaming $ARCHIVEDIR"/"$CCD".queue to "$ARCHIVEDIR"/"$CCD"_"$DATE".queue completed at $DATE:$TIME "

exit 0
