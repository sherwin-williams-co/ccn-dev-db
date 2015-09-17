#! /bin/sh

##############################################################################################
# Shell Script will FTP to the CCN DB Server all adds and changes
# made to the Oracle database daily. This flat file will be used to 
# concatenate with the CCN audit file and then finally 
# update the IDMS database on the Mainframe System HostX.
# IDMS Mainframe file is 'STST.MDH01R.CCN00600.DEV.INPUT(+1)'
#
# Created : 09/16/2015 jxc517 CCN Project....
# Revised :
##############################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

echo "Start script for FTP of Audit.txt" 
cdate=`date +'%Y%m%d%H%M%S'`

AUDIT_PATH="$HOME/batchJobs/backFeed/current/"
LOG_PATH="$HOME/batchJobs/backFeed/logs"
ARC_PATH="$HOME/batchJobs/backFeed/Archive"
src_file_name="Banking_backfeed.txt"
dest_file_name="Banking_audit.txt"

cd $AUDIT_PATH
echo "Execute FTP to Mainframe" 
ftpResult=`ftp -n $ccndbserver_host <<FTP_MF
quote USER $ccndbserver_user
quote PASS $ccndbserver_pw
put $src_file_name /app/ccn/dev/batchJobs/backFeed/current/$dest_file_name
bye
FTP_MF`
echo "FTP to Mainframe COMPLETED"

if [ "$ftpResult" -ne 0 ] ; then
  echo "ERROR: ftp of $file_name failed"
  exit 1
else
  echo "SUCCESS: ftp of $file_name completed successfully"
  #Archive the concatenated file
  echo "Move of Audit File to log"
  mv $file_name $LOG_PATH/$file_name"_"$cdate

  echo "Move of Data Files from current to Archive" 
  mv `find *_backfeed* -type f` $ARC_PATH

  echo "$file_name has been archived to $LOG_PATH path"
  exit 0
fi
