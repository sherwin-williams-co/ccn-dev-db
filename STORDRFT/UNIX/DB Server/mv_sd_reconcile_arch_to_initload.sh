#!/bin/sh
################################################################################################################
# Script name   : mv_sd_reconcile_arch_to_initload.sh
#
# Description   : This shell program will Move the files from Archive folder to the initLoad folder 
#
# Created  : 01/05/2017 mxk766 CCN Project Team.....
# Modified : 
################################################################################################################

# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="mv_sd_reconcile_arch_to_initload"
DAYSBACK=0
FLDR_DATE=`date -d "$DAILY_LOAD_RUNDATE - $DAYSBACK days" +"%m%d%Y"`
CUR_PATH="$HOME/dailyLoad/archieve/drafts/dailyLoad_"$FLDR_DATE""
INITLOAD_PATH="$HOME/initLoad"
TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc_name at $TIME on $DATE"
echo "The current path from where files are moved is "$CUR_PATH

   cd $CUR_PATH
   #Move STORE_DRAFT.TXT file from archive folder to initLoad folder.
   if 
      ls STORE_DRAFT.TXT &> /dev/null; then
      echo " store draft file exist in"$CUR_PATH
                      find -maxdepth 1 -name STORE_DRAFT.TXT -exec cp {} $INITLOAD_PATH \; > /dev/null 2>&1
      #cp STORE_DRAFT.TXT $INITLOAD_PATH
      echo " STORE_DRAFT.TXT file is moved from archive folder to initLoad folder "$INITLOAD_PATH
   else
      echo " STORE_DRAFT.TXT file doesn't exists "
   fi
   #Move CUSTOMER_LABOR.TXT file from archive folder to initLoad folder. 
   if 
      ls CUSTOMER_LABOR.TXT &> /dev/null; then
      echo " customer labor file exist in"$CUR_PATH
                      find -maxdepth 1 -name CUSTOMER_LABOR.TXT -exec cp {} $INITLOAD_PATH \; > /dev/null 2>&1
      #cp CUSTOMER_LABOR.TXT $INITLOAD_PATH
      echo " CUSTOMER_LABOR.TXT file is moved from archive folder to initLoad folder "$INITLOAD_PATH
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