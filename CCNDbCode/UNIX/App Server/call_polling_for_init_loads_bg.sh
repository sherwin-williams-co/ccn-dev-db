#!/bin/sh
#####################################################################################
# Script name   : call_polling_for_init_loads_bg.sh
#
# Description   : This script is to call polling process for TERR, STORE and PARAM 
#               : inits on arrival of .queue and .queue_trgr files in the APP Server
# Created  : 08/17/2017 rxv940 CCN Project Team.....
# Modified : 10/03/2017 rxv940 CCN Project Team.....
#          : Removed the old way of using "|" to check for presence of 
#          : ".TRGRFILE".  
#####################################################################################

#Run below command to make the process run in the background even after shutdown
#nohup sh /app/ccn/scripts/call_polling_for_init_loads_bg.sh > /app/ccn/POSdownloads/log/call_polling_for_init_loads_bg.log 2>&1 &

#Below statement will be used to check if the process is running in the background
#ps -eaf | grep call_polling_for_init_loads_bg.sh

. /app/ccn/ccn_app_server.config
DATADIR="$HOME/POSdownloads/POSxmls"

while(true)
do

#Check for .queue and .queue_trgr files. If present, call ter_process_pos_polling_file.sh
if ls "$DATADIR/$CCD"*".queue" 1>/dev/null 2>&1 && ls "$DATADIR/$CCD"*".queue_trgrfile" 1>/dev/null 2>&1
then
    $SCRIPT_DIR/polling_archv_init_loads.sh
    exit 0
fi

done
