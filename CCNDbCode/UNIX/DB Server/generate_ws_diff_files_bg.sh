#!/bin/sh
#################################################################
# Script name   : generate_ws_diff_files_bg.sh
# Description   : This shell script will call the script to  
#                 produce the ws diff files for store, terr and Param 
# Created       : 10/06/0217  rxv940 CCN Project Team.....
# Modified      : 
#################################################################

#nohup sh /app/ccn/dev/generate_ws_diff_files_bg.sh > /app/ccn/dev/datafiles/log/generate_ws_diff_files_bg.log 2>&1 &
#ps -eaf | grep generate_ws_diff_files_bg.sh

. /app/ccn/host.sh
DATADIR=$HOME/datafiles
while(true)
do

if ls "$DATADIR/STORE_CCD_LIST.ws_diff" 1>/dev/null 2>&1 && ls "$DATADIR/TERR_CCD_LIST.ws_diff" 1>/dev/null 2>&1 && ls "$DATADIR/PARAM_CCD_LIST.ws_diff" 1>/dev/null 2>&1
then
    $HOME/stp_ws_diff_init_loads.sh 
fi

done
exit 1
