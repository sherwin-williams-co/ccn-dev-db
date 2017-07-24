#!/bin/sh
#####################################################################################
# Script name   : str_call_polling_bg.sh
#
# Description   : This script is to call polling process for Store 
#               : on the arrival of .XML and .POLLINGDONE files in the APP Server
# Created  : 07/03/2017 rxv940 CCN Project Team.....
# Modified :
#####################################################################################

#Run below command to make the process run in the background even after shutdown
#nohup sh /app/ccn/scripts/str_call_polling_bg.sh > /app/ccn/POSdownloads/log/str_call_polling_bg.log 2>&1 &

#Below statement will be used to check if the process is running in the background
#ps -eaf | grep str_call_polling_bg.sh

. /app/ccn/ccn.config
DATADIR="$HOME/POSdownloads/POSxmls"

while(true)
do

#Check for .POLLINGDONE files. If present, call str_process_pos_polling_file.sh
if [ "$(ls "$DATADIR/$STR_FILE_NAME"*".POLLINGDONE" 2>/dev/null | wc -l)" -gt 0 ]
then
    $SCRIPT_DIR/str_process_pos_polling_file.sh
fi

done
exit 1