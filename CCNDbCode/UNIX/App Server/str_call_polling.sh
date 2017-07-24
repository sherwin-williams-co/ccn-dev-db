#!/bin/sh
#####################################################################################
# Script name   : str_call_polling.sh
#
# Description   : This script is to call polling process for Store 
#               : on the arrival of .XML and .POLLINGDONE files in the APP Server
# Created  : 07/03/2017 rxv940 CCN Project Team.....
# Modified :
#####################################################################################

#Run below command to make the process run in the background even after shutdown
#nohup sh /app/ccn/scripts/str_call_polling.sh > /app/ccn/POSdownloads/log/str_call_polling.log 2>&1 &

#Below statement will be used to check if the process is running in the background
#ps -eaf | grep str_call_polling.sh

. /app/ccn/ccn.config

PROC_NAME="str_call_polling.sh"
DATADIR="$HOME/POSdownloads/POSxmls"
SCRIPTS="$HOME/scripts"

while(true)
do

#Check for .POLLINGDONE files. If present then call str_process_pos_polling_file.sh
if [ "$(ls "$DATADIR/StoreUpdate"*".POLLINGDONE" 2>/dev/null | wc -l)" -gt 0 ]
then

    DATE=$(date +"%d%m%Y")
    TIME=$(date +"%H%M%S")
    echo " $PROC_NAME --> call to str_process_pos_polling_file.sh started at $DATE : $TIME "

    ./str_process_pos_polling_file.sh

    TIME=$(date +"%H%M%S")
    echo " $PROC_NAME --> call to str_process_pos_polling_file.sh ended at $DATE : $TIME "

fi

done