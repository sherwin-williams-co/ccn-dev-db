#!/bin/sh
#############################################################################
# Script Name   :  incomplete_cc.sh
#
# Description    :  This shell program will send email with incomplete cost centers
#                   details attached as a csv
#
# Created           :  JXC517 11/08/2013
############################################################################
. /app/ccn/ccn.config

 proc="incomplete cost center email"
 LOGDIR="/app/ccn/batchJobs/backFeed/Archive"
 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
 TimeStamp=`date '+%Y%m%d%H%M%S'`

ORACLE_HOME=/swstores/oracle/stpresq/product/11g
export ORACLE_HOME

ORACLE_SID=STPRESQ1
export ORACLE_SID

PATH=$PATH:$ORACLE_HOME/bin 
export PATH

echo "\n Processing Started for $proc at $TIME on $DATE \n"

$ORACLE_HOME/bin/sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;

execute MAIL_PKG.send_mail('INCOMPLETE_CC');

exit;
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if test $status -ne 0
then
     echo "\n processing FAILED for $proc at ${TIME} on ${DATE}\n"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "\n Processing finished for $proc at ${TIME} on ${DATE}\n"  

############################################################################

