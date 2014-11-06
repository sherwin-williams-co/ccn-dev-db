#!/bin/sh
#################################################################
# Script name   : Archive_dailyLoad_Paid_Files.sh
#
# Description   : This shell program will Archive the dailyLoad files created 
#                 for Suntrust & Royal paid Files once the process is finished
#
# Created  : 11/06/2014 axk326 CCN Project Team.....
# Modified :

#################################################################

# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="Archive_dailyLoad_Paid_Files"
CUR_PATH="$HOME/initLoad"
ARCHIVE_PATH="$HOME/dailyLoad/archieve/drafts"
TIME=`date +"%H:%M:%S"`
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
#Archive file for suntrust.
if 
    ls STBD0101_SUNTRUST_PAID.TXT &> /dev/null; then
    echo " suntrust paid files exist "
    find -maxdepth 1 -name STBD0101_SUNTRUST_PAID.TXT -exec mv {} $ARCHIVE_PATH/"dailyLoad"_"$DATE" \; > /dev/null 2>&1
else
    echo " suntrust paid files doesn't exists "
fi

#Archive file for royal.
if 
    ls STBD0601_ROYALBNK_PAID2.TXT &> /dev/null; then
    echo " royal paid files exist "
    find -maxdepth 1 -name STBD0601_ROYALBNK_PAID2.TXT -exec mv {} $ARCHIVE_PATH/"dailyLoad"_"$DATE" \; > /dev/null 2>&1
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
