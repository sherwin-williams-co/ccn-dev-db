#!/bin/sh
############################################################################
# Script name : str_ftp_to_app_server.sh
# Description : This shell script will call str_mv_posfiles_to_app_server.sh
#             : after receving the Store XML and POLLINGDONE file if the 
#             : POLLING_FTP_FLAG is set to true
#
# Created  : 07/03/2017 rxv940 CCN Project ....
# Modified : 
#              
############################################################################

#Run below command to make the process run in the background even after shutdown
#nohup sh /app/ccn/scripts/str_ftp_to_app_server.sh > /app/ccn/POSdownloads/log/str_ftp_to_app_server.log 2>&1 &

#Below statement will be used to check if the process is running in the background
#ps -eaf | grep str_ftp_to_app_server.sh

. /app/ccn/host.sh

PROC_NAME="str_ftp_to_app_server.sh"
DATADIR="$HOME"/datafiles

while(true)
do

#Check for .POLLINGDONE file and status of POLLING_FTP_FLAG
if [ $(ls "$DATADIR/StoreUpdate_"*".POLLINGDONE" 2>/dev/null | wc -l) -gt 0 ] && [ POLLING_FTP_FLAG=="Y" ]
then
    
    DATE=`date +"%m/%d/%Y"`
    TIME=`date +"%H:%M:%S"`
    echo " $PROC_NAME --> call to str_mv_posfiles_to_app_server.sh started at $DATE : $TIME "
    
    ./str_mv_posfiles_to_app_server.sh
    
    TIME=`date +"%H:%M:%S"` 
    echo " $PROC_NAME --> call to str_mv_posfiles_to_app_server.sh finished at $DATE : $TIME "

fi

done 
