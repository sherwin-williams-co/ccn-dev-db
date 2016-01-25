#################################################################
# Script name   : Monthly_Reports_Run_bp
#
# Description   : Checks for the monthly load trigger file and kicks off the reports run
#
# Created  : 01/15/2016 jxc517 CCN Project Team.....
# Modified : 
#################################################################
#Run below command to make the process run in the background even after shutdown
#nohup sh /app/strdrft/sdReport/scripts/Monthly_Reports_Run_bp.sh > /app/strdrft/sdReport/logs/Monthly_Reports_Run_bp.log 2>&1 &

#Below statement will be used to check if the process is running in the background
#ps -eaf | grep Monthly_Reports_Run_bp.sh

while true; do
   if [ -f /app/strdrft/sdReport/data/sd_monthly_load.trg ]
   then
          DATE=`date +"%m/%d/%Y"`
          TIME=`date +"%I:%M:%S"`
	  echo "sd_monthly_load.trg trigger file found at $TIME on $DATE"
	  echo "Running the Report Generatin process at $TIME on $DATE"
	  #./app/strdrft/sdReport/scripts/sdreport.sh	  
          TIME=`date +"%I:%M:%S"`
	  echo "Running the FTP Process at $TIME on $DATE"
	  #./app/strdrft/sdReport/scripts/plgain_ftp.sh
          TIME=`date +"%I:%M:%S"`
	  echo "Removing sd_monthly_load.trg trigger file at $TIME on $DATE"
	  rm -f /app/strdrft/sdReport/data/sd_monthly_load.trg
          TIME=`date +"%I:%M:%S"`
	  echo "sd_monthly_load.trg trigger file removed at $TIME on $DATE"
   fi
done

echo "process completed - but should not come to this point"
exit 1
