#!/bin/bash
###############################################################################################################################
# Script name   : str_process_pos_polling_file.sh
# Description   : This script is to process Store polling files that moved to app server and send it to polling.
#
# Created  : 07/03/2017 rxv940 CCN Project Team.....
# Modified : 
###############################################################################################################################

. /app/ccn/ccn.config

PROC_NAME="str_process_pos_polling_file.sh"
DATADIR="$HOME/POSdownloads/POSxmls"
ERRORDIR="$HOME/POSdownloads/error"
ARCHIVEDIR="$HOME/POSdownloads/POSxmls/archivefiles"
CLASSHOME="$HOME/POSdownloads/java"
DATE=$(date +"%d%m%Y")
TIME=$(date +"%H%M%S")
DEQ_FILE="$DATADIR/COST_CENTER_DEQUEUE.queue"

for files in "$DATADIR/StoreUpdate"*".POLLINGDONE"
do
    #Identify the XMLFILES, REQUESTFILES from the POLLINGDONE file.
    DONEFILENAME="$files"   
    FILENAME="${DONEFILENAME//POLLINGDONE/XML}"
    REQUESTNAME="$(basename "${FILENAME//XML/REQUEST}")"
    TIME="$(date +"%H%M%S")"

    echo " $PROC_NAME --> Sending files to Polling started at $DATE:$TIME " 
    echo " $PROC_NAME --> Request file name is $REQUESTNAME at $DATE:$TIME " 
    
    cd "$CLASSHOME" || exit
    REQUESTID=$(java com.webservice.PollingRequest "$STOREUSERNAME" "$STOREPASSWORD" "$STOREENVIRONMENT" "$FILENAME" "$ENVIRON") 
    cd "$HOME" || exit

###################################### ERROR HANDLING ##########################################
    
    TIME="$(date +"%H%M%S")"
    if  [[ "$REQUESTID" == *"Invalid Number of arguments passed."* ]] || 
        [[ "$REQUESTID" == *"Exception"* ]] || 
        [[ "$REQUESTID" == *"Invalid file path provided."* ]] || 
        [[ "$REQUESTID" == *"Error"* ]];
    then
    
        #Call the email mechansim to report the issue. Pass the file name and the error message that occurs while executing and Moving the XML and POLLINGDONE files to the error directory.
        echo " $PROC_NAME --> Polling class PollingRequest failed while processing file: $FILENAME %s\n" "Error returned by class com.webservice.PollingRequest is $REQUESTID at $DATE:$TIME "				
        mv {"$files","$FILENAME"} "$ERRORDIR"
        echo " $PROC_NAME -->  Polling process failed so moving $FILENAME and $files to error directory $ERRORDIR at $DATE:$TIME. "
        #Move the DEQ file to error, if present
        if [ -s "$DEQ_FILE" ]
        then
            mv "$DEQ_FILE" "$ERRORDIR"
            echo " $PROC_NAME --> $DEQ_FILE is also moved to $ERRORDIR at $DATE:$TIME" 
        fi 
        ./scripts/send_mail.sh "RequestidFailure" 
        exit 1

    else

        #No issues so generating an requestid file and also archive the processed files.
        echo "$REQUESTID" > "$DATADIR/$REQUESTNAME" 
        echo " $PROC_NAME --> Created a REQUEST file $DATADIR/$REQUESTNAME at $DATE:$TIME "

        mv {"$files","$FILENAME"} "$ARCHIVEDIR"
        
        status=$?
        TIME="$(date +"%H%M%S")"
        if [ "$status" -gt 0 ]
        then
            if [ -s "$DEQ_FILE" ]
            then
                mv "$DEQ_FILE" "$ERRORDIR"
                echo " $PROC_NAME --> $DEQ_FILE moved to $ERRORDIR at $DATE:$TIME "
            fi
        
            echo " $PROC_NAME --> Moving of files to the archive directory failed at $DATE:$TIME ."
            ./scripts/send_mail.sh "ARCHIVINGPROCESSFAILURE"
            exit 1
        else
            echo " $PROC_NAME --> Archiving of $files and $FILENAME to $ARCHIVEDIR done at $DATE:$TIME." 
        fi

    fi

done

exit 0
