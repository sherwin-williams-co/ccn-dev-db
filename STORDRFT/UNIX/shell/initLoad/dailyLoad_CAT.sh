#!/bin/sh
#################################################################
# Script name   : dailyLoad_CAT.sh
#
# Description   : concatenate the dailyLoad files created
#
# Created  : 10/22/2014 jxc517 CCN Project Team.....
# Modified : 04/27/2015 axk326 CCN Project Team.....
#            Substituted hard coded date value to pick the date value from config file
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="dailyLoad_CAT"
TIME=`date +"%H:%M:%S"`
P1=${DAILY_LOAD_RUNDATE}
echo "Processing Started for $proc_name at $TIME for the date $P1"

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

if ls STORE_DRAFT_*.TXT &> /dev/null;then
   echo "  StoreDraft files exists - concatenating StoreDraft data files"
   cat /dev/null > STORE_DRAFT.TXT
   cat STORE_DRAFT_*.TXT >> STORE_DRAFT.TXT
else
   echo "  StoreDraft files do not exist "
   cat /dev/null > STORE_DRAFT.TXT
fi

#Moving back to invoking folder as the process has to continue
cd $HOME/dailyLoad

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
P1=${DAILY_LOAD_RUNDATE}
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name at ${TIME} for the date ${P1}"
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} for the date ${P1}"  

exit 0
############################################################################
