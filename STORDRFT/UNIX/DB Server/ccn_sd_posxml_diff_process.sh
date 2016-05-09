#!/bin/sh
###############################################################################################################################
# Script name   : ccn_sd_posxml_diff_process.sh
#
# Description   : This script is to run the SD_POSXML_INTF_DIFF_pkg.GEN_DELTA_FILES_sp
#
# Created  : 04/29/2016 axd783 CCN Project Team.....
# Modified : 
###############################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
proc1="GEN_DELTA_FILES_sp"
proc2="SEND_MAIL"

echo "Processing Started for $proc1 at $TIME on $DATE" 

./EXEC_PROC_NOPARAM.sh "SD_POSXML_INTF_DIFF_pkg.GEN_DELTA_FILES_sp"; 

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]; then     
     echo "processing FAILED for $proc1 at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc1 at ${TIME} on ${DATE}"
############################################################################
TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc2 at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw <<END 
set heading off;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
MAIL_PKG.send_mail('POSXML_DELTA_FILES_GEN');
 Exception
 when others then
 :exitCode := 2;
 END;
 /
exit :exitCode
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]; 
then     
     echo "processing FAILED for $proc2 at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc2 at ${TIME} on ${DATE}"
exit 0
############################################################################
