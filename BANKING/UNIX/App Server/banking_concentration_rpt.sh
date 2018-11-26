#!/bin/sh
cd /app/banking/dev
#################################################################
# Script name   : banking_concentration_rpt.sh
#
# Description   : This script is to run the following:
#                 BANKING_BATCH_PKG.BANKING_CONCENTRATION_MONTHLY_RPT
#                 Generate banking concentrion report on monhtly basis.
# Created       : 10/09/2018 pxa852 CCN Project Team.....
# Modified 
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="banking_concentration_rpt"
IN_RUN_DATE=$1
LOGDIR=$HOME/logs
TIME=`date +"%H:%M:%S"`
DATE=`date +"%d-%b-%y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
echo "Processing Started for $proc_name at $TIME on $DATE"

case "$IN_RUN_DATE" in ([0-3][0-9]-[A-Z][A-Z][A-Z]-[12][0189][0-9][0-9])
      dtformat="Y";;
  (*) dtformat="N";;
esac

if [[ "$dtformat" = "N" && "$IN_RUN_DATE" != "" ]] ; then
   echo $IN_RUN_DATE is NOT a valid DD-MON-YYYY date
   exit 1
fi

sqlplus -s -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw >> $LOGDIR/$proc_name"_"$TimeStamp.log <<END
set heading off;
set verify off;
set serveroutput on;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
exec :exitCode := 0;
EXECUTE BANKING_BATCH_PKG.BANKING_CONCENTRATION_MONTHLY_RPT('$IN_RUN_DATE');
exit :exitCode;
END

#################################################################
#                  ERROR STATUS CHECK
#################################################################
status=$?
if test $status -ne 0
then
    TIME=`date +"%H:%M:%S"`
    echo "processing FAILED for $proc_name - BANKING_BATCH_PKG.BANKING_CONCENTRATION_MONTHLY_RPT at ${TIME} on ${DATE}"
    cd $HOME/
   ./send_mail.sh BANKING_CONCENTRATION_ERROR
    exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"
exit 0
############################################################################