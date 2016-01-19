#!/bin/sh -e
##############################################################################################################################
# Script name   : ccn_sd_daily_load.sh
#
# Description   : This shell program will initiate the script that 
#                 Loads all the store drafts tables
#                 It also sends the emails regarding starting and ending of the process#
#				  
# Created  : 10/22/2014 jxc517 CCN Project Team.....
# Modified : 11/05/2014 axk326 CCN Project Team.....
#			 Commented daily_paids_load.sh and triggered it out in individual cron 
#          : 04/27/2015 axk326 CCN Project Team.....
#            Substituted hard coded date value with the date value from date_param.config file
#          : 11/18/2015 axk326 CCN Project Team.....
#            Added -e to the script to catch the errors in subsequent shell scripts while running the daily jobs
#          : 01/12/2016 axk326 CCN Project Team.....
#            Added shell script call to check if the .OK file exists or not before proceeding further
#            Added shell script call to rename the .OK file to .NOT_OK file in case of error
##############################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

# below command will invoke the batch_dependency_ok_check shell script to check if the trigger file exists or not
./batch_dependency_ok_check.sh 
############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]; then
     exit 1;
fi

proc="ccn_sd_daily_load"
TIME=`date +"%H:%M:%S"`
DATE=${DAILY_LOAD_RUNDATE}
echo "Processing Started for $proc at $TIME on $DATE"

##############################################################################
# Run the shell script to concatenate the daily files and archiving the individual files
##############################################################################
./dailyLoad_CAT_Archieve.sh
############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]; then
     echo "Concatenation and Archiving process failed"
	 ./send_err_status_email.sh SD_BATCH_PROCESSING_ERROR
	 ./rename_file_ok_to_notok.sh BATCH_DEPENDENCY.OK BATCH_DEPENDENCY.NOT_OK
     exit 1;
fi

##############################################################################
# Load the daily drafts data from files into stordrft database
##############################################################################
./daily_drafts_load.sh

##############################################################################
# if there is no error in the daily load then following process will run
#      1) Call for the daily issue interface files into stordrft database
#      2) Call for the daily reconciliation report
# else it will send mail for the error. 
##############################################################################
status=$?
if test $status -ne 0
then
echo "Daily Load process failed"
sqlplus -s -l $sqlplus_user/$sqlplus_pw <<END
set heading off;
set verify off;
execute MAIL_PKG.send_mail('SD_DAILY_LOAD_FAIL');
exit;
END
exit 1
else
 echo "Running DLY_DRAFT_LOAD process"
	./DLY_DRAFT_LOAD.sh
	./DLY_RECONCILIATION.sh
fi

##############################################################################
# Run the shell script to archive the STORE_DRAFT and CUSTOMER_LABOR files
##############################################################################
./Archive_dailyLoad_SC.sh

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
status=$?
if [ $status -ne 0 ]; then
     ./send_err_status_email.sh SD_BATCH_PROCESSING_ERROR
	 ./rename_file_ok_to_notok.sh BATCH_DEPENDENCY.OK BATCH_DEPENDENCY.NOT_OK
     exit 1;
fi

cd $HOME/dailyLoad
rm -f BATCH_DEPENDENCY.OK;
echo "" > PAIDS_MNTNC_CHECK.OK
echo "PAIDS_MNTNC_CHECK.OK is created in dailyLoad folder"

echo "Processing finished for $proc at ${TIME} on ${DATE}"  

##############################################################################
# Load the data from cpr into stordrft database
##############################################################################
./cc_employee_tax_load.sh
############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]; then
     echo "CC_EMPLOYEE_TAX_LOAD script failed"
	 ./send_err_status_email.sh SD_BATCH_PROCESSING_ERROR
     exit 1;
fi

exit 0
############################################################################
