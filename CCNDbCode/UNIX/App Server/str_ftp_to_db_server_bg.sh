#!/bin/sh
############################################################################
# Script name : str_ftp_to_db_server_bg.sh
# Description : This shell script will call str_mv_rqst_to_db_server.sh
#             : after receving the Store .REQUEST file
#
# Created  : 07/05/2017 rxv940 CCN Project ....
# Modified : 
#              
############################################################################

#Run below command to make the process run in the background even after shutdown
#nohup sh /app/ccn/scripts/str_ftp_to_db_server_bg.sh > /app/ccn/POSdownloads/log/str_ftp_to_db_server_bg.log 2>&1 &

#Below statement will be used to check if the process is running in the background
#ps -eaf | grep str_ftp_to_db_server_bg.sh

. /app/ccn/ccn_app_server.config
DATADIR="$HOME"/POSdownloads/POSxmls

while(true)
do

#Check for .REQUEST file 
if ls "$DATADIR/$STR_FILE_NAME"*".REQUEST" 1>/dev/null 2>&1
then
    $SCRIPT_DIR/str_mv_rqst_to_db_server.sh
fi

done 
exit 1
