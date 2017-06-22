#!/bin/bash
###############################################################################################################################
# Script name   : process_pos_polling_file.sh
#
# Description   : This script is to process polling files that moved from db server to app server and send it to polling.
#
# Created  : 01/10/2017 mxk766 CCN Project Team.....
# Modified : 03/06/2017 rxv940 CCN Project Team ....
#            Changes to reflect the new directory structures. Changes done in path computation variables
# Modified : 04/17/2017 rxv940 CCN Project Team.....
#            Added DEQ_FILE and moving it to error/ archive as needed 
###############################################################################################################################
# shellcheck disable=SC1091


#Run below command to make the process run in the background even after shutdown
#nohup sh /app/ccn/scripts/process_pos_polling_file.sh > /app/ccn/POSdownloads/log/process_pos_polling_file.log 2>&1 &

#Below statement will be used to check if the process is running in the background
#ps -eaf | grep process_pos_polling_file.sh

. /app/ccn/ccn.config

PROC_NAME="process_pos_polling_file.sh"
DATADIR="$HOME/POSdownloads/POSxmls"
ERRORDIR="$HOME/POSdownloads/error"
ARCHIVEDIR="$HOME/POSdownloads/POSxmls/archivefiles"
DATE=$(date +"%d%m%Y")
TIME=$(date +"%H%M%S")
CLASSHOME="$HOME/POSdownloads/java"

while(true)
do

#Check for .POLLINGDONE files. If present then process all the xml and send the file to the java class file.
#Check for the existence of the POLLINGDONE file. If present the loop through the files.
if [ "$(ls "$DATADIR/"*".POLLINGDONE" 2>/dev/null | wc -l)" -gt 0 ];
then

DATE=$(date +"%d%m%Y")
TIME="$(date +"%H%M%S")"
DEQ_FILE="$DATADIR/COST_CENTER_DEQUEUE.queue"

for files in "$DATADIR/"*".POLLINGDONE"
do
    #Identify the XMLFILES, REQUESTFILES from the POLLINGDONE file.
    DONEFILENAME="$files"   
    FILENAME="${DONEFILENAME//POLLINGDONE/XML}"
    REQUESTNAME="$(basename "${FILENAME//XML/REQUEST}")"
    
    #Create a log file.
    
    echo " $PROC_NAME --> Sending files to Polling started at $DATE $TIME " 
    echo " $PROC_NAME --> Request file name is $REQUESTNAME at $DATE $TIME " 
    
    #Check for file type and deceide on the environment.
    if [ "$(echo "$REQUESTNAME" | grep -c "StoreUpdate")" -gt 0 ]
    then      
        POLLINGUSERNAME="$STOREUSERNAME"
        POLLINGPASSWORD="$STOREPASSWORD"
        POLLINGENVIRONMENT="$STOREENVIRONMENT"
    elif [ "$(echo "$REQUESTNAME" | grep -c "TerritoryUpdate")" -gt 0 ]
    then
        POLLINGUSERNAME="$TERRUSERNAME"
        POLLINGPASSWORD="$TERRPASSWORD"
        POLLINGENVIRONMENT="$TERRGENVIRONMENT"
    elif [ "$(echo "$REQUESTNAME" | grep -c "ParamUpdate")" -gt 0 ]
    then
        FLG="Y"
        echo " $PROC_NAME -->  $DEQ_FILE is the Dequeue file and the FLG value is $FLG " 
        POLLINGUSERNAME="$PARAMUSERNAME"
        POLLINGPASSWORD="$PARAMPASSWORD"
        POLLINGENVIRONMENT="$PARAMENVIRONMENT"
    elif [ "$(echo "$REQUESTNAME" | grep -c "PrimeSubUpdate")" -gt 0 ]
    then
        POLLINGUSERNAME="$PRIMESUBUSERNAME"
        POLLINGPASSWORD="$PRIMESUBPASSWORD"
        POLLINGENVIRONMENT="$PRIMESUBENVIRONMENT"
    
    fi
    
    #Go the class file path and call the java method by passing the required parameters
    cd "$CLASSHOME" || exit
    #Take the file and pass it to the java class.
    
    REQUESTID=$(java com.webservice.PollingRequest "$POLLINGUSERNAME" "$POLLINGPASSWORD" "$POLLINGENVIRONMENT" "$FILENAME" "$ENVIRON") 
    
    #After execution of the java class file go to the home directory and check for the polling response.
    cd "$HOME" || exit
    
    #If the response has errors, then log the error and move it to the error folder.
    if  [[ "$REQUESTID" == *"Invalid Number of arguments passed."* ]] || 
        [[ "$REQUESTID" == *"Exception"* ]] || 
        [[ "$REQUESTID" == *"Invalid file path provided."* ]] || 
        [[ "$REQUESTID" == *"Error"* ]];
    then
    
        #Call the email mechansim to report the issue. Pass the file name and the error message that occurs while executing.
        echo " $PROC_NAME --> Polling class PollingRequest failed while processing file: $FILENAME %s\n" "Error returned by class com.webservice.PollingRequest is $REQUESTID at $DATE $TIME "				
        echo " $PROC_NAME -->  Polling process failed so moving $FILENAME and $files to error directory $ERRORDIR at $DATE $TIME. "
        
        #Moving the XML and PROSSINGDONE files to the error directory.
        mv {"$files","$FILENAME"} "$ERRORDIR"
        #Move the DEQ file to error, if present
        if [ -s "$DEQ_FILE" ]
        then
            mv "$DEQ_FILE" "$ERRORDIR"
            echo " $PROC_NAME --> $DEQ_FILE moved to $ERRORDIR at $DATE $TIME" 
        fi 
        ./scripts/send_mail.sh "RequestidFailure" 
        exit 1

    else

        #No issues so generating an requestid file and also archive the processed files.
        echo " $PROC_NAME --> Processing done for $REQUESTNAME and Request Id is :REQUESTID at $DATE $TIME" 
        echo "$REQUESTID" > "$DATADIR/$REQUESTNAME" 
        echo " $PROC_NAME --> Created a REQUEST file $DATADIR/$REQUESTNAME at $DATE $TIME "
		
        echo " $PROC_NAME --> Moving files $files and $FILENAME to archive directory $ARCHIVEDIR at $DATE $TIME "
        mv {"$files","$FILENAME"} "$ARCHIVEDIR"
        status=$?

        if [ "$status" -gt 0 ]
        then
            if [ -s "$DEQ_FILE" ]
            then
                mv "$DEQ_FILE" "$ERRORDIR"
                echo " $PROC_NAME --> $DEQ_FILE moved to $ERRORDIR at $DATE $TIME "
            fi
        
            echo " $PROC_NAME --> Moving of files to the archive directory failed. Emailing the error log at $DATE $TIME ."
            ./scripts/send_mail.sh "ARCHIVINGPROCESSFAILURE"
            exit 1
        else
            echo " $PROC_NAME --> Archiving of $files and $FILENAME to $ARCHIVEDIR Done at $DATE $TIME." 
        fi

    fi

done

fi
    if [ "$FLG" == "Y" ] && [ -s "$DEQ_FILE" ]
    then 
        mv "$DEQ_FILE" "$ARCHIVEDIR"
        echo " $PROC_NAME --> $DEQ_FILE moved to $ARCHIVEDIR at $DATE $TIME " 
        FLG="N" 
    fi
done
