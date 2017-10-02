#!/bin/sh
##############################################################################################################################
# Script name   : cstmr_deposit_daily_load.sh
#
# Description   : This shell program will initiate the script that
#                 Loads all the customer deposit tables
#                 It also sends the emails regarding starting and ending of the process
#
# Created  : 09/27/2017 sxh487 CCN Project Team.....
###############################################################################################################################
# below command will get the path for cstmr_dep.config respective to the environment from which it is run from
. /app/cstmrdpsts/host.sh
proc="daily_cstmr_dep_load"
LOGDIR=$HOME/dailyLoad/logs
TIME=`date +"%H:%M:%S"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;
set serveroutput on;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
CUSTOMER_DEPOSITS_DAILY_LOAD.CSTMR_DEPOSIT_DLY_LOAD_SP();
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
if [ $status -ne 0 ]; then
     cd $HOME/dailyLoad
     echo "Processing Failed for $proc at $TIME on $DATE"
     exit 1;
fi

echo "Processing finished for $proc at ${TIME} on ${DATE}"

exit 0
############################################################################
