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
#2) mv AuditBackfeed.txt  AuditBackfeedLog(current_date&time).log
# Created Date =11/27/2012  by B.Ramsey
# Revised Date = 

. /app/ccn/ccn.config 

echo ' \n Start script for FTP of  AuditFileName.txt \n ' 

#/app/ccn/batchJobs/backFeed/logs; directory used for move
cdate=`date +'%Y%m%d%H%M%S'`

auditpath=/app/ccn/batchJobs/backFeed/current/
auditlogpath=/app/ccn/batchJobs/backFeed/logs/
newname=$auditlogpath$AuditLogName$cdate.log

echo ' \n  Execute FTP to Mainframe \n ' 
ftpResult=`ftp -n $mainframe_host <<FTP_MF
quote USER $mainframe_user
quote PASS $mainframe_pw
quote SITE RECFM=FBA,LRECL=820,BLKSIZE=27880,SPACE=(600,100),VOL(GDG350) TRACKS
put $auditpath$AuditFileName  'SMIS1.ORACLE.CCN00600.INPUT(+1)' 
bye
FTP_MF`
echo '\n FTP to Mainframe COMPLETED \n '

#The $auditpath$AuditFileName will be moved to a Log file with a date/time stamp

echo ' \n Move of Audit File  \n  '
echo 'AuditFileName='  $auditpath$AuditFileName

mv $auditpath$AuditFileName  $newname 

echo 'AuditLogName=' $newname 
echo ' \n Move of Audit file COMPLETED  \n  '

exit

