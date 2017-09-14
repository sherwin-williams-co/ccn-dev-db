#!/bin/sh
##########################################################
# Script to Cleanup the generated files after completion of process or during errors
# and send email if any errors or exceptions found in the log file
# Created:  5/16/2017 rxa457
##########################################################

###############################################
# Cleanup the Generated report TXT and PDF files; and then email the generated error LOG file
###############################################
dt=`date +"%m%d%Y"`
echo "\nSTART CLEANUP_AND_EMAIL: Errors / Exceptions occured -- Removing generated report Files and Emailing the Log File.."

#Invoke cleanup function to remove the generated files
./cleanup_monthly_gl_reports.sh

logfile=`sed "s/'//g" /app/strdrft/sdReport/logs/Monthly_Reports_Run_bp_Current_${dt}.log`

#Emailing the Current run's Log File
./send_mail.sh MONTHLY_REPORTS_RUN_BP "$logfile"

echo "END CLEANUP_AND_EMAIL"
#To format log file to clearly indicate the runs which ended into errors
echo "\n*******************************************************************************************\n"
exit 1
############################################################################
# End of Program
############################################################################
