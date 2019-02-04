#!/bin/sh

##########################################################################################
# Script Name : release_timed_out_objects.sh
#
# purpose of this script will be to release any locks left over in the database
#
# Date Created: 11/13/2014 jxc517 CCN Project Team.....
# Date Updated: 01/16/2017 gxg192 1. Added :exitCode variable to handle exception
#                                 2. Added WHENEVER clauses
#             : 01/26/2017 gxg192 Removed :exitCode variable
#             : 01/31/2017 gxg192 Removed exit command in error status check
#             : 01/31/2019 mxs216 Changed this process to unlock every 5 minutes instead of 15 minutes
#             : 02/04/2019 mxs216 Removed timestamp from the log file name.
##########################################################################################

# below command will get the path for config respective to the environment from which it is run from
. /app/ccn/host.sh

 proc="release_timed_out_objects"
 LOGDIR="$HOME/batchJobs"
 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
 TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc.log <<END
set heading off;
set verify off;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
execute CCN_RESTRICTION_PKG.RELEASE_TIMED_OUT_OBJECTS(CCN_RESTRICTION_PKG.P_RELEASE_TIMED_OUT_MINS);

exit
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"

     cd $HOME
     ./send_mail.sh RLS_TIMED_OUT_OBJ_ERROR
     status=$?
     TIME=`date +"%H:%M:%S"`
     if test $status -ne 0
     then
        echo "Sending email for $proc FAILED at $TIME on $DATE"
     fi

fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"

############################################################################
