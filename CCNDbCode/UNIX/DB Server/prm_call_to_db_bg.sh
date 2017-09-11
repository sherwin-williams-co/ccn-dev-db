#!/bin/sh
############################################################################
# Script name : prm_call_to_db_bg.sh
# Description : This shell script will call prm_upd_pos_rqst_id.sh
#             : after receving the .REQUEST file from App Server
#
# Created  : 07/06/2017 rxv940 CCN Project ....
# Modified : 
#              
############################################################################

#Run below command to make the process run in the background even after shutdown
#nohup sh /app/ccn/scripts/prm_call_to_db_bg.sh > /app/ccn/POSdownloads/log/prm_call_to_db_bg.log 2>&1 &

#Below statement will be used to check if the process is running in the background
#ps -eaf | grep prm_call_to_db_bg.sh

. /app/ccn/host.sh
DATADIR="$HOME"/datafiles
 
while(true)
do

#Check for .REQUEST file
if [ $(ls "$DATADIR/$PRM_FILE_NAME"*".REQUEST" 2>/dev/null | wc -l) -gt 0 ] 
then
    $HOME/prm_upd_pos_rqst_id.sh
fi

done 
exit 1