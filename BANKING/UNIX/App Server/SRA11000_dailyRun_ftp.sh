#!/bin/sh
#################################################################
# Script name   : SRA11000_dailyRun_ftp.sh
#
# Description   : Use to ftp the SRA11000 SEIRAL.DAT [SMIS1.SRA10060_*] and 
#                 UAR.POS [SMIS1.SRA12060_*] files to stuar2hq.sw.sherwin.com server
#
# Created  : 10/16/2015 jxc517 CCN Project Team.....
# Modified : 04/27/2016 nxk927 CCN Project Team.....
#            pushed the time variable inside in teh error check so the error check can be handled properly
# Modified : 04/07/2017 nxk927 CCN Project Team.....
#            added the ftp_indicator to control ftp of the file
# Modified : 06/16/2017 nxk927 CCN Project Team.....
#             added a check to see if the file has data
# Modified : 08/15/2017 nxk927 CCN Project Team.....
#            Path changed. This needs to be changed only in Prod
# Modified : 06/18/2018 nxk927 CCN Project Team.....
#            adding timestamp in the ftp'ed file
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="SRA11000_dailyRun_ftp"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
DT=`date +"%m%d%Y%H%M%S"`

echo "Processing Started for $proc_name at $TIME on $DATE"
if [ $FTP_INDICATOR == Y ] 
then
   cd /app/banking/dev/initLoad
   file=SMIS1.SRA12060_*
   if [ `ls -l $file | awk '{print $5}'` -ne 0 ]
   then
############################################################################
# ftp the SRA11000 SEIRAL.DAT [SMIS1.SRA10060_*] and UAR.POS [SMIS1.SRA12060_*]
# files to stuar2hq.sw.sherwin.com server 
############################################################################
ftp -inv ${uar_host} <<FTP_MF
quote user ${uar_user}
quote pass ${uar_pw}
cd "/reconnet/uardata/rt1/input"
put SMIS1.SRA10060_* serial_"$DT".dat
put SMIS1.SRA12060_* uar_"$DT".pos
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
