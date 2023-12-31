#!/bin/sh

# plgain_FTP.sh
# Use to ftp to mainframe to be loaded to Mobius manframe

##########################################################
# Script to ftp the generated reports
#
# modified: 05/16/2017 rxa457 - asp-781 CCN Project Team... 
# Added conditions to ftp the file only when no errors or exceptions found in the log file, 
# else will email the error log file
#         : 09/14/2017 rxa457 CCN Project Team...
#               Checking current run's log information for any errors instead of checking the 
#                main BP log which accumulates all the month's run log into the same file
#modified : 02/08/2018 nxk927 added ftp check condition for the restrict ftp from lower environment ('SMIS1.STBD3340(+1)' prod report id)
##########################################################
dt=`date +"%m%d%Y"`
#check for existance of glreport.txt in the folder. Cleanup and Email if report file not found
if [ ! -f /app/strdrft/sdReport/reports/final/glreport.txt ]
then
        echo "Cannot Start FTP Process because Report File /app/strdrft/sdReport/reports/final/glreport.txt is not found"
        ./cleanup_and_email_monthly_gl_reports.sh
        exit 1
fi
    
#Check for Exceptions or Errors in the log file. Cleanup and Email if errors or exception found
val=`grep -i "Exception" /app/strdrft/sdReport/logs/Monthly_Reports_Run_bp_${dt}.log`
vale=`grep -i "Error" /app/strdrft/sdReport/logs/Monthly_Reports_Run_bp_${dt}.log`
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
if [ "$ftp_ind" == "Y" ]
then
# ftp to mainframe
ftp -n ${mainframe_host} <<FTP_MF
quote USER ${mainframe_user}
quote PASS ${mainframe_pw}
cd ${mainframe_path}
put glreport.txt ${gl_report_id}

bye
FTP_MF
else
  echo " FTP is ignored in lower enviornments"
fi

echo "End of FTP.. Cleanup the generated files\n"
cd /app/strdrft/sdReport/scripts
./cleanup_monthly_gl_reports.sh

echo "Ftp'ing the trigger file to have the reports loaded\n"
cd /app/strdrft/sdReport/scripts
./sd_ftp_trigger_file.sh

echo "Ftp'ing the trigger file completed\n"
exit 0