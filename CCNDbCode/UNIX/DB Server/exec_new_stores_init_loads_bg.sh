#!/bin/sh
#################################################################
# Script name   : exec_new_stores_init_loads_bg.sh
# Description   : This shell script will call the script to  
#                 produce the init loads for store, terr and Param 
# Created       : rxv940 CCN Project Team.....
# Modified      : rxv940 CCN Project Team.....
#               : Added code to archive ".queue_trgrfile"
# Modified      : 10/03/2017  rxv940 CCN Project Team.....
#               : Removed the old way of using "|" to check for presence of 
#               : ".TRGRFILE". 
#################################################################

#nohup sh /app/ccn/dev/exec_new_stores_init_loads_bg.sh > /app/ccn/dev/datafiles/log/exec_new_stores_init_loads_bg.log 2>&1 &
#ps -eaf | grep exec_new_stores_init_loads_bg.sh
. /app/ccn/host.sh
DATADIR=$HOME/datafiles
ARCHIVEDIR=$DATADIR/polling/archive

while(true)
do

if ls "$DATADIR/$CCD"*".TRGRFILE" 1>/dev/null 2>&1
then
    mv "$DATADIR/$CCD.TRGRFILE" "$ARCHIVEDIR"
    $HOME/call_to_init_loads_sql.sh
    echo "Trigger file to denote the completion of Init loads. " > "$DATADIR/$CCD.queue_trgrfile"
    $HOME/polling_dwnld_files_ftp_to_app_server.sh "$CCD.queue_trgrfile"
    mv "$DATADIR/$CCD.queue_trgrfile" "$ARCHIVEDIR"
fi

done
exit 1
