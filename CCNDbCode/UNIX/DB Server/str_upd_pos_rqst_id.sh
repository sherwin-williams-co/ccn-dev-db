#!/bin/sh
############################################################################
# Script name : str_upd_pos_rqst_id.sh
# Description : This shell script will call call the DB proc to 
#               update the POS_DOWNLOADS table with request id
#
# Created  : 07/06/2017 rxv940 CCN Project ....
# Modified : 
#              
############################################################################
. /app/ccn/host.sh

PROC_NAME="str_upd_pos_rqst_id.sh"
DATADIR="$HOME"/datafiles
ARCHIVEDIR="$HOME"/datafiles/polling/archive
ERRORDIR="$HOME"/datafiles/polling/error

for files in "$DATADIR/StoreUpdate"*".REQUEST"
do

FILENAME=$(basename "$files" | sed -e 's/REQUEST/XML/g')
ERRORCHECK=$(cat $files | grep -c "Error")
DATE=$(date +"%d%m%Y")
TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Processing of Response file $FILENAME started and the errorcheck value is $ERRORCHECK at $DATE:$TIME "

if [ "$ERRORCHECK" -eq 0 ]
then
    
    REQUESTID=$(cat "$files")
    echo " $PROC_NAME --> The respnose in the response file $FILENAME is $REQUESTID "
    ./str_exec_pos_downloads_update.sh "$FILENAME" "$REQUESTID" 	
    status=$?
    TIME=$(date +"%H%M%S")
    
    if [ "$status" -gt 0 ]	
    then
        echo " $PROC_NAME -->The procedure POS_DATA_GENERATION.POS_DOWNLOADS_UPD_SP in exec_pos_downloads_update.sh execution failed at $DATE:$TIME "
        mv "$files" "$ERRORDIR"
        echo " $PROC_NAME --> The file $files is moved to the error folder $ERRORDIR at $DATE:$TIME "
        ./send_mail.sh "POLLING_FAILURE_MAIL" 
        exit 1
    else
        echo " $PROC_NAME --> Successfully processed the file $files and moving the file to the archive folder $ARCHIVEDIR at $DATE:$TIME "
        mv "$files" "$ARCHIVEDIR"
        
    fi
    
else

    ERRORMESSAGE=$(cat "$files")
    ./send_mail.sh "POLLING_FAILURE_MAIL" 
    TIME=$(date +"%H%M%S")
    echo " $PROC_NAME --> The response file $files has errors and the message is $ERRORMESSAGE at $DATE:$TIME "
    mv "$files" "$ERRORDIR"
    exit 1
fi
    
done

exit 0