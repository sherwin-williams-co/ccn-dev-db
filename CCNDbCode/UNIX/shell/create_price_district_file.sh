#!/bin/sh
#############################################################################
# Script Name   :  create_price_district_file.sh
#
# Description    :  This shell program will initiate the PRICE_DIST_HRCHY_LOAD.CREATE_PRICE_DISTRICT_FILE 
#                   to generate the price district file
# 
# Created :  nxk927 09/03/2015
############################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

 proc="create_price_district_file"
 LOGDIR="$HOME/hier"
 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
 TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;

execute PRICE_DIST_HRCHY_LOAD.CREATE_PRICE_DISTRICT_FILE;

exit;
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"  

exit 0

############################################################################

