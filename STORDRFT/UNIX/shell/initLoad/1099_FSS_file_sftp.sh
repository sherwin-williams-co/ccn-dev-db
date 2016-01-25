#!/bin/sh
##############################################################################################################
# Script name   : 1099_FSS_file_sftp.sh
#
# Description   : This shell program will initiate the 1099 FSS process as and when needed
#
# Created  : 08/28/2015 jxc517 CCN Project Team.....
# Modified : 
##############################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc="1099_FSS_monthly_file_sftp"
LOGDIR="$HOME/initLoad/logs"
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
src_file=$HOME/datafiles/STINSINV*.TXT
#trgt_dir=/inbound
trgt_dir=/app/strdrft/sdReport

echo "Processing Started for $proc at $TIME on $DATE"

/usr/bin/expect >> $LOGDIR/$proc"_"$TimeStamp.log << EOD
spawn /usr/bin/sftp -o Port=22 -o StrictHostKeyChecking=no $swerp_erp_user@$swerp_erp_host
expect "password:"
send "$swerp_erp_pw\r"
expect "sftp> "
send "put $src_file $trgt_dir\r"
expect "sftp>"
send -- "exit\r"
send -- "exit\r"
exit 0
EOD

############################################################################
#                           ARCHIVING THE FILES 
############################################################################
mv $HOME/datafiles/STINSINV*.TXT $HOME/datafiles/archieve/1099_FSS

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]; then
     echo "Processing failed for $proc at ${TIME} on ${DATE}"  
     exit 1;
fi

echo "Processing finished for $proc at ${TIME} on ${DATE}"  
exit 0
############################################################################
