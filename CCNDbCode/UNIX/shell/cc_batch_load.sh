#!/bin/sh

##########################################################################################
#
# purpose of this script will be to invoke COST_CENTER_UPLOAD.BATCH_LOAD_PROCESS
#
# Date Created: 11/01/2013 JXC
# Date Updated: 
#
##########################################################################################
echo "\n begin cc_batch_load.sh script"

# below command will get the path for ccn.config respective to the environment from which it is run from
. `cut -d/ -f1-4 <<<"${PWD}"`/ccn.config

proc="COST_CENTER_UPLOAD.BATCH_LOAD_PROCESS"
LOGDIR="$HOME/hier"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`


ORACLE_HOME=/swpkg/oracle/product/stccn/11.2.0.3
export ORACLE_HOME 

ORACLE_SID=STCCND1
export ORACLE_SID

echo "\n Processing Started for $proc at $TIME on $DATE \n"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;

execute MAIL_PKG.send_mail('CC_BATCH_LOAD_START');
execute  COST_CENTER_UPLOAD.BATCH_LOAD_PROCESS();
execute MAIL_PKG.send_mail('CC_BATCH_LOAD_END');
 
exit;
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if test $status -ne 0
then
     echo "\n processing FAILED for $proc at ${TIME} on ${DATE}\n"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "\n Processing finished for $proc at ${TIME} on ${DATE}\n"  

exit 0

############################################################################

