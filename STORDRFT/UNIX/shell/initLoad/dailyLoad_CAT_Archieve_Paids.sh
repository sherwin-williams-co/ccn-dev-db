#!/bin/sh
#################################################################
# Script name   : dailyLoad_CAT_Archieve_Paids.sh
#
# Description   : concatenate the dailyLoad files created
#                 accepts proc name and week number as paratmers 1 and 2
#                 Archive the dailyLoad files created for SUNTRUST and ROYAL paid Files
#
# Created  : 11/06/2014 jxc517 CCN Project Team.....
# Modified : 04/27/2015 axk326 CCN Project Team.....
#            Substituted hard coded date value to pick the date value from config file
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="dailyLoad_CAT_Archieve_Paids"
TIME=`date +"%H:%M:%S"`
P1=${DAILY_LOAD_RUNDATE}
echo "Processing Started for $proc_name at $TIME for the date $P1"

# below command will call the script to concatenate SUNTRUST and ROYAL paid Files.
./dailyLoad_CAT_Paids.sh

# below command will call the script to Archive SUNTRUST and ROYAL paid Files.
./Archive_dailyLoad_Paids.sh

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
