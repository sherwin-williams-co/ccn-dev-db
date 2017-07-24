#!/bin/sh
###############################################################################################################################
# Script name   : polling_dwnld_files_archive_process.sh
# Description   : This script is to Archive Store files in db server. This runs on DB Server
#
# Created  : 07/10/2017 rxv940 CCN Project Team.....
# Modified : 
###############################################################################################################################

. /app/ccn/host.sh
PROC_NAME=polling_dwnld_files_archive_process.sh
ARCHIVEDIR="$HOME/datafiles/polling/archive"
ERRORDIR="$HOME/datafiles/polling/error"
DATADIR="$HOME"/datafiles
FILENAME=$1
DONEFILENAME=$2

cd $DATADIR || exit
mv {"$FILENAME","$DONEFILENAME"} "$ARCHIVEDIR" 
status=$?
DATE=`date +"%m/%d/%Y"`
TIME=$(date +"%H%M%S")
if [ "$status" -ne 0 ]
then
    $HOME/send_mail.sh "ARCHIVINGPROCESSFAILURE"
    echo " $PROC_NAME --> processing FAILED while archiving the files $FILENAME and $DONEFILENAME at $DATE:$TIME " 
    mv {"$FILENAME","$DONEFILENAME"} "$ERRORDIR"
    exit 1
fi
echo " $PROC_NAME -->  File $FILENAME and $DONEFILENAME are archived to $ARCHIVEDIR on $DATE:$TIME  "

exit 0

