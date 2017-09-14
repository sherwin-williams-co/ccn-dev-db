#!/bin/sh
##########################################################
# Script to Cleanup the generated files after completion of process or during errors
# and send email if any errors or exceptions found in the log file
# Created:  5/16/2017 rxa457
# Modified: 09/13/2017 rxa457 CCN Project Team...
#              Removing tail function to extract current log information from BP log
#              and removing single quotes from current log before sending email
##########################################################

###############################################
# Cleanup the Generated report TXT and PDF files; and then email the generated error LOG file
###############################################
dt=`date +"%m%d%Y"`
echo "\nSTART CLEANUP_AND_EMAIL: Errors / Exceptions occured -- Removing generated report Files and Emailing the Log File.."

#Invoke cleanup function to remove the generated files
./cleanup_monthly_gl_reports.sh

#Replace any single quotes with " ''' " before passing into send_mail pkg to avoid errors
logfile=`sed "s/'/'''/g" /app/strdrft/sdReport/logs/Monthly_Reports_Run_bp_${dt}.log`

#Emailing the Current run's Log File
./send_mail.sh MONTHLY_REPORTS_RUN_BP "$logfile"

echo "END CLEANUP_AND_EMAIL"
#To format log file to clearly indicate the runs which ended into errors
echo "\n*******************************************************************************************\n"
exit 1
############################################################################
# End of Program
############################################################################
