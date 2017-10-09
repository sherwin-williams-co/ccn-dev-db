#!/bin/sh
#################################################################
# Script name   : stp_ws_diff_init_loads.sh
# Description   : This shell script will call the script to  
#                 produce the ws diff files for store, terr and Param 
# Created       : 10/06/0217  rxv940 CCN Project Team.....
# Modified      : 
#################################################################

. /app/ccn/host.sh
DATADIR=$HOME/datafiles
ARCHIVEDIR=$DATADIR/polling/archive

$HOME/init_loads_web_service.sh "STORE"
$HOME/init_loads_web_service.sh "TERR"
$HOME/init_loads_web_service.sh "PARAM"
if [ -s $DATADIR/$CCD.queue ] 
then 
    echo "Trigger file to denote the completion of Init loads used for Webservice differencing. " > "$DATADIR/$CCD.ws_diff"
    $HOME/polling_dwnld_files_ftp_to_app_server.sh "$CCD.ws_diff"
    mv -f "$DATADIR/$CCD.queue" "$ARCHIVEDIR"
    mv -f "$DATADIR/$CCD.ws_diff" "$ARCHIVEDIR"
fi
exit 0


