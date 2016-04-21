#!/bin/sh
#################################################################
# Script name   : Archive_dailyLoad_Paids.sh
#
# Description   : This shell program will Archive the dailyLoad files created
#                   for Suntrust & Royal paid Files
#
# Created  : 11/06/2014 jxc517 CCN Project Team.....
# Modified : 04/27/2015 axk326 CCN Project Team.....
#            Substituted hard coded date value with the date value from date_param.config file
#          : 03/18/2016 nxk927 CCN Project Team.....
#            Changed the order of declaring variables after capturing the STATUS to avoid the scenario where
#            the ERROR CODE that needs to be captured, will not be overwritten in the ERROR STATUS CHECK block
#          : 03/24/2016 nxk927 CCN Project Team.....
#            Removed the error from the end
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="Archive_dailyLoad_Paids"
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

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"

exit 0
############################################################################
