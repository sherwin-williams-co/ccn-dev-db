#!/bin/sh
##############################################################################################################################
# Script name   : cstmr_dep_zero_net_close_dt_upd.sh
#
# Description   : This shell program will initiate the script that
#                 update the table "CUSTOMER_DEPOSIT_DETAILS" If Net Balance is Zero
#
# Created       : 01/14/2019 sxg151 CCN Project Team.....
###############################################################################################################################
cd /app/cstmrdpsts/batchJobs

# below command will get the path for cstmr_dep.config respective to the environment from which it is run from
. /app/cstmrdpsts/cstmr_dep.config

proc="cstmr_dep_zero_net_close_dt_upd"
LOGDIR=$HOME/logs
TIME=`date +"%H:%M:%S"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user@$cstmr_dep_sqlplus_sid/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;
set serveroutput on;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
CUST_DEP_BATCH_PKG.DAILY_NET_BAL_CLOSE_DATE_UPD();

EXCEPTION
    WHEN OTHERS THEN        
        DBMS_OUTPUT.PUT_LINE(SQLCODE || ',' || SQLERRM);
        :exitCode:=2;  
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
     echo "Processing Failed for $proc at $TIME on $DATE"
     exit 1;
fi

echo "Processing finished for $proc at ${TIME} on ${DATE}"

exit 0
############################################################################
