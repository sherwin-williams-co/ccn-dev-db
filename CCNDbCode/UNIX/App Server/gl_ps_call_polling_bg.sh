#!/bin/sh
#####################################################################################
# Script name   : gl_ps_call_polling_bg.sh
#
# Description   : This script is to call polling process for PrimeSub 
#               : on the arrival of .XML and .POLLINGDONE files in the APP Server
# Created  : 07/03/2017 rxv940 CCN Project Team.....
# Modified : 
#####################################################################################

#Run below command to make the process run in the background even after shutdown
#nohup sh /app/ccn/scripts/gl_ps_call_polling_bg.sh > /app/ccn/POSdownloads/log/gl_ps_call_polling_bg.log 2>&1 &

#Below statement will be used to check if the process is running in the background
#ps -eaf | grep gl_ps_call_polling_bg.sh

. /app/ccn/ccn_app_server.config
DATADIR="$HOME/POSdownloads/POSxmls"

while(true)
do

#Check for .POLLINGDONE files. If present, call gl_ps_process_pos_polling_file.sh
if [ ! -f "$DATADIR/$CCD"*".queue" ] && [ -f "$DATADIR/$GL_PS_FILE_NAME"*".POLLINGDONE" ] 
then
    $SCRIPT_DIR/gl_ps_process_pos_polling_file.sh
fi

done
exit 1
