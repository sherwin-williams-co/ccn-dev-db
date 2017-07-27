#!/bin/sh
############################################################################
# Script name : gl_ps_upd_pos_rqst_id.sh
# Description : This shell script will call call the DB proc to 
#               update the POS_DOWNLOADS table with request id
#
# Created  : 07/06/2017 rxv940 CCN Project ....
# Modified : 
#              
############################################################################
. /app/ccn/host.sh

PROC_NAME="gl_ps_upd_pos_rqst_id.sh"
DATADIR="$HOME"/datafiles
ARCHIVEDIR="$HOME"/datafiles/polling/archive
ERRORDIR="$HOME"/datafiles/polling/error
DATE=$(date +"%d%m%Y")
TIME=$(date +"%H%M%S")

echo " $PROC_NAME --> Process started at $DATE:$TIME "

for files in "$DATADIR/$GL_PS_FILE_NAME"*".REQUEST"
do

FILENAME=$(basename "$files" | sed -e 's/REQUEST/XML/g')
ERRORCHECK=$(cat $files | grep -c "Error")
TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Processing of Response file $FILENAME started and the errorcheck value is $ERRORCHECK at $DATE:$TIME "

if [ "$ERRORCHECK" -eq 0 ]
then
    
    REQUESTID=$(cat "$files")
    echo " $PROC_NAME --> The respnose in the response file $FILENAME is $REQUESTID "
    ./gl_ps_exec_pos_downloads_update.sh "$FILENAME" "$REQUESTID" 	
    status=$?
    TIME=$(date +"%H%M%S")
    
    if [ "$status" -gt 0 ]	
    then
        echo " $PROC_NAME -->The procedure POS_DATA_GENERATION.POS_DOWNLOADS_UPD_SP in exec_pos_downloads_update.sh execution failed at $DATE:$TIME "
        mv "$files" "$ERRORDIR"
        echo " $PROC_NAME --> The file $files is moved to the error folder $ERRORDIR at $DATE:$TIME "
        exit 1
    else
        echo " $PROC_NAME --> Successfully processed the file $files and moving the file to the archive folder $ARCHIVEDIR at $DATE:$TIME "
        mv "$files" "$ARCHIVEDIR"
        
    fi
    
else

    ERRORMESSAGE=$(cat "$files")
    ./send_mail.sh "POLLING_FAILURE_MAIL" "The response file $files has errors. The message is $ERRORMESSAGE."
    TIME=$(date +"%H%M%S")
    echo " $PROC_NAME --> The response file $files has errors and the message is $ERRORMESSAGE at $DATE:$TIME "
    mv "$files" "$ERRORDIR"
    exit 1
fi
    
done

echo " $PROC_NAME --> Process completed successfully at $DATE:$TIME "

exit 0