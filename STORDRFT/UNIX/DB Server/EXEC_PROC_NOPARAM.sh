#!/bin/sh
###############################################################################################################################
# Script name   : EXEC_PROC_NOPARAM.sh
#
# Description   : This script is to run the Database procedure with no input paramters
#
# Created  : 05/02/2016 axd783 CCN Project Team.....
# Modified : 
###############################################################################################################################

# below command will get the path for fpr.config respective to the environment from which it is run from
. /app/stordrft/host.sh

TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`

proc_name=$1"();"

echo "Processing Started for $proc_name at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw <<END
set heading off;
set serveroutput on;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
$proc_name
 Exception 
 when others then
 :exitCode := 2;
END;
/
exit :exitCode;
END

#############################################################
# ERROR CHECK   
#############################################################
status=$?
TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ];
then
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  
exit 0
#############################################################


