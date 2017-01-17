#!/bin/sh

##########################################################################################
# Script Name : release_timed_out_objects.sh
#
# purpose of this script will be to release any locks left over in the database
#
# Date Created: 11/13/2014 jxc517 CCN Project Team.....
# Date Updated: 01/16/2017 gxg192 Added :exitCode variable to handle exception
##########################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

 proc="release_timed_out_objects"
 LOGDIR="$HOME/batchJobs"
 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
 TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
exec :exitCode := 0;
execute CCN_RESTRICTION_PKG.RELEASE_TIMED_OUT_OBJECTS(15);

exit :exitCode;
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

############################################################################

