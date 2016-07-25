#!/bin/sh
################################################################################################################
# Script name   : rm_sd_cl_dailyfiles.sh
#
# Description   : This shell program will remove the store_draft and customer_labor text files from datafiles folder
#
# Created  : 07/11/2016 axk326 CCN Project Team.....
# Modified : 
################################################################################################################

# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="rm_sd_cl_dailyfiles"
FILE_DATE=`date -d ${DAILY_LOAD_RUNDATE} +"%m%d%Y"`
DATE=`date +"%m/%d/%Y"`
DATAFILE_PATH="$HOME/datafiles"
TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc_name at $TIME on $DATE"

   cd $DATAFILE_PATH
   #Remove STORE_DRAFT.TXT file from archive folder to datafiles folder.
   if 
      ls STORE_DRAFT_$FILE_DATE.TXT &> /dev/null; then
      echo " STORE_DRAFT_"$FILE_DATE".TXT file exist "
      rm -f STORE_DRAFT_$FILE_DATE.TXT
      echo " STORE_DRAFT_"$FILE_DATE".TXT file is removed "
   else
      echo " STORE_DRAFT_"$FILE_DATE".TXT file is not available "
   fi
   
   #Remove CUSTOMER_LABOR.TXT file from archive folder to datafiles folder. 
   if 
      ls CUSTOMER_LABOR_$FILE_DATE.TXT &> /dev/null; then
      echo " CUSTOMER_LABOR_"$FILE_DATE".TXT file exist "
      rm -f CUSTOMER_LABOR_$FILE_DATE.TXT
      echo " CUSTOMER_LABOR_"$FILE_DATE".TXT file is removed "
   else
      echo " CUSTOMER_LABOR_"$FILE_DATE".TXT file is not available "
   fi

#############################################################################
##                           ERROR STATUS CHECK 
#############################################################################
status=$?
if test $status -ne 0
then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
#############################################################################
