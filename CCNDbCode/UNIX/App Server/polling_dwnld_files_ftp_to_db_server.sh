#!/bin/sh
###############################################################################################################################
# Script name   : polling_dwnld_files_ftp_to_db_server.sh
# Description   : This script is to FTP the files from app server to DB Server.
#
# Created  : 07/10/2017 rxv940 CCN Project Team.....
# Modified : 
###############################################################################################################################

. /app/ccn/ccn.config

PROC_NAME="polling_dwnld_files_ftp_to_db_server.sh"
FILENAME=$1
ERRORDIR="$HOME/POSdownloads/error"
DATADIR="$HOME/POSdownloads/POSxmls"
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
echo " $PROC_NAME --> Starting FTP to move $DATADIR/$FILENAME into ${CCNDBSERVDEST}/$FILENAME at $DATE:$TIME "

ftp -inv "${CCNDBSERVERHOST}" <<END_SCRIPT 
quote USER ${CCNDBUSERNAME}
quote PASS ${CCNDBPASSWORD}
put $DATADIR/$FILENAME ${CCNDBSERVDEST}/$FILENAME
quit
END_SCRIPT

    status=$?
    TIME=$(date +"%H%M%S")
    
    if [ $status -gt 0 ];
    then
        $SCRIPT_DIR/send_mail.sh "FTPFAILURE"
        echo " $PROC_NAME --> FTP failed when ftping the file $FILENAME at $DATE:$TIME "
        mv "$DATADIR/$FILENAME" "$ERRORDIR"
        echo " $PROC_NAME --> File $FILENAME is moved to $ERRORDIR at $DATE:$TIME "
        exit 1
    fi
    echo " $PROC_NAME --> status of ftp process is $status and the file is placed at $CCNDBSERVDEST at $DATE:$TIME "

echo " $PROC_NAME --> FTP process completed successfully at $DATE:$TIME "

exit 0