#! /bin/sh
# 
# AUDIT_FTP.SH
# Shell Script will FTP to the Mainframe system all adds and changes
# made to the Oracle database daily. This flat file will be used to 
# update the IDMS database on the Mainframe System HostX.
# IDMS Mainframe file is 'SMIS1.ORACLE.CCN00600.INPUT(+1)'

#This shell script has 2 processes:
#
#1) put AuditBackfeed.txt  'SMIS1.ORACLE.CCN00600.INPUT(+1)' 
#2) mv AuditBackfeed.txt   current_datetime.log 
# Created Date =11/27/2012  by B.Ramsey
# Revised Date =06/18/2013  SH 

. /app/ccn/ccn.config 

echo "\n Start script for FTP of Audit.txt \n" 

#/app/ccn/batchJobs/backFeed/logs; directory used for move
cdate=`date +'%Y%m%d%H%M%S'`

AUDIT_PATH="/app/ccn/batchJobs/backFeed/current/"
LOG_PATH="/app/ccn/batchJobs/backFeed/logs"
ARC_PATH="/app/ccn/batchJobs/backFeed/Archive"
file_name="Audit_backfeed.txt"

cd $AUDIT_PATH
echo "\n  Execute FTP to Mainframe \n" 
ftpResult=`ftp -n $mainframe_host <<FTP_MF
quote USER $mainframe_user
quote PASS $mainframe_pw
quote SITE RECFM=FB,LRECL=6000,BLKSIZE=24000,SPACE=(300,150),VOL(GDG350) CYL
put $file_name  'SMIS1.ORACLE.CCN00600.INPUT(+1)' 
bye
FTP_MF`
echo "\n FTP to Mainframe COMPLETED \n"

if [ "$ftpResult" -ne 0 ] ; then
  echo "ERROR: ftp of $file_name failed"
  exit 1
else
  echo "SUCCESS: ftp of $file_name completed successfully"
  #Archive the concatenated file
  echo "\n Move of Audit File to log \n"
  mv $file_name $LOG_PATH/$file_name"_"$cdate

  echo "\n Move of Data Files from current to Archive \n" 
  mv `find *_backfeed* -type f` $ARC_PATH

  echo "$file_name has been archived to $LOG_PATH path"
  exit 0
fi
