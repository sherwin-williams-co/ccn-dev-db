#!/bin/sh
#############################################################################
# Script Name   :  initReloadWithAllDailyLoads
#
# Description    : This shell program will clean up the entire load 
# nohup ./initReloadWithAllDailyLoads.sh > ../logs/initReloadWithAllDailyLoads.log 2>&1 &
#
# Created           :  09/15/2014
# Modified          :  
############################################################################
. /app/ccn/host.sh

 LOGDIR=$HOME/initLoad/STORDRFT
 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
 TimeStamp=`date '+%Y%m%d%H%M%S'`
 CUR_PATH="$HOME/initLoad/STORDRFT"
 proc="dataCleanup"

echo "Processing Started for data clean-up at $TIME on $DATE"

sqlplus -s -l $strdrft_sqlplus_user/$strdrft_sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
PROMPT Truncating ERROR_LOG table
TRUNCATE TABLE ERROR_LOG;
PROMPT Running the initLoad process
EXEC INITLOAD.CCN_SD_INITLOAD_SP();
exit;
END

#Run the dailyLaod process for all the files : Scripts needs to be generated for looping all the files
folders=`ls -d $CUR_PATH/archieve/* -1`
for folder in $folders
do
    echo "moving files from $folder to $CUR_PATH"
    mv $folder/STORE_DRAFT_*.TXT $CUR_PATH
    mv $folder/CUSTOMER_LABOR_*.TXT $CUR_PATH
    echo "Concatenating the files"
    ./dailyLoad_CAT.sh
    echo "Daily process running"
sqlplus -s -l $strdrft_sqlplus_user/$strdrft_sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;
execute SD_DAILY_LOAD.CCN_SD_DAILY_LOAD_SP();
execute SD_PAID_DETAILS_LOAD.CCN_SD_PAID_LOAD_SP();
exit;
END
    echo "moving files from $CUR_PATH to $folder"
    mv $CUR_PATH/STORE_DRAFT_*.TXT $folder
    mv $CUR_PATH/CUSTOMER_LABOR_*.TXT $folder
done

 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
echo "Processing Finished for data clean-up at ${TIME} on ${DATE}"

#################################################
#    ERROR STATUS CHECK employee_details_sync.sh 
#################################################
status=$?
if test $status -ne 0
   then
     echo "processing FAILED for data clean-up at ${TIME} on ${DATE}"
     exit 1;
fi

exit 0
############################################################################
