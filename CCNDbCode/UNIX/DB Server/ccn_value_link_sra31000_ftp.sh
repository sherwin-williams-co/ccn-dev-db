#!/bin/sh
###############################################################################################################################
# Script name   : ccn_value_link_sra31000_ftp.sh
# Description   : This script will FTP VALUELINK FILE from db server to app server. This runs on DB Server
#
# Created  : 10/31/2017 rxv940 CCN Project Team.....
# Modified : 
###############################################################################################################################
. /app/ccn/host.sh

DATE=`date +"%m%d%y"`
PROC_NAME=ccn_value_link_sra31000_ftp.sh
DATADIR="$HOME"/datafiles
FILENAME=SRA31000_${DATE}.TXT

ftp -inv "${CCNAPPSERVER_HOST}"<<END_SCRIPT
quote USER ${CCNAPPSERVER_USERNAME}
quote PASS ${CCNAPPSERVER_PASSWORD}
put $DATADIR/$FILENAME ${SRA31000_APP_SRVR_PATH}/SRA31000
quit
END_SCRIPT

status=$?
TIME=$(date +"%H%M%S")
if [ $status -gt 0 ]
then
    $HOME/send_mail.sh "VALUELINK_FILE_FAILURE" 
    echo " $PROC_NAME -->  processing FAILED while ftping the files VALUELINK_SRA31000 at $DATE:$TIME "
       exit 1
fi

echo " $PROC_NAME -->  Files $FILENAME  are transferred to the app server on $DATE:$TIME "

exit 0

