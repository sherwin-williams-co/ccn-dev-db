#!/bin/sh
###########################################################################################################################
# Script name   : DLY_DRAFT_LOAD.sh
#
# Description   : This script is to run the daily maintenance load for AutoMotive and Non AutoMotive
#
# Created  : 10/22/2014 jxc517 CCN Project Team.....
# Modified : 11/12/2014 axk326 CCN Project Team.....
#            Removed ftp code to separate process.
#          : 04/27/2015 axk326 CCN Project Team.....
#            Substituted hard coded date value with the date value from date_param.config file
#          : 11/18/2015 axk326 CCN Project Team.....
#            Added Error handling calls to send email when ever the script errors out due to any of the OSERROR or SQLERROR
#          : 01/19/2016 axk326 CCN Project Team.....
#            Added renaming the trigger file code from ok to not_ok in case of any failures
#          : 03/18/2016 nxk927 CCN Project Team.....
#            Changed the order of declaring variables after capturing the STATUS to avoid the scenario where
#            the ERROR CODE that needs to be captured, will not be overwritten in the ERROR STATUS CHECK block
#            Removed all the Un necessary declared time variable
#          : 03/24/2016 nxk927 CCN Project Team.....
#            added error message for errors
############################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="DLY_DRAFT_LOAD"
TIME=`date +"%H:%M:%S"`
DATE=${DAILY_LOAD_RUNDATE}
echo "Processing Started for $proc_name at $TIME on $DATE"

# below command will invoke the shell script to create the US Automotive file
./DLY_DRAFT_US_AM.sh
############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
	 echo "Processing failed for $proc_name at $TIME on $DATE"
     exit 1;
fi

# below command will invoke the shell script to create the US Non-Automotive file
./DLY_DRAFT_US_NAM.sh
############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
	 echo "Processing failed for $proc_name at $TIME on $DATE"
     exit 1;
fi

# below command will invoke the shell script to create the Canada Automotive file
./DLY_DRAFT_CAN_AM.sh
############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     echo "Processing failed for $proc_name at $TIME on $DATE"
     exit 1;
fi

# below command will invoke the shell script to create the Canada Non-Automotive file
./DLY_DRAFT_CAN_NAM.sh
############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
	 echo "Processing failed for $proc_name at $TIME on $DATE"
	 exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"

exit 0
############################################################################
