#!/bin/sh
#################################################################
# Script name   : dailyLoad_CAT.sh
#
# Description   : concatenate the dailyLoad files created
#
# Created  : 10/22/2014 jxc517 CCN Project Team.....
# Modified : 04/27/2015 axk326 CCN Project Team.....
#            Substituted hard coded date value with the date value from date_param.config file
#          : 03/18/2016 nxk927 CCN Project Team.....
#            Changed the order of declaring variables after capturing the STATUS to avoid the scenario where
#            the ERROR CODE that needs to be captured, will not be overwritten in the ERROR STATUS CHECK block
#            Removed the error check at the end and added for other calls
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="dailyLoad_CAT"
TIME=`date +"%H:%M:%S"`
DATE=${DAILY_LOAD_RUNDATE}
echo "Processing Started for $proc_name at $TIME on $DATE"

cd $HOME/initLoad

#Concatenating all the files
if ls CUSTOMER_LABOR_*.TXT &> /dev/null;then
   echo "  CUSTOMER files exists - concatenating customer data files"
   cat /dev/null > CUSTOMER_LABOR.TXT
   cat CUSTOMER_LABOR_*.TXT >> CUSTOMER_LABOR.TXT
else
   echo "  Customer files do not exist "
   cat /dev/null > CUSTOMER_LABOR.TXT
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

if ls STORE_DRAFT_*.TXT &> /dev/null;then
   echo "  StoreDraft files exists - concatenating StoreDraft data files"
   cat /dev/null > STORE_DRAFT.TXT
   cat STORE_DRAFT_*.TXT >> STORE_DRAFT.TXT
else
   echo "  StoreDraft files do not exist "
   cat /dev/null > STORE_DRAFT.TXT
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
