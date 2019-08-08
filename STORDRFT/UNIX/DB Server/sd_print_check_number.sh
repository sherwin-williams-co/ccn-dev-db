#!/bin/sh

####################################################################################################
# Script Name : sd_print_check_number.sh
#
# purpose of this script will be to print checks if count of unused checks reach to threshold value
#
# Date Created: 08/05/2019 akj899 CCNSD-8 CCN Project Team.....
# Date Updated: 
#
#
##########################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc="sd_print_check_number"
LOGDIR="$HOME/batchJobs"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc.log <<END

set heading off;
set serveroutput on;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
SD_CHECK_NBR_PRINT_SRVCS.SD_CHECK_NBR_PRINT_BATCH_PROCESS();
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
if test $status -ne 0
then
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"

exit 0
############################################################################
