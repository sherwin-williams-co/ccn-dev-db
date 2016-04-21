#!/bin/sh

##############################################################################################################
# Script name   : Second_wk_day_mnthly_run.sh
#
# Description   : This script is to automatically run the monthly process
#
# Created  : 12/15/2015 jxc517 CCN Project Team.....
# Modified : 04/12/2016 nxk927 CCN Project Team.....
#            script modified to run on the second weekday of the month, renamed the script from monthly_run.sh to Second_wk_day_mnthly_run.sh
#            moved the ones that needs to run on 1st of the month in another script (First_day_Monthly_Run.sh)
##############################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="Second_wk_day_mnthly_run"
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
