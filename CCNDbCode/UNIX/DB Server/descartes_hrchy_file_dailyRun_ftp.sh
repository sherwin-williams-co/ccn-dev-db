#!/bin/sh
#################################################################
# Script name   : descartes_hrchy_file_dailyRun_ftp.sh
#
# Description   : FTP the HRCHY ORG feed output file to DESCARTES
#
# Created  : 09/29/2017 rxa457 CCN Project Team.....
#################################################################
# below command will get the path for config respective to the environment from which it is run from
. /app/ccn/host.sh

proc_name="descartes_hrchy_file_dailyRun_ftp"
datafilepath=$HOME/datafiles
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
DT=`date +"%m%d%Y"`

echo "Processing Started for $proc_name at $TIME on $DATE"
if [ $FTP_INDICATOR == Y ] 
then
   cd $datafilepath/
   file=DESCARTES_HRCHY_FEED_$DT*
   if [ `ls -l $file | awk '{print $5}'` -ne 0 ]
   then
############################################################################
# ftp DESCARTES_HRCHY_FEED_$DT 
############################################################################
ftp -inv ${descartes_host} <<FTP_MF
quote user ${descartes_user}
quote pass ${descartes_pw}
cd "$descartes_folder"
put DESCARTES_HRCHY_FEED_$DT*
bye
END_SCRIPT
echo "bye the transfer is complete"
FTP_MF

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
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
