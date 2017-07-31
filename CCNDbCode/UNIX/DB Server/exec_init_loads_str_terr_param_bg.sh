#!/bin/sh
#################################################################
# Script name   : exec_init_loads_str_terr_param_bg.sh
# Description   : This shell script will call the script to  
#                 produce the init loads for store, terr and Param 
# Created       : rxv940 CCN Project Team.....
# Modified      : 
#################################################################

#nohup sh /app/ccn/dev/exec_init_loads_str_terr_param_bg.sh > /app/ccn/dev/datafiles/log/exec_init_loads_str_terr_param_bg.log 2>&1 &
#ps -eaf | grep exec_init_loads_str_terr_param_bg.sh
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
