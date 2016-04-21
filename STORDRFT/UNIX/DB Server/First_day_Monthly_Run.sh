#!/bin/sh

##############################################################################################################
# Script name   : First_day_Monthly_Run.sh
#
# Description   : This script is to automatically run the 1099 monthly process
#
# Created  : 04/12/2016 nxk927 CCN Project Team.....
# Modified :
##############################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="First_day_Monthly_Run"
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc_name at $TIME on $DATE"

##############################################################
# 1099 Monthly Process
##############################################################
./1099_monthly_file_gen.sh

status=$?
if test $status -ne 0
then
     exit 1;
fi

##############################################################
# 1099 Financial Shared Services (FSS)
##############################################################
./1099_FSS_file_gen.sh

status=$?
if test $status -ne 0
then
     exit 1;
fi

##############################################################
# 1099 Financial Shared Services (FSS) - SFTP
##############################################################
./1099_FSS_file_sftp.sh

status=$?
if test $status -ne 0
then
     exit 1;
fi

##############################################################
# 1099 Financial Shared Services (FSS) - MAIL to Tharanga M. Kandanarachchi/Sherwin-Williams
##############################################################
./1099_FSS_file_mail.sh

status=$?
if test $status -ne 0
then
     exit 1;
fi

##############################################################
# 1099 Account Payable Reports
##############################################################
./1099_info_feed_to_AP.sh

status=$?
if test $status -ne 0
then
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"
##############################################################
# End and Exit
##############################################################
exit 0