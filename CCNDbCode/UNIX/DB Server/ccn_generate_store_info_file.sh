#!/bin/sh
###############################################################################################################################
# Script name   : ccn_generate_store_info_file.sh
#
# Description   : This script is to run the genrate the STORE INFO FILE 
#
# Created  : 10/31/2017
# 
###############################################################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

proc="ccn_generate_store_info_file"
LOGDIR="$HOME/batchJobs"
DATE=`date +"%m/%d/%Y"`

TimeStamp=`date '+%Y%m%d%H%M%S'`


TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set serveroutput on;
set heading off;
set verify off;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1

execute CCN_STORE_INFO_TB.GENERATE_CCN_INFO_FILE;

exit;
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
else
   TIME=`date +"%H:%M:%S"`
   echo "Processing finished for $proc at ${TIME} on ${DATE}"
fi

exit 0
#######################################################################################################################
