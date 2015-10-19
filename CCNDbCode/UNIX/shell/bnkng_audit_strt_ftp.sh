#!/bin/sh
#################################################################
# Script name   : bnkng_audit_strt_ftp.sh
#
# Description   : if cmd_start.sh is generated check for the command Main_Audit.sh  
#                 FTP a trigger file to kick off the main_audit.sh in banking
#
# Created  : 10/12/2015 nxk927 CCN Project Team.....
# Modified : 
#################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

cd $HOME/datafiles

val=`grep "Main_Audit.sh" cmd_start.sh`

if [ -z "$val" ]
then
echo "Don't kick off the main_audit.sh"
else
echo "Execute FTP to Mainframe" 
ftpResult=`ftp -n $banking_host <<FTP_MF
quote USER $banking_user
quote PASS $banking_pw
cd /app/banking/dev/
put cmd_start.sh audit_start
bye
FTP_MF`
echo "FTP to banking COMPLETED"
fi
############################################################################
#                           ERROR STATUS CHECK                             # 
############################################################################
if [ "$?" -ne 0 ] ; then
  echo "ERROR: ftp of cmd_start.sh failed"
  exit 1
else
  echo "SUCCESS: ftp of cmd_start.sh completed successfully"
  exit 0
fi
exit 0