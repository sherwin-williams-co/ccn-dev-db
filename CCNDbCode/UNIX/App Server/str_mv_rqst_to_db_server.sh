#!/bin/sh
###############################################################################################################################
# Script name   : str_mv_rqst_to_db_server.sh
# Description   : This script is to transfer files from db server to app server.
#
# Created  : 07/05/2017 rxv940 CCN Project Team.....
# Modified : 
###############################################################################################################################

. /app/ccn/ccn_app_server.config

PROC_NAME="str_mv_rqst_to_db_server.sh"
DATADIR="$HOME/POSdownloads/POSxmls"
ARCHIVEDIR="$HOME/POSdownloads/POSxmls/archivefiles"
DATE=$(date +"%d%m%Y")
TIME=$(date +"%H%M%S")

echo " $PROC_NAME --> Processing started at $DATE:$TIME "
cd "$DATADIR" || exit

for files in "$STR_FILE_NAME"*".REQUEST"
do
    
    echo " $PROC_NAME --> FTP of $files to dbserver $CCNDBUSERNAME@$CCNDBSERVERHOST started at $DATE:$TIME " 
    $SCRIPT_DIR/polling_dwnld_files_ftp_to_db_server.sh "$files"

    status=$?
    TIME=$(date +"%H%M%S")
    if [ $status -gt 0 ]
    then
        exit 1
    fi
    echo " $PROC_NAME --> status of ftp process is $status and the file is placed at $CCNDBSERVDEST at $DATE:$TIME "

################################# END OF ERROR CHECK #################################

    echo " $PROC_NAME --> Archive of $files started at $DATE:$TIME " 

    $SCRIPT_DIR/polling_dwnld_files_archive_process.sh "$files" 

    status=$?
    TIME=$(date +"%H%M%S")
    if [ $status -gt 0 ]
    then
        exit 1
    fi
    echo " $PROC_NAME --> File $files is archived under $ARCHIVEDIR at $DATE:$TIME "

################################# END OF ARCHIVE CHECK #################################

done

echo " $PROC_NAME --> Moving .REQUEST files completed at $DATE : $TIME "

exit 0