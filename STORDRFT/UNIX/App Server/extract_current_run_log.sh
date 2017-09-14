#!/bin/sh
##########################################################
# This Script extracts the current run's log information from the Log file and
#  writes into a separate file which can be used to check exceptions and emailing
#
# Created: 09/12/2017 rxa457 CCN Project Team... 
#          Reference asp-864 
##########################################################

#Identify starting Line number of current run from the log file
echo "Extracting current Run's Log information"
curlineno=`grep -n "sd_monthly_load.trg trigger file found at" /app/strdrft/sdReport/logs/Monthly_Reports_Run_bp.log|cut -f1 -d:|tail -1`

#Tail the current run log file content
sed -n -e ''''$curlineno''',$p' /app/strdrft/sdReport/logs/Monthly_Reports_Run_bp.log > /app/strdrft/sdReport/logs/Monthly_Reports_Run_bp.temp

#Remove Single quotes from the current run temp log file to avoid send_mail pkg errors
echo "Removing any Single Quotes available from the Log file"
sed "s/'//g" /app/strdrft/sdReport/logs/Monthly_Reports_Run_bp.temp > /app/strdrft/sdReport/logs/Monthly_Reports_Run_bp_Current.log

#Remove the temporary file created by the sed process
echo "Cleanup Temporary Files"
rm -f /app/strdrft/sdReport/logs/Monthly_Reports_Run_bp.temp

#Archiving the current run's Log file
LOGDIR=/app/strdrft/sdReport/logs
THISSCRIPT="Monthly_Reports_Run_bp"
DATE=`date +"%m%d%Y"`
TIME=`date +"%H%M%S"`
CURRENT_RUN=${THISSCRIPT}_"Current_"${DATE}_${TIME}.log

echo "Monthly_Reports_Run_bp_Current.log has been archived as $CURRENT_RUN"
#Archive Current runs Log file
cp $LOGDIR/$THISSCRIPT"_Current".log $LOGDIR/$CURRENT_RUN
exit 0
