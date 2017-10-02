#!/bin/sh
#############################################################################
# Script Name   : cust_dep_initload.sh
#
# Description   : This shell program will do the initLoad for Customer Deposits
#
# Created           :  sxh487 09/28/2017
############################################################################
# below command will get the path for cstmr_dep.config respective to the environment from which it is run
. /app/cstmrdpsts/host.sh

 proc="cust_dep_initload"
 LOGDIR="$HOME/logs"
 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
 TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $proc at $TIME on $DATE "
sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;
set serveroutput on;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
CUSTOMER_DEPOSITS_INITLOAD.CCN_CD_INITLOAD_SP();
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
if test $status -ne 0
then
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"  

exit 0

############################################################################