#!/bin/sh
###############################################################################################################################
# Script name   : polling_dwnld_files_ftp_to_app_server.sh
# Description   : This script is a common script to FTP from db server to app server. This runs on DB Server
#
# Created  : 07/10/2017 rxv940 CCN Project Team.....
# Modified : 
###############################################################################################################################

. /app/ccn/host.sh
PROC_NAME=polling_dwnld_files_ftp_to_app_server.sh
ERRORDIR="$HOME/datafiles/polling/error"
DATADIR="$HOME"/datafiles
FILENAME=$1
DONEFILENAME=$2

cd $DATADIR || exit

ftp -inv "${CCNAPPSERVER_HOST}"<<END_SCRIPT
quote USER ${CCNAPPSERVER_USERNAME}
quote PASS ${CCNAPPSERVER_PASSWORD}
cd ${CCNAPPSERVER_DEST}
mput $FILENAME $DONEFILENAME 
quit
END_SCRIPT

DATE=`date +"%m/%d/%Y"`
status=$?
TIME=$(date +"%H%M%S")
if [ $status -gt 0 ]
then
    $HOME/send_mail.sh "FTPFAILURE" "FTP failure while FTP'ing file $FILENAME and $DONEFILENAME to APP Server"
    echo " $PROC_NAME -->  processing FAILED while ftping the files $FILENAME and $DONEFILENAME at $DATE:$TIME "
    mv {"$FILENAME","$DONEFILENAME"} "$ERRORDIR"
    exit 1
fi

echo " $PROC_NAME -->  Files $FILENAME and $DONEFILENAME are transferred to the app server $CCNAPPSERVER_HOST, $CCNAPPSERVER_DEST on $DATE:$TIME "

exit 0