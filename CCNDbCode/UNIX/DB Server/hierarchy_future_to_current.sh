#!/bin/sh
#############################################################################
# Script Name   :  hierarchy_future_to_current.sh
#
# Description   :  This shell program will invoke the procedure that
#                  performs the future to current hierarchy process
#
# Created       :  jxc517 05/05/2016
# Modified      :  gxg192 01/16/2017 Added exitCode variable to handle exception
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
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
:exitCode := 0;
execute CCN_HIERARCHY_FUT_TO_CURR_PKG.PROCESS();

exit :exitCode;
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if test $status -ne 0
then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"  

exit 0
############################################################################
