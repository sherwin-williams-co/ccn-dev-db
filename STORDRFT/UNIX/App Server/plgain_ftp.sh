#!/bin/sh

# plgain_FTP.sh
# Use to ftp to mainframe to be loaded to Mobius manframe

##########################################################
# Script to ftp the generated reports
#
# modified: 05/16/2017 rxa457 - asp-781 CCN Project Team... 
# Added conditions to ftp the file only when no errors or exceptions found in the log file, 
# else will email the error log file
##########################################################
#check for existance of glreport.txt in the folder. Cleanup and Email if report file not found
if [ ! -f /app/strdrft/sdReport/reports/final/glreport.txt ]
then
        echo "Cannot Start FTP Process because Report File /app/strdrft/sdReport/reports/final/glreport.txt is not found"
        ./cleanup_and_email_monthly_gl_reports.sh
        exit 1
fi
    
#Check for Exceptions or Errors in the log file. Cleanup and Email if errors or exception found
val=`grep -i "Exception" /app/strdrft/sdReport/logs/Monthly_Reports_Run_bp.log`
vale=`grep -i "Error" /app/strdrft/sdReport/logs/Monthly_Reports_Run_bp.log`
if [ ! -z "$val" ] || [ ! -z "$vale" ]
then
    echo "Exceptions found in the Log file.. skipping FTP process.  Starting cleanup_and_email now.. Please check the Log File for more details\n"
    ./cleanup_and_email_monthly_gl_reports.sh
    exit 1
fi

DATE=`date +"%m/%d/%Y"`
TIME=`date +"%I:%M:%S"`

echo "\nStarting the FTP Process at $TIME on $DATE.."
. /app/strdrft/dataloadInfo.txt

cd /app/strdrft/sdReport/reports/final

# ftp to mainframe
ftp -n ${mainframe_host} <<FTP_MF
quote USER ${mainframe_user}
quote PASS ${mainframe_pw}
quote SITE RECFM=FBA,LRECL=134,BLKSIZE=32696,SPACE=(600,60),VOL(GDG34F) TRACKS
put glreport.txt 'STST.STBD3340(+1)'

bye
FTP_MF

echo "End of FTP.. Cleanup the generated files\n"
cd /app/strdrft/sdReport/scripts 
./cleanup_monthly_gl_reports.sh
exit 0