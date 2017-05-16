##########################################################
# Script to Cleanup the generated files after completion of process or during errors1
# and send email if any errors or exceptions found in the log file
# Created:  5/16/2017 rxa457
##########################################################

###############################################
# Cleanup the Generated report TXT and PDF files; and then email the generated error LOG file
###############################################
echo "\nSTART CLEANUP_AND_EMAIL: Errors / Exceptions occured -- Removing generated report Files and Emailing the Log File.."

#Invoke cleanup function to remove the generated files
sh /app/strdrft/sdReport/scripts/cleanup.sh


LOGDIR=/app/strdrft/sdReport/logs
THISSCRIPT="Monthly_Reports_Run_bp"
DATE=`date +"%m%d%Y"`
TIME=`date +"%H%M%S"`
LOG_NAME=${THISSCRIPT}_${DATE}_${TIME}.log	

#Make a copy of the Error Log file for future reference 
cp $LOGDIR/$THISSCRIPT.log $LOGDIR/$LOG_NAME
echo "Monthly_Reports_Run_bp.log has been renamed to $LOG_NAME"
echo "\nPlease refer $LOGDIR/$LOG_NAME for complete details about the Errors/Exceptions occured in the report generation or Send process"

echo "END CLEANUP_AND_EMAIL"

#Emailing the Log File
logfile=`cat $LOGDIR/$THISSCRIPT.log`
sh /app/strdrft/sdReport/scripts/send_mail.sh MONTHLY_REPORTS_RUN_BP "$logfile"
############################################################################
# End of Program
############################################################################
