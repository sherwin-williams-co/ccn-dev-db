#!/bin/sh
#################################################################
# Script name   : SRA30000_dailyRun_ftp.sh
#
# Description   : Use to ftp the SRA30000 files to stuar2hq.sw.sherwin.com server
#
# Created  : 10/17/2016 vxv336 CCN Project Team.....
# Modified : 
#
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="SRA30000_dailyRun_ftp"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
YYMMDD=`date +"%y%m%d"`
echo "Processing Started for $proc_name at $TIME on $DATE"

############################################################################
# ftp the SRA30000 
# files to stuar2hq.sw.sherwin.com server 
############################################################################
cd $HOME/initLoad
ftp -inv ${uar_host} <<FTP_MF
quote user ${uar_user}
quote pass ${uar_pw}
cd "/reconnet/uardata/rt1/TEST INPUT"
put SRA30000_D$YYMMDD* uar_gift_card.pos
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
