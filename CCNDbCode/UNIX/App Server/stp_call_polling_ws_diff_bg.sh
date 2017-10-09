#!/bin/sh
#####################################################################################
# Script name   : stp_call_polling_ws_diff_bg.sh
#
# Description   : This script is to call polling process for TERR, STORE and PARAM 
#               : inits on arrival of .queue and .ws_diff files in the APP Server
# Created  : 10/06/2017 rxv940 CCN Project Team.....
# Modified : 
#####################################################################################

#Run below command to make the process run in the background even after shutdown
#nohup sh /app/ccn/scripts/stp_call_polling_ws_diff_bg.sh > /app/ccn/POSdownloads/log/stp_call_polling_ws_diff_bg.log 2>&1 &

#Below statement will be used to check if the process is running in the background
#ps -eaf | grep stp_call_polling_ws_diff_bg.sh

. /app/ccn/ccn_app_server.config
DATADIR="$HOME/POSdownloads/POSxmls"

while(true)
do

#Check for .queue and .ws_diff files. If present, call ter_process_pos_polling_file.sh
if ls "$DATADIR/$CCD".queue 1>/dev/null 2>&1 && ls "$DATADIR/$CCD".ws_diff 1>/dev/null 2>&1
then
    $SCRIPT_DIR/stp_call_polling_ws_diff_prcs.sh
fi

done
exit 1