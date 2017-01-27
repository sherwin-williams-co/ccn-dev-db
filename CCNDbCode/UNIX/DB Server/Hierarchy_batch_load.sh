#!/bin/sh

##########################################################################################
# Script Name : Hierarchy_batch_load.sh
# Description : Purpose of this script is to invoke HIERARCHY_BATCH_PKG.HIERARCHY_BATCH_PROCESS
#               at Daily base.
#
# Date Created: 10/02/2015 SXT410
# Date Updated: 01/13/2017 gxg192 Changes for exception handling
#             : 01/26/2017 gxg192 1. Removed exitCode variable
#                                 2. Changes to send email if process fails
##########################################################################################

# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

exec &> Hierarchy_batch_load_$(date '+%Y%m%d%H%M%S').log

echo "Begin Hierarchy_batch_load.sh script"

proc="HIERARCHY_BATCH_PKG.HIERARCHY_BATCH_PROCESS"

echo "Processing Started for $proc at $(date '+%H:%M:%S') on $(date '+%H:%M:%S')"

sqlplus -s -l $sqlplus_user/$sqlplus_pw <<END
set heading off;
set verify off;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
execute HIERARCHY_BATCH_PKG.HIERARCHY_BATCH_PROCESS();

execute MAIL_PKG.SEND_MAIL('HIERARCHY_BATCH_END', null, null, null);

exit;
END

#############################################################################
##                           ERROR STATUS CHECK 
#############################################################################
status=$?
if test $status -ne 0
then
     echo "Processing FAILED for $proc at $(date '+%H:%M:%S') on $(date '+%H:%M:%S')"

     cd $HOME
     ./send_mail.sh HIERARCHY_BATCH_ERROR
     status=$?
     TIME=`date +"%H:%M:%S"`
     if test $status -ne 0
     then
        echo "Sending email for $proc FAILED at $TIME on $DATE"
     fi

     exit 1;
fi

echo "Processing finished for $proc at $(date '+%H:%M:%S') on $(date '+%H:%M:%S')" 

echo "End of Hierarchy_batch_load.sh script"

exit 0

############################################################################
