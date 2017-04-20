#!/bin/sh
#############################################################################################################################
# Script name   : PCI_TERMINAL_MAIL.sh
#
# Description   : This script is to run the CCN_BATCH_PROCESS.PCI_TERMINAL_MISMATCH procedure that send 
#		  all PCI emails at 6.30 PM (Monday till Saturday)
# Created       : 04/07/2017 pxb712 
# Modified      : 
#############################################################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

proc_name="PCI_TERMINAL_MISMATCH"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m%d%Y"`

echo "Processing Started for $proc_name at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $proc_name"_"$DATE.log <<END
set heading off;
set verify off;
set serveroutput on;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;

CCN_BATCH_PROCESS.PCI_TERMINAL_MISMATCH();
EXCEPTION
 when others then
 :exitCode := 2;
 END;
 /
exit :exitCode;
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0