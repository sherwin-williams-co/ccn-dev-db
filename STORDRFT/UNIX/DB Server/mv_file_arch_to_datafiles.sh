#!/bin/sh
################################################################################################################
# Script name   : mv_file_arch_to_datafiles.sh
#
# Description   : This shell program will Move the files from Archive folder to the datafiles folder 
#
# Created  : 02/19/2016 axk326 CCN Project Team.....
# Modified : 
################################################################################################################

# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="mv_file_arch_to_datafiles"
FLDR_DATE=`date -d ${DAILY_LOAD_RUNDATE} +"%m%d%Y"`
DATE=`date +"%m/%d/%Y"`
CUR_PATH="$HOME/dailyLoad/archieve/drafts/dailyLoad_"$FLDR_DATE""
DATAFILE_PATH="$HOME/datafiles"
TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc_name at $TIME on $DATE"

   cd $CUR_PATH
   #Move STORE_DRAFT.TXT file from archive folder to datafiles folder.
   if 
      ls STORE_DRAFT.TXT &> /dev/null; then
      echo " store draft file exist "
      find -maxdepth 1 -name STORE_DRAFT.TXT -exec cp {} $DATAFILE_PATH/STORE_DRAFT_$FLDR_DATE.TXT \; > /dev/null 2>&1
      echo " STORE_DRAFT.TXT file is moved from archive folder to datafiles folder "
   else
      echo " STORE_DRAFT.TXT file doesn't exists "
   fi
   #Move CUSTOMER_LABOR.TXT file from archive folder to datafiles folder. 
   if 
      ls CUSTOMER_LABOR.TXT &> /dev/null; then
      echo " customer labor file exist "
      find -maxdepth 1 -name CUSTOMER_LABOR.TXT -exec cp {} $DATAFILE_PATH/CUSTOMER_LABOR_$FLDR_DATE.TXT \; > /dev/null 2>&1
      echo " CUSTOMER_LABOR.TXT file is moved from archive folder to datafiles folder "
   else
      echo " CUSTOMER_LABOR.TXT file doesn't exists "
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
