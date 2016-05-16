#!/bin/sh

##############################################################################################################
# Script name   : Monthly_Run.sh
#
# Description   : This script is to automatically run the monthly process
#
# Created  : 12/15/2015 jxc517 CCN Project Team.....
# Modified : 04/12/2016 nxk927 CCN Project Team.....
#            script modified to run on the second weekday of the month
#            moved the ones that needs to run on 1st of the month in another script (1099_monthly_run.sh)
##############################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="Monthly_Run"
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc_name at $TIME on $DATE"

##############################################################
# JV Monthly Process
##############################################################
./JV_monthly_load.sh

status=$?
if test $status -ne 0
then
     exit 1;
fi

##############################################################
# Outstanding Drafts Monthly
##############################################################
./Outstanding_draft_monthy.sh

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

cd $HOME/Reports
##############################################################
# Booked/Unbooked Reports - Data Load
##############################################################
./sd_load.sh

status=$?
if test $status -ne 0
then
     exit 1;
fi

##############################################################
# Unbooked Reports - MAIL to Christopher T. Greve/Sherwin-Williams@SWCBD 
##############################################################
./sd_gl_unbooked_report_mail.sh

status=$?
if test $status -ne 0
then
     exit 1;
fi

cd $HOME/initLoad
##############################################################
# FTP Trigger File for Application Server
##############################################################
./sd_monthly_app_srvr_trgr_file.sh

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
