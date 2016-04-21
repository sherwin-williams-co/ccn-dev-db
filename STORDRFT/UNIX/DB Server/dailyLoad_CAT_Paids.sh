#!/bin/sh
#################################################################
# Script name   : dailyLoad_CAT_Paids.sh
#
# Description   : concatenate the dailyLoad paid files created
#
# Created  : 11/06/2014 jxc517 CCN Project Team.....
# Modified : 04/27/2015 axk326 CCN Project Team.....
#            Substituted hard coded date value with the date value from date_param.config file
#          : 03/18/2016 nxk927 CCN Project Team.....
#            Changed the order of declaring variables after capturing the STATUS to avoid the scenario where
#            the ERROR CODE that needs to be captured, will not be overwritten in the ERROR STATUS CHECK block
#          : 03/18/2016 nxk927 CCN Project Team.....
#            added status check for all the calls and changed the status check to make it uniform
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="dailyLoad_CAT_Paids"
TIME=`date +"%H:%M:%S"`
DATE=${DAILY_LOAD_RUNDATE}
echo "Processing Started for $proc_name at $TIME on $DATE"

cd $HOME/initLoad

#Concatenating all the files
if ls STBD0101_PAID_*.TXT &> /dev/null;then
   echo "  suntrust paid files exists - concatenating suntrust paid data files"
   cat /dev/null > STBD0101_SUNTRUST_PAID.TXT
   cat STBD0101_PAID_*.TXT >> STBD0101_SUNTRUST_PAID.TXT
else
   echo "  suntrust paid files do not exist "
   cat /dev/null > STBD0101_SUNTRUST_PAID.TXT
fi

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

if ls STBD0601_PAID_*.TXT &> /dev/null;then
   echo "  royal paid files exists - concatenating royal paid data files"
   cat /dev/null > STBD0601_ROYALBNK_PAID2.TXT
   cat STBD0601_PAID_*.TXT >> STBD0601_ROYALBNK_PAID2.TXT
else
   echo "  royal paid files do not exist "
   cat /dev/null > STBD0601_ROYALBNK_PAID2.TXT
fi

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

#Moving back to invoking folder as the process has to continue
cd $HOME/dailyLoad

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"

exit 0
############################################################################
