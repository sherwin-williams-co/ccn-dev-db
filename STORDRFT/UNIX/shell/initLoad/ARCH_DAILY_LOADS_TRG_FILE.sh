#!/bin/sh
#######################################################################################
# Script name   : ARCH_DAILY_LOADS_TRG_FILE
#
# Description   : This shell program will Archive the DAILY_LOADS.TRG 
#                 file created when the storedraft param table is updated 
# Created  : 01/08/2016 AXK326 CCN Project Team.....
# Modified : 
#######################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="ARCH_DAILY_LOADS_TRG_FILE"
ARCHIVE_PATH="$HOME/dailyLoad/archieve"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
echo " Processing Started for $proc_name at $TIME on $DATE"

# Control will output if $DIRECTORY exists.
if [ -d "$ARCHIVE_PATH/"DAILY_LOADS"" ]; then
   echo " Directory exists "
else
  mkdir $ARCHIVE_PATH/"DAILY_LOADS"
fi

#Archive file for INSPAYMENT.TRG file.
if 
    ls DAILY_LOADS.TRG &> /dev/null; then
    echo " DAILY_LOADS.TRG file exist "
    find -maxdepth 1 -name DAILY_LOADS.TRG -exec mv {} $ARCHIVE_PATH/"DAILY_LOADS"/DAILY_LOADS"_"$TimeStamp.TRG \; > /dev/null 2>&1
else
    echo " DAILY_LOADS.TRG file does not exists "
fi

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
status=$?
if test $status -ne 0
then
     echo " processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

echo " Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################
