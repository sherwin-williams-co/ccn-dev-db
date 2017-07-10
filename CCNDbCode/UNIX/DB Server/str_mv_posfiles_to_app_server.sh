#!/bin/sh
###############################################################################################################################
# Script name   : str_mv_posfiles_to_app_server.sh
# Description   : This script is to transfer Store files from db server to app server.
#
# Created  : 07/03/2017 rxv940 CCN Project Team.....
# Modified : 
###############################################################################################################################

. /app/ccn/host.sh
PROC_NAME=str_mv_posfiles_to_app_server.sh
DATADIR="$HOME"/datafiles
ARCHIVEDIR="$HOME/datafiles/polling/archive"
ERRORDIR="$HOME/datafiles/polling/error"

cd "$DATADIR" || exit

for files in "StoreUpdate"*".POLLINGDONE"
do
    FILENAME=$(echo "$files" | sed -e 's/POLLINGDONE/XML/g')
    DONEFILENAME=$files
    DATE=$(date +"%d%m%Y")
    TIME=$(date +"%H%M%S")

    echo " $PROC_NAME --> FTPing of file $FILENAME and $DONEFILENAME started at $DATE:$TIME " 

ftp -inv "${CCNAPPSERVER_HOST}"<<END_SCRIPT
quote USER ${CCNAPPSERVER_USERNAME}
quote PASS ${CCNAPPSERVER_PASSWORD}
cd ${CCNAPPSERVER_DEST}
mput $FILENAME $DONEFILENAME 
quit
END_SCRIPT


    status=$?
    TIME=$(date +"%H%M%S")
    if [ $status -gt 0 ]
    then
        echo " $PROC_NAME -->  processing FAILED while ftping the files $FILENAME and $DONEFILENAME at $DATE:$TIME "
        mv {"$FILENAME","$DONEFILENAME"} "$ERRORDIR"
        cd "$HOME" || exit
        ./send_mail.sh "FTPFAILURE" 
        exit 1
    fi
    echo " $PROC_NAME -->  Files $FILENAME and $DONEFILENAME are transferred to the app server $CCNAPPSERVER_HOST, $CCNAPPSERVER_DEST on $DATE:$TIME "
        
################################################## END OF ERROR CHECK FOR FTP ##################################################

    mv {"$FILENAME","$DONEFILENAME"} "$ARCHIVEDIR" 
    status=$?
    TIME=$(date +"%H%M%S")
    if [ "$status" -ne 0 ]
    then
        echo " $PROC_NAME --> processing FAILED while archiving the file $FILENAME and $DONEFILENAME at $DATE:$TIME " 
        mv {"$FILENAME","$DONEFILENAME"} "$ERRORDIR"
        cd "$HOME" || exit
        ./send_mail.sh "ARCHIVINGPROCESSFAILURE"
        exit 1
    fi
    echo " $PROC_NAME -->  File $FILENAME and $DONEFILENAME is archived to $ARCHIVEDIR on $DATE:$TIME  "

################################################## END OF ARCHIVING CHECK ##################################################

done

exit 0
