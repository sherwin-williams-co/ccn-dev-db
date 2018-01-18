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

#################################################################
#         FTP stores_div_roster_rpts
#################################################################

echo "Processing started for FTP at ${TIME} on ${DATE}"
rpt_list=`cat /app/ccn/crReports/data/run1.txt`
if [ $RPT_INDICATOR == Y ] 
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
TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"

cd /app/ccn/scripts
exit 0
