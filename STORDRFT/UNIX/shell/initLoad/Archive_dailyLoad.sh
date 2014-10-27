#!/bin/sh
#################################################################
# Script name   : Archive_dailyLoad.sh
#
# Description   : This shell program will Archive the dailyLoad files created 
#                   for CUSTOMER_LABOR, STORE_DRAFT, Suntrust & Royal paid Files
#
# Created  : 10/22/2014 jxc517 CCN Project Team.....
# Modified :
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="Archive_dailyLoad"
CUR_PATH="$HOME/initLoad"
ARCHIVE_PATH="$HOME/dailyLoad/archieve/drafts"
TIME=`date +"%H:%M:%S"`
#DATE=`date +"%m/%d/%Y"`
DATE=`date +"%m%d%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
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
    ls STORE_DRAFT_*.TXT &> /dev/null; then
    echo " Store Draft files exist "
    find -maxdepth 1 -name STORE_DRAFT_\*.TXT -exec mv {} $ARCHIVE_PATH/"dailyLoad"_"$DATE" \; > /dev/null 2>&1
else
    echo " Store Draft files doesn't exists "
fi

#Archive file for customer_labor.
if 
    ls CUSTOMER_LABOR_*.TXT &> /dev/null; then
    echo " Customer Labor files exist "
    find -maxdepth 1 -name CUSTOMER_LABOR_\*.TXT -exec mv {} $ARCHIVE_PATH/"dailyLoad"_"$DATE" \; > /dev/null 2>&1
else
    echo " Customer Labor files doesn't exists "
fi

#Archive file for suntrust.
if 
    ls STBD0101_PAID_*.TXT &> /dev/null; then
    echo " suntrust paid files exist "
    find -maxdepth 1 -name STBD0101_PAID_\*.TXT -exec mv {} $ARCHIVE_PATH/"dailyLoad"_"$DATE" \; > /dev/null 2>&1
else
    echo " suntrust paid files doesn't exists "
fi

#Archive file for royal.
if 
    ls STBD0601_PAID_*.TXT &> /dev/null; then
    echo " royal paid files exist "
    find -maxdepth 1 -name STBD0601_PAID_\*.TXT -exec mv {} $ARCHIVE_PATH/"dailyLoad"_"$DATE" \; > /dev/null 2>&1
else
    echo " royal paid files doesn't exists "
fi

#Moving back to invoking folder as the process has to continue
cd $HOME/dailyLoad

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################
