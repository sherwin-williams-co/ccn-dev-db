#!/bin/sh
###############################################################################################################################
# Script name   : gl_ps_mv_posfiles_to_app_server.sh
# Description   : This script is to transfer PrimeSub files from db server to app server.
#
# Created  : 07/03/2017 rxv940 CCN Project Team.....
# Modified : 
###############################################################################################################################

. /app/ccn/host.sh
PROC_NAME=gl_ps_mv_posfiles_to_app_server.sh
DATADIR="$HOME"/datafiles
DATE=$(date +"%d%m%Y")
TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Process started at $DATE:$TIME " 
cd "$DATADIR" || exit

for files in $GL_PS_FILE_NAME*".POLLINGDONE"
do
    FILENAME=$(echo "$files" | sed -e 's/POLLINGDONE/XML/g')
    DONEFILENAME=$files
    
    if [ POLLING_FTP_FLAG=="Y" ]
    then
        TIME=$(date +"%H%M%S")
        echo " $PROC_NAME --> FTPing of file $FILENAME and $DONEFILENAME started at $DATE:$TIME " 
        $HOME/polling_dwnld_files_ftp_to_app_server.sh "$FILENAME" "$DONEFILENAME"

        status=$?
        TIME=$(date +"%H%M%S")
        if [ "$status" -ne 0 ]
        then
            echo " $PROC_NAME --> processing FAILED while FTP'ing the files $FILENAME and $DONEFILENAME at $DATE:$TIME " 
            exit 1
        fi
            
        echo " $PROC_NAME --> FTPing of file $FILENAME and $DONEFILENAME completed at $DATE:$TIME " 
    fi 

    echo " $PROC_NAME --> Archiving of files $FILENAME and $DONEFILENAME started at $DATE:$TIME " 

    $HOME/polling_dwnld_files_db_server_archive_process.sh "$FILENAME" "$DONEFILENAME"
    status=$?
    TIME=$(date +"%H%M%S")
    if [ "$status" -ne 0 ]
    then
        echo " $PROC_NAME --> processing FAILED while archiving the files $FILENAME and $DONEFILENAME at $DATE:$TIME " 
        exit 1
    fi
    
    echo " $PROC_NAME --> Archiving of files $FILENAME and $DONEFILENAME completed at $DATE:$TIME " 

done
echo " $PROC_NAME --> Process completed at $DATE:$TIME " 
exit 0
