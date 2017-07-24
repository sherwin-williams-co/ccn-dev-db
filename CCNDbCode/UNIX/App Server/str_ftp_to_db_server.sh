#!/bin/sh
############################################################################
# Script name : str_ftp_to_db_server.sh
# Description : This shell script will call str_mv_rqst_to_db_server.sh
#             : after receving the Store .REQUEST file
#
# Created  : 07/05/2017 rxv940 CCN Project ....
# Modified : 
#              
############################################################################

#Run below command to make the process run in the background even after shutdown
#nohup sh /app/ccn/scripts/str_ftp_to_db_server.sh > /app/ccn/POSdownloads/log/str_ftp_to_db_server.log 2>&1 &

#Below statement will be used to check if the process is running in the background
#ps -eaf | grep str_ftp_to_db_server.sh

. /app/ccn/ccn.config

PROC_NAME="str_ftp_to_db_server.sh"
DATADIR="$HOME"/POSdownloads/POSxmls
SCRIP="$HOME"/scripts

while(true)
do

#Check for .REQUEST file 
if [ $(ls "$DATADIR/StoreUpdate_"*".REQUEST" 2>/dev/null | wc -l) -gt 0 ]
then

    DATE=`date +"%m/%d/%Y"`
    TIME=`date +"%H:%M:%S"`
    echo " $PROC_NAME --> call to str_mv_rqst_to_db_server.sh started at $DATE : $TIME "

    ./str_mv_rqst_to_db_server.sh

    TIME=`date +"%H:%M:%S"`
    echo " $PROC_NAME --> call to str_mv_rqst_to_db_server.sh finished at $DATE : $TIME "

fi

done 

