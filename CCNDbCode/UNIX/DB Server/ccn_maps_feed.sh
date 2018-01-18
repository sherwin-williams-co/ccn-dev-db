#!/bin/sh
###############################################################################################################################
# Script name   : ccn_maps_feed.sh
#
# Description   : This script is to run the following:
#                 CCN_MAPS_FEED_PKG.GENERATE_MAPS_CSV_FILE
#
# Created  : 01/18/2018 mxv711 CCN Project Team.....
# 
###############################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/ccn/host.sh

proc="ccn_maps_feed"
LOGDIR="$HOME"
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

execute CCN_MAPS_FEED_PKG.GENERATE_MAPS_CSV_FILE();

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
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"

exit 0
#######################################################################################################################
