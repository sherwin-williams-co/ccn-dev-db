#!/bin/sh
##########################################################
# Script to Run the reports
#
# modified: 12/13/2017 nxk927 CCN Project Team... 
# Added Script Comments and Handled exceptions 
##########################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/ccn/ccn_app_server.config

proc_name="stores_div_roster_rpt_ftp"
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc_name at $TIME on $DATE"

dt=`date +"%m%d%Y"`
#Check for Exceptions or Errors in the log file. Cleanup and Email if errors or exception found
exception=`grep -i "Exception" /app/ccn/crReports/log/stores_div_roster_rpt${dt}.log`
error=`grep -i "Error" /app/ccn/crReports/log/stores_div_roster_rpt${dt}.log`
if [ ! -z "$exception" ] || [ ! -z "$error" ]
then
    echo "Exceptions found in the Log file.. skipping FTP process.  Please check the Log File for more details\n"
    ./send_mail.sh "STORES_DIV_ROSTER_RPT"
    exit 1
fi


#################################################################
#         FTP stores_div_roster_rpts
#################################################################

echo "Processing started for FTP at ${TIME} on ${DATE}"
rpt_list=`cat /app/ccn/crReports/data/stores_div_roster_rpt.txt`
if [ $FTP_INDICATOR == Y ] 
   then
cd /app/ccn/crReports/reports
for rpt in $rpt_list
do
rpt_file=`echo $rpt  | cut -f2 -d"." -f1`
echo $rpt_file
ftp -inv ${rpt_host} <<FTP_MF
quote user ${rpt_user}
quote pass ${rpt_pw}
cd ${rpt_path}
binary
put $rpt_file.pdf
bye
END_SCRIPT
echo "bye the transfer is complete"
FTP_MF

#Archive PDF file
DT=`date +"%m%d%Y%H%M%S"`
mv /app/ccn/crReports/reports/$rpt_file.pdf /app/ccn/crReports/reports/archive/$rpt_file"_"$DT.pdf
done

status=$?
if test $status -ne 0
then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi
else
echo "FTP Not allowed in this environment. FTP Indicator must be set to Y to FTP the file"
echo "Existing the process without ftp'ing the file"
fi

echo "Ftp'ing the trigger file to have the reports loaded\n"
cd /app/ccn/scripts
./ccn_ftp_trigger_file.sh

echo "Ftp'ing the trigger file completed\n"

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"

exit 0
