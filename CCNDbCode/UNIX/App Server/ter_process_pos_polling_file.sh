#!/bin/sh
###############################################################################################################################
# Script name   : ter_process_pos_polling_file.sh
# Description   : This script is to process TERR polling files that moved to app server and send it to polling.
#
# Created  : 07/03/2017 rxv940 CCN Project Team.....
# Modified : 
###############################################################################################################################

. /app/ccn/ccn_app_server.config

PROC_NAME="ter_process_pos_polling_file.sh"
DATADIR="$HOME/POSdownloads/POSxmls"
CLASSHOME="$HOME/POSdownloads/java"
DATE=$(date +"%d%m%Y")
TIME=$(date +"%H%M%S")

echo " $PROC_NAME --> Call to get the requestid started at $DATE : $TIME "

for files in "$DATADIR/$TER_FILE_NAME"*".POLLINGDONE"
do
    #Identify the XMLFILES, REQUESTFILES from the POLLINGDONE file.
    FILENAME="${files//POLLINGDONE/XML}"
    REQUESTNAME="$(basename "${FILENAME//XML/REQUEST}")"
    TIME="$(date +"%H%M%S")"

    echo " $PROC_NAME --> Sending files to Polling started at $DATE:$TIME " 
    echo " $PROC_NAME --> Request file name is $REQUESTNAME at $DATE:$TIME " 
    
    cd "$CLASSHOME" || exit
    REQUESTID=$(java com.webservice.PollingRequest "$TERRUSERNAME" "$TERRPASSWORD" "$TERRENVIRONMENT" "$FILENAME" "$ENVIRON") 

###################################### ERROR HANDLING ##########################################

    if  [[ "$REQUESTID" == *"Invalid Number of arguments passed."* ]] || 
        [[ "$REQUESTID" == *"Exception"* ]] || 
        [[ "$REQUESTID" == *"Invalid file path provided."* ]] || 
        [[ "$REQUESTID" == *"Error"* ]];
    then    
        $SCRIPT_DIR/polling_dwnld_files_error_rqst_id.sh $files $FILENAME $REQUESTID
    else 
        $SCRIPT_DIR/polling_dwnld_files_process_rqst_id.sh $files $FILENAME $REQUESTNAME $REQUESTID
    fi
	
done
TIME="$(date +"%H%M%S")"
echo " $PROC_NAME --> Call to get the requestid ended at $DATE : $TIME "
exit 0