#!/bin/sh
#################################################################
# Script name   : call_new_stores_init_load_bg.sh
# Description   : This shell script will call the script to  
#                 produce the init loads for store, terr and Param 
# Created       : rxv940 CCN Project Team.....
# Modified      : 
#################################################################

#nohup sh /app/ccn/dev/call_new_stores_init_load_bg.sh > /app/ccn/dev/datafiles/log/call_new_stores_init_load_bg.log 2>&1 &
#ps -eaf | grep call_new_stores_init_load_bg.sh
. /app/ccn/host.sh
DATADIR=$HOME/datafiles
ARCHIVEDIR=$DATADIR/polling/archive

while(true)
do

if [ $(ls "$DATADIR/$CCD.TRGRFILE" 2>/dev/null | wc -l) -gt 0 ]
then
    mv "$DATADIR/$CCD.TRGRFILE" "$ARCHIVEDIR"
    $HOME/call_to_init_loads_sql.sh
fi

done
exit 1
