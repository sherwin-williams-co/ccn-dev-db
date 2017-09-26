#!/bin/sh
############################################################################
# Script name : prm_ftp_to_app_server_bg.sh
# Description : This shell script will call prm_mv_posfiles_to_app_server.sh
#             : after receving the PARAM XML and POLLINGDONE file if the 
#             : POLLING_FTP_FLAG is set to true
#
# Created  : 07/03/2017 rxv940 CCN Project ....
# Modified : 
#              
############################################################################

#Run below command to make the process run in the background even after shutdown
#nohup sh /app/ccn/prm_ftp_to_app_server_bg.sh > /app/ccn/datafiles/log/prm_ftp_to_app_server_bg.log 2>&1 &

#Below statement will be used to check if the process is running in the background
#ps -eaf | grep prm_ftp_to_app_server_bg.sh

. /app/ccn/host.sh
DATADIR="$HOME"/datafiles

while(true)
do

#Check for .POLLINGDONE file 
if ls "$DATADIR/$PRM_FILE_NAME"*".POLLINGDONE" 1>/dev/null 2>&1
then
    $HOME/prm_mv_posfiles_to_app_server.sh
fi

done 
exit 1