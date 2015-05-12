#!/bin/sh
#################################################################
# Script name   : Archive_dailyLoad_SC.sh
#
# Description   : This shell program will Archive the dailyLoad files created 
#                   for CUSTOMER_LABOR, STORE_DRAFT files
#
# Created  : 11/06/2014 axk326 CCN Project Team.....
# Modified : 04/27/2015 axk326 CCN Project Team.....
#            Substituted hard coded date value with the date value from date_param.config file
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="Archive_dailyLoad_SC"
CUR_PATH="$HOME/initLoad"
ARCHIVE_PATH="$HOME/dailyLoad/archieve/drafts"
TIME=`date +"%H:%M:%S"`
DATE=`date -d ${DAILY_LOAD_RUNDATE} +"%m%d%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"

# Control will output if $DIRECTORY exists.
if [ -d "$ARCHIVE_PATH/"dailyLoad"_"$DATE"" ]; then
   echo " Directory exists "
else
  mkdir $ARCHIVE_PATH/"dailyLoad"_"$DATE"
fi

cd $CUR_PATH
#Archive file for store_draft.
if 
    ls STORE_DRAFT.TXT &> /dev/null; then
    echo " Store Draft file exist "
    find -maxdepth 1 -name STORE_DRAFT.TXT -exec mv {} $ARCHIVE_PATH/"dailyLoad"_"$DATE" \; > /dev/null 2>&1
else
    echo " Store Draft files doesn't exists "
fi

#Archive file for customer_labor.
if 
    ls CUSTOMER_LABOR.TXT &> /dev/null; then
    echo " Customer Labor files exist "
    find -maxdepth 1 -name CUSTOMER_LABOR.TXT -exec mv {} $ARCHIVE_PATH/"dailyLoad"_"$DATE" \; > /dev/null 2>&1
else
    echo " Customer Labor files doesn't exists "
fi

#Moving back to invoking folder as the process has to continue
cd $HOME/dailyLoad

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################
