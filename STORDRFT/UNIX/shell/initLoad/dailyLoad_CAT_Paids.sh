#!/bin/sh
#################################################################
# Script name   : dailyLoad_CAT_Paids.sh
#
# Description   : concatenate the dailyLoad paid files created
#
# Created  : 11/06/2014 jxc517 CCN Project Team.....
# Modified :
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="dailyLoad_CAT_Paids"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
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

if ls STBD0601_PAID_*.TXT &> /dev/null;then
   echo "  royal paid files exists - concatenating royal paid data files"
   cat /dev/null > STBD0601_ROYALBNK_PAID2.TXT
   cat STBD0601_PAID_*.TXT >> STBD0601_ROYALBNK_PAID2.TXT
else
   echo "  royal paid files do not exist "
   cat /dev/null > STBD0601_ROYALBNK_PAID2.TXT
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
