#!/bin/sh


############################################################################
# Script name   : deposit_tkts_onhand_qty_rpt.sh
# Description   : This shell script is used to generate excel report 
#                 for Deposit tickets onHand Qty on a daily basis at 8AM
# 
# Created  : 06/23/2017 sxp130 ASP_805
# Modified : 
############################################################################

# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="deposit_tkts_onhand_qty_rpt"
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`

echo "Processing Started for $proc_name at $TIME on $DATE"

#################################################################
#   deposit_tkts_onhand_qty_rpt processing
#################################################################
sqlplus -s -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw <<END
set heading off;
set serveroutput on;
set verify off;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
var exitCode number;
exec :exitCode := 0;
@$HOME/sql/deposit_tkts_onhand_qty_rpt.sql
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
     exit 1
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################