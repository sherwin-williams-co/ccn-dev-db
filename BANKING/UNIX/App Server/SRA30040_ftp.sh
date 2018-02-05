#!/bin/sh
#################################################################
# Script name   : SRA30040_ftp.sh
#
# Description   : This shell script will FTP the SRA30040.pdf report
#
# Created  : 08/30/2017 nxk927 CCN Project Team.....
# Modified : 
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

cd /app/banking/dev/CrReports/scripts

proc_name="SRA30040_ftp"
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc_name at $TIME on $DATE"

#################################################################
#         FTP file SRA30040
#################################################################
echo "Processing started for FTP at ${TIME} on ${DATE}"
if [ $RPT_INDICATOR == Y ] 
   then
   cd /app/banking/dev/CrReports/reports
ftp -inv ${rpt_host} <<FTP_MF
quote user ${rpt_user}
quote pass ${rpt_pw}
cd ${rpt_path}
binary
put SRA30040.pdf
bye
END_SCRIPT
echo "bye the transfer is complete"
FTP_MF

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

exit 0
