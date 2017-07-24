#!/bin/sh
#####################################################################################
# Script name   : ter_call_polling_bg.sh
#
# Description   : This script is to call polling process for TERR 
#               : on the arrival of .XML and .POLLINGDONE files in the APP Server
# Created  : 07/03/2017 rxv940 CCN Project Team.....
# Modified :
#####################################################################################

#Run below command to make the process run in the background even after shutdown
#nohup sh /app/ccn/scripts/ter_call_polling_bg.sh > /app/ccn/POSdownloads/log/ter_call_polling_bg.log 2>&1 &

#Below statement will be used to check if the process is running in the background
#ps -eaf | grep ter_call_polling_bg.sh

. /app/ccn/ccn.config
DATADIR="$HOME/POSdownloads/POSxmls"

while(true)
do

#Check for .POLLINGDONE files. If present, call ter_process_pos_polling_file.sh
if [ "$(ls "$DATADIR/$TER_FILE_NAME"*".POLLINGDONE" 2>/dev/null | wc -l)" -gt 0 ]
then
    $SCRIPT_DIR/ter_process_pos_polling_file.sh
fi

done
exit 1