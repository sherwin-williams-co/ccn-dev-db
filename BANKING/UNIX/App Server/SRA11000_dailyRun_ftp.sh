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
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="SRA11000_dailyRun_ftp"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"

############################################################################
# ftp the SRA11000 SEIRAL.DAT [SMIS1.SRA10060_*] and UAR.POS [SMIS1.SRA12060_*]
# files to stuar2hq.sw.sherwin.com server 
############################################################################
cd /app/banking/dev/initLoad
ftp -inv ${uar_host} <<FTP_MF
quote user ${uar_user}
quote pass ${uar_pw}
cd "/reconnet/uardata/rt1/TEST INPUT"
put SMIS1.SRA10060_* serial.dat
put SMIS1.SRA12060_* uar.pos
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
TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
