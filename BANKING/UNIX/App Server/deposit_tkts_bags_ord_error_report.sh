#!/bin/sh
#################################################################
# Script name   : deposit_tkts_bags_ord_error_report.sh
# Description   : This shell script is used to generate excel report 
#                 for Deposit tickets/bags Order failures on a daily basis
# 
# Created  : 11/21/2016 gxg192
# Modified : 
#################################################################

# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="deposit_tkts_bags_err_rpt"
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`

echo "Processing Started for $proc_name at $TIME on $DATE"

#################################################################
#  Executing SQLs to generate the report and send email
#################################################################
echo "Started executing sql scripts to generate reports and send email at ${TIME} on ${DATE}"
sqlplus -s -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw <<END
set heading off;
set serveroutput on;
set verify off;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
var exitCode number;
exec :exitCode := 0;
@$HOME/sql/tckts_order_error_report.sql
@$HOME/sql/bags_order_error_report.sql
print :exitcode;
exit :exitCode;
END

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
############################################################################
