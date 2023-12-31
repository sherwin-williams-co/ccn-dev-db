#!/bin/sh
#################################################################
# Script name   : SRA11000_cashflow_corrects_FTP.sh
#
# Description   : This shell script will FTP the CFA file to UAR
#
# Created  : 06/15/2017 nxk927 CCN Project Team.....
# Modified : 06/16/2017 nxk927 CCN Project Team.....
#             added a check to see if the file has data
# Modified : 08/14/2017 nxk927 CCN Project Team.....
#            changed the variable name in the config file
# Modified : 08/22/2017 nxk927 CCN Project Team.....
#            updated the proc name
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="SRA11000_cashflow_corrects_FTP"
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc_name at $TIME on $DATE"

#################################################################
#         FTP files stores_cashflowadj_*
#################################################################
echo "Processing started for FTP at ${TIME} on ${DATE}"
if [ $FTP_INDICATOR == Y ] 
   then
   cd /app/banking/dev/initLoad
   file=stores_cashflowadj_*
   if [ `ls -l $file | awk '{print $5}'` -ne 0 ]
   then
ftp -inv ${smart_host} <<FTP_MF
quote user ${smart_user}
quote pass ${smart_pw}
cd /sw/smart_adm/loads/uar-adjustments/data
put stores_cashflowadj_*
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
echo "File don't have any data to be FTPed."
fi
else
echo "FTP Not allowed in this environment. FTP Indicator must be set to Y to FTP the file"
echo "Existing the process without ftp'ing the file"
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"

exit 0
