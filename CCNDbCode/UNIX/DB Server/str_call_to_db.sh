#!/bin/sh
############################################################################
# Script name : str_call_to_db.sh
# Description : This shell script will call str_upd_pos_rqst_id.sh
#             : after receving the .REQUEST file from App Server
#
# Created  : 07/06/2017 rxv940 CCN Project ....
# Modified : 
#              
############################################################################

#Run below command to make the process run in the background even after shutdown
#nohup sh /app/ccn/scripts/str_call_to_db.sh > /app/ccn/POSdownloads/log/str_call_to_db.log 2>&1 &

#Below statement will be used to check if the process is running in the background
#ps -eaf | grep str_call_to_db.sh

. /app/ccn/host.sh

PROC_NAME="str_call_to_db.sh"
DATADIR="$HOME"/datafiles
 
while(true)
do

#Check for .POLLINGDONE file and status of POLLING_FTP_FLAG
if [ $(ls "$DATADIR/StoreUpdate_"*".REQUEST" 2>/dev/null | wc -l) -gt 0 ] 
then
    
    DATE=`date +"%m/%d/%Y"`
    TIME=`date +"%H:%M:%S"`

    echo " $PROC_NAME --> call to str_upd_pos_rqst_id.sh started at $DATE : $TIME "
    ./str_upd_pos_rqst_id.sh

    TIME=`date +"%H:%M:%S"` 
    echo " $PROC_NAME --> call to str_upd_pos_rqst_id.sh finished at $DATE : $TIME "

fi

done 
