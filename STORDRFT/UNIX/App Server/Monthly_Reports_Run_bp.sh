#################################################################
# Script name   : Monthly_Reports_Run_bp
#
# Description   : Checks for the monthly load trigger file and kicks off the reports run
#
# Created  : 01/15/2016 jxc517 CCN Project Team.....
# Modified : 01/29/2016 jxc517 CCN Project Team.....
#            Modified the order of removing the trigger file to avoid infinite loop
#            Also modified the calling process to not include absolute path
#          : 04/08/2016 nxk927 CCN Project Team.....
#            changed the executable ./ to sh to eliminate the 2 process running in the background
#			: 05/08/2017 rxa457 - asp-781 CCN Project Team... 
#			 Modified script to remove the generated txt and pdf files at the end of process. And also handle exceptions properly and record them in the log file and send an email at the end to CCN oracle team
#################################################################
#Run below command to make the process run in the background even after shutdown
#nohup sh /app/strdrft/sdReport/scripts/Monthly_Reports_Run_bp.sh > /app/strdrft/sdReport/logs/Monthly_Reports_Run_bp.log 2>&1 &

#Below statement will be used to check if the process is running in the background
#ps -eaf | grep Monthly_Reports_Run_bp.sh

#Function to remove the generated report TXT and PDF files
cleanup()
{
	echo "\nSTART CLEANUP: Cleaning up Generated TXT and PDF files(If Any) to avoid sending previous month files"
	FPATH="/app/strdrft/sdReport/reports/final"
	FPATH2="/app/strdrft/sdReport/reports"
	run=`cat /app/strdrft/sdReport/data/run1.txt`

	for file in $run
	do
		filename=`basename $file .rpt` 
		if [ -f $FPATH/$filename.txt ]
		then
			echo "Removing $FPATH/$filename.txt"
			rm -f $FPATH/$filename.txt
		fi
		if [ -f $FPATH2/$filename.pdf ]
		then
			echo "Removing $FPATH2/$filename.pdf"
			rm -f $FPATH2/$filename.pdf
		fi
	done 

	if [ -f $FPATH/glreport.txt ]
	then
		echo "Removing $FPATH/glreport.txt"
		rm -f $FPATH/glreport.txt
	fi
	
	echo "END CLEANUP"
}

#Function to remove the generated report TXT and PDF files (calls cleanup function for cleanup), and then email the generated LOG file
cleanup_and_email()
{
	echo "\nSTART CLEANUP_AND_EMAIL: Errors / Exceptions occured -- Removing generated report Files and Emailing the Log File.."
	LOGDIR=/app/strdrft/sdReport/logs
	THISSCRIPT="Monthly_Reports_Run_bp"
	DATE=`date +"%m%d%Y"`
	TIME=`date +"%H%M%S"`
	LOG_NAME=${THISSCRIPT}_${DATE}_${TIME}.log	
	
	#Invoke cleanup function to remove the generated files
	cleanup
	
	#Make a copy of the Error Log file for future reference 
	cp $LOGDIR/$THISSCRIPT.log $LOGDIR/$LOG_NAME
	echo "Monthly_Reports_Run_bp.log has been renamed to $LOG_NAME.. Now Sending Email..."
	
	echo "\nPlease refer $LOGDIR/$LOG_NAME for complete details about the Errors/Exceptions occured in the report generation or Send process"

	echo "END CLEANUP_AND_EMAIL"

	#Emailing the Log File
	logfile=`cat $LOGDIR/$THISSCRIPT.log`
	sh /app/strdrft/sdReport/scripts/send_mail.sh MONTHLY_REPORTS_RUN_BP "$logfile"
}

#Cleanup generated files in the event of unexpected exit signals	   
trap cleanup EXIT

while true; do
   if [ -f /app/strdrft/sdReport/data/sd_monthly_load.trg ]
   then
      DATE=`date +"%m/%d/%Y"`
      TIME=`date +"%I:%M:%S"`
      echo "sd_monthly_load.trg trigger file found at $TIME on $DATE"
      echo "Removing sd_monthly_load.trg trigger file at $TIME on $DATE"
      rm -f /app/strdrft/sdReport/data/sd_monthly_load.trg
      TIME=`date +"%I:%M:%S"`
      echo "sd_monthly_load.trg trigger file removed at $TIME on $DATE"
      cd /app/strdrft/sdReport/scripts
      echo "Running the Report Generation process at $TIME on $DATE"
      sh sdreport.sh
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
				sh plgain_ftp.sh || echo "Unknown Exception Occured during FTP Process.."
				echo "End of FTP.. Will now cleanup the generated files\n"
				cleanup
			else
				echo "Cannot Start FTP Process because Report File /app/strdrft/sdReport/reports/final/glreport.txt is not found"
   fi
		#Exceptions or Errors are found in the Log file then cleanup the generated report files and email the log file
		else
			echo "Exceptions found in the Log file so skipping FTP process and will start cleanup_and_email.. Please check the Log File for more details\n"
			cleanup_and_email
		fi
	fi
done

echo "process completed - but should not come to this point"
exit 1
