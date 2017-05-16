#! /bin/sh
##########################################################
# Script to ftp the generated reports
#
# modified: 05/16/2017 rxa457 - asp-781 CCN Project Team... 
# Added conditions to ftp the file only when no errors or exceptions found in the log file, 
# else will email the error log file
##########################################################

# plgain_FTP.sh
# Use to ftp to mainframe to be loaded to Mobius manframe

TIME=`date +"%I:%M:%S"`
#Verify the log file for any instance of Exceptions or errors
val=`grep -i "Exception" /app/strdrft/sdReport/logs/Monthly_Reports_Run_bp.log`
vale=`grep -i "Error" /app/strdrft/sdReport/logs/Monthly_Reports_Run_bp.log`
#No Exceptions or Errors are found then Start FTP and cleanup files
if [ -z "$val" ] && [ -z "$vale" ]
then
	if [ -f /app/strdrft/sdReport/reports/final/glreport.txt ]
	then
		echo "\nNo errors or exceptions found.. Starting the FTP Process at $TIME on $DATE.."
		. /app/strdrft/dataloadInfo.txt

		cd /app/strdrft/sdReport/reports/final

		#ftp to mainframe
		#ftp -n ${mainframe_host} <<FTP_MF
		#quote USER ${mainframe_user}
		#quote PASS ${mainframe_pw}
		#quote SITE RECFM=FBA,LRECL=134,BLKSIZE=32696,SPACE=(600,60),VOL(GDG34F) TRACKS
		#put glreport.txt 'STST.STBD3340(+1)'
		#bye
	#FTP_MF

		echo "End of FTP.. Will now cleanup the generated files\n"
		sh /app/strdrft/sdReport/scripts/cleanup.sh
		exit 0
	else
		echo "Cannot Start FTP Process because Report File /app/strdrft/sdReport/reports/final/glreport.txt is not found"
	fi
#Exceptions or Errors are found in the Log file then cleanup the generated report files and email the log file
else
	echo "Exceptions found in the Log file so skipping FTP process and will start cleanup_and_email.. Please check the Log File for more details\n"
	sh /app/strdrft/sdReport/scripts/cleanup_and_email.sh
fi






