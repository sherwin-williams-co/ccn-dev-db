#################################################################
# Script name   : Monthly_Reports_Run_bp
#
# Description   : Checks for the monthly load trigger file and kicks off the reports run
#
# Created  : 01/15/2016 jxc517 CCN Project Team.....
# Modified : 04/06/2016 nxk927 CCN Project Team.....
#            changed the script as it was looping twice.
#            pushed the remove command at the start
#################################################################
#Run below command to make the process run in the background even after shutdown
#nohup sh /app/strdrft/sdReport/scripts/Monthly_Reports_Run_bp.sh > /app/strdrft/sdReport/logs/Monthly_Reports_Run_bp.log 2>&1 &

#Below statement will be used to check if the process is running in the background
#ps -eaf | grep Monthly_Reports_Run_bp.sh

while true; do
   if [ -f sd_monthly_load.trg ]
   then
      rm sd_monthly_load.trg
	  TIME=`date +"%I:%M:%S"`
	  DATE=`date +"%m/%d/%Y"`
	  echo "sd_monthly_load.trg trigger file removed at $TIME on $DATE"
	  echo "Running the Report Generation process at $TIME on $DATE"
	  sh sdreport.sh
      TIME=`date +"%I:%M:%S"`
	  echo "Running the FTP Process at $TIME on $DATE"
	  sh plgain_ftp.sh
      TIME=`date +"%I:%M:%S"`
	  echo "FTP Process completed at $TIME on $DATE"
	fi
done

echo "process completed - but should not come to this point"
exit 1
