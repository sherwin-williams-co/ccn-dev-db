#!/bin/sh
###########################################################################################################
# Script Name    :  daily_loads_filewatcher.sh
#
# Description    :  This shell program will search for the DAILY_LOADS.TRG file when ever 
#                   STORDRFT_PARAM table is updated successfully by the update_storedrft_param.sh script
# Created        :  AXK326 01/08/2016 CCN Project Team....
# Modified       :  
###########################################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc="DAILY_LOADS_FILEWATCHER"
trg_file_path="$HOME/dailyLoad"

# Search for the file named DAILY_LOADS.TRG
while true; 
do
   if [ -s $trg_file_path/DAILY_LOADS.TRG ]
   then
      echo "file found \n"
	  TIME=`date +"%H:%M:%S"`
      DATE=`date +"%m/%d/%Y"`
      echo "process started for daily loads at $TIME on $DATE\n"	
      ./ccn_sd_daily_load.sh
	  ./ARCH_DAILY_LOADS_TRG_FILE.sh
   fi
done

echo "process completed for $proc abruptly - but should not come to this point"
