#!/bin/sh
#############################################################################
# Script Name   :  hierarchy_future_to_current.sh
#
# Description   :  This shell program will invoke the procedure that
#                  performs the future to current hierarchy process
#
# Created       :  jxc517 05/05/2016
# Modified      :  gxg192 01/16/2017 1. Added exitCode variable to handle exception
#                                    2. Added WHENEVER clauses
#               :  gxg192 01/26/2017 1. Removed exitCode variable
#                                    2. Changes to send email if process fails
#               :  gxg192 01/31/2017 1. Removed ; after exit command
#               :  sxh487 03/27/2017 Added code to ftp a trigger file to CPR
#               :  mxv711 01/31/2018 ASP-993:added logic to send the trigger file to CPR
#                  even when we have an error.
############################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

proc="hierarchy_future_to_current"
LOGDIR="$HOME/batchJobs"
DATE=`date +"%m/%d/%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`

TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
execute CCN_HIERARCHY_FUT_TO_CURR_PKG.PROCESS();

exit
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if test $status -ne 0
then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"

     cd $HOME
     ./send_mail.sh HIERARCHY_FUT_TO_CURR_ERROR
     status=$?
     TIME=`date +"%H:%M:%S"`
     if test $status -ne 0
     then
        echo "Sending email for $proc FAILED at $TIME on $DATE"
     fi

fi

############################################################################
# Execute ftp_cpr_trigger.sh to send a trigger file to cprdbscriptqa in QA
#                 				    or cprdbscript1 in PROD
############################################################################
cd $HOME/batchJobs
./ftp_cpr_trigger.sh
status=$?
if test $status -ne 0
then
    TIME=`date +"%H:%M:%S"`
    echo "Processing FAILED for ftp_cpr_trigger at ${TIME} on ${DATE}"
    exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"  

exit 0
############################################################################
