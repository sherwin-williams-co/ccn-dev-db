#! /bin/sh
# 
# AUDIT_FTP.SH
# Shell Script will FTP to the Mainframe system all adds and changes
# made to the Oracle database daily. This flat file will be used to 
# update the IDMS database on the Mainframe System HostX.
# IDMS Mainframe file is 'STST.MDH01R.CCN00600.TEST.INPUT(+1)'

#This shell script has 2 processes:
#
#1) put AuditBackfeed.txt  'STST.MDH01R.CCN00600.TEST.INPUT(+1)' 
#2) mv AuditBackfeed.txt   current_datetime.log 
# Created Date =11/27/2012  by B.Ramsey
# Revised Date =06/18/2013  SH 
#               09/16/2015  sxh487 Added the Archive for Banking_backfeed file

# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

echo "Start script for FTP of Audit.txt" 

#$HOME/batchJobs/backFeed/logs; directory used for move
cdate=`date +'%Y%m%d%H%M%S'`

AUDIT_PATH="$HOME/batchJobs/backFeed/current/"
LOG_PATH="$HOME/batchJobs/backFeed/logs"
ARC_PATH="$HOME/batchJobs/backFeed/Archive"
file_name="Audit_backfeed.txt"
bank_fname="Banking_backfeed.txt"

cd $AUDIT_PATH
echo "Execute FTP to Mainframe" 
ftpResult=`ftp -n $mainframe_host <<FTP_MF
quote USER $mainframe_user
quote PASS $mainframe_pw
quote SITE RECFM=FB,LRECL=6000,BLKSIZE=24000,SPACE=(300,150),VOL(GDG350) CYL
put $file_name 'STST.MDH01R.CCN00600.TEST.INPUT(+1)'
bye
FTP_MF`
echo "FTP to Mainframe COMPLETED"

if [ "$ftpResult" -ne 0 ] ; then
  echo "ERROR: ftp of $file_name failed"
  exit 1
else
  echo "SUCCESS: ftp of $file_name completed successfully"
  #Archive Banking_backfeed.txt 
  echo "Moving Banking_backfeed.txt to Archive"
  mv $bank_fname $LOG_PATH/$bank_fname"_"$cdate
  
  #Archive the concatenated file
  echo "Move of Audit File to log"
  mv $file_name $LOG_PATH/$file_name"_"$cdate

  echo "Move of Data Files from current to Archive" 
  mv `find *_backfeed* -type f` $ARC_PATH

  echo "$file_name has been archived to $LOG_PATH path"
  exit 0
fi