#!/bin/sh
###############################################################################################################################
# Script name   : mv_posfiles_from_dbserver_to_appserver.sh
#
# Description   : This script is to transfer files from db server to app server.
#
# Created  : 01/10/2017 mxk766 CCN Project Team.....
# Modified : 04/17/2017 rxv940 CCN Project Team.....
#          : Added more comments, indents which is helpful during debugging
###############################################################################################################################
# shellcheck disable=SC1091
#nohup sh /app/ccn/dev/mv_posfiles_from_dbserver_to_appserver.sh > /app/ccn/dev/datafiles/log/mv_posfiles_from_dbserver_to_appserver.log 2>&1 &
# ps -eaf | grep mv_posfiles_from_dbserver_to_appserver.sh

. /app/ccn/host.sh
PROC_NAME=mv_posfiles_from_dbserver_to_appserver.sh
DATADIR="$HOME"/datafiles
ARCHIVEDIR="$HOME/datafiles/polling/archive"



while(true)
do

#Check for .POLLINGDONE files. If present.
if [ $(ls "$DATADIR/"*".POLLINGDONE" 2>/dev/null | wc -l) -gt 0 ];
then

    cd "$DATADIR" || exit
    DATE=$(date +"%d%m%Y")
    TIME=$(date +"%H%M%S")

    for files in *".POLLINGDONE"
    do

        #FTP files from ccn db server to ccn app server
        FILENAME=$(echo "$files" | sed -e 's/POLLINGDONE/XML/g')
        DONEFILENAME=$files

        #Add a check to make sure that we have the XML File. If it there then only execute the below code.
        echo " $PROC_NAME --> FTPing of file $FILENAME and $DONEFILENAME started at $DATE $TIME " 

ftp -inv "${CCNAPPSERVER_HOST}"<<END_SCRIPT
quote USER ${CCNAPPSERVER_USERNAME}
quote PASS ${CCNAPPSERVER_PASSWORD}
cd ${CCNAPPSERVER_DEST}
mput $FILENAME $DONEFILENAME 
quit
END_SCRIPT


        status=$?
        if [ $status -gt 0 ]
        then
            echo " $PROC_NAME -->  processing FAILED while ftping the file $FILENAME and $DONEFILENAME at $TIME on $DATE"
			cd "$HOME" || exit
            ./send_mail.sh "FTPFAILURE" 
            exit 1
        fi
        echo " $PROC_NAME --> FTPing of file $FILENAME and $DONEFILENAME Done at $DATE $TIME "

        TIME=$(date +"%H%M%S")
        echo " $PROC_NAME -->  File $FILENAME and $DONEFILENAME transferred to the app server $CCNAPPSERVER_HOST, $CCNAPPSERVER_DEST, at $TIME on $DATE "
        echo " $PROC_NAME -->  File $FILENAME and $DONEFILENAME is archived to $ARCHIVEDIR on $DATE $TIME  "
        mv {"$FILENAME","$DONEFILENAME"} "$ARCHIVEDIR" 

        status=$?
        if [ "$status" -ne 0 ]
        then
            TIME=$(date +"%H:%M:%S")
            echo " $PROC_NAME --> processing FAILED while archiving the file $FILENAME and $DONEFILENAME at ${TIME} on ${DATE}" 
			cd "$HOME" || exit
            ./send_mail.sh "ARCHIVINGPROCESSFAILURE"
            exit 1
        fi

    done

fi   

done
