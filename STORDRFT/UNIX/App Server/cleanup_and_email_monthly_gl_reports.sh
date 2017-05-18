#!/bin/sh
##########################################################
# Script to Cleanup the generated files after completion of process or during errors
# and send email if any errors or exceptions found in the log file
# Created:  5/16/2017 rxa457
##########################################################

###############################################
# Cleanup the Generated report TXT and PDF files; and then email the generated error LOG file
###############################################
echo "\nSTART CLEANUP_AND_EMAIL: Errors / Exceptions occured -- Removing generated report Files and Emailing the Log File.."

#Invoke cleanup function to remove the generated files
sh cleanup_monthly_gl_reports

#Identify starting Line number of current run from the log file
curlineno=`grep -n "sd_monthly_load.trg trigger file found at" /app/strdrft/sdReport/logs/Monthly_Reports_Run_bp.log|cut -f1 -d:|tail -1`
#Tail the current run log file content
logfile=`sed -n -e ''''$curlineno''',$p' /app/strdrft/sdReport/logs/Monthly_Reports_Run_bp.log`

#Emailing the Current run's Log File
sh send_mail.sh MONTHLY_REPORTS_RUN_BP "$logfile"

echo "END CLEANUP_AND_EMAIL\n*******************************************************************************************\n"
exit 1
############################################################################
# End of Program
############################################################################
