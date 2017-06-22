#!/bin/sh
###############################################################################################################################
# Script name   : update_posdownloads_request_id.sh
#
# Description   : This script is to update the request_ids in the pos_downloads table.
#
# Created  : 01/10/2017 mxk766 CCN Project Team.....
# Modified : 04/18/2017 rxv940 CCN Project Team.....
#          : Added DEQ_FILE variable and move it to archive at the end of the process 
# Modified : 06/15/2017 rxv940 CCN Project Team....
#          : Added exit condition after error gets emailed 
###############################################################################################################################

. /app/ccn/host.sh
#ps -eaf | grep update_posdownloads_request_id.sh
#nohup sh /app/ccn/dev/update_posdownloads_request_id.sh > /app/ccn/dev/datafiles/log/update_posdownloads_request_id.log 2>&1 & 

PROC_NAME="update_posdownloads_request_id.sh"
DATADIR="$HOME"/datafiles
ARCHIVEDIR="$HOME/datafiles/polling/archive"
ERRORDIR="$HOME/datafiles/polling/error"

while(true)
do

#Check for .REQUEST files. If present then move them to the DB Server and also archive those files.
if [ $(ls "$DATADIR/"*".REQUEST" 2>/dev/null | wc -l) -gt 0 ]
then

    DATE=$(date +"%d%m%Y")
    TIME=$(date +"%H%M%S")

    for files in "$DATADIR/"*".REQUEST"
    do
    
    #Read the file.
    FILENAME=$(basename "$files" | sed -e 's/REQUEST/XML/g')
    echo " $PROC_NAME --> Processing of Response file $FILENAME started at $DATE and $TIME "
    #Check whether it has got any errors or not.
    ERRORCHECK=$(cat $files | grep -c "Error")
    echo " Checking for errors in $files is $ERRORCHECK at $DATE $TIME " 
    if [ "$ERRORCHECK" -eq 0 ]
    then
        REQUESTID=$(cat "$files")
        #call the update proc.
        echo " $PROC_NAME --> The respnose in the response file $FILENAME is $REQUESTID "
        ./exec_pos_downloads_update.sh "$FILENAME" "$REQUESTID" 
        status=$?
        
        if [ "$status" -gt 0 ]
        then
            #send an Error email.
            echo " $PROC_NAME -->The procedure POS_DATA_GENERATION.POS_DOWNLOADS_UPD_SP in exec_pos_downloads_update.sh execution failed at $DATE $TIME "
            echo " $PROC_NAME --> Moving the file $files to the error folder $ERRORDIR at $DATE $TIME "
            mv "$files" "$ERRORDIR"
        
            ./send_mail.sh "POLLING_FAILURE_MAIL" 
            exit 1
        
        else
            echo " $PROC_NAME --> Successfully processed the file $files and moving the file to the archive folder $ARCHIVEDIR at $DATE $TIME "
            mv "$files" "$ARCHIVEDIR"
        
        fi
    
    else
        #error in the processing of the java class.
        #Moving the file to archive dir
        ERRORMESSAGE=$(cat "$files")
        echo " $PROC_NAME --> The response file $files has errors and the message is $ERRORMESSAGE at $DATE $TIME "
        ./send_mail.sh "POLLING_FAILURE_MAIL" 
        echo " $PROC_NAME --> The response file $files has errors and the message is $ERRORMESSAGE at $DATE $TIME "
        mv "$files" "$ARCHIVEDIR"
        exit 1
    fi
    
    done

fi

done
