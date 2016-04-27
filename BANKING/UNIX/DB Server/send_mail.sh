#!/bin/sh
#################################################################
# Script name   : SRA11000_initload.sh #
# Description   : This shell script will perform all the init load process
#
# Created  : 03/04/2016 dxv848/nxk927 CCN Project Team.....
# Modified : 
#################################################################
. /app/banking/dev/banking.config


proc_name=$1;

TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw << END
set heading off;
set verify off;
execute MAIL_PKG.send_mail('$1');
exit;
END

############################################################################
#                           ERROR STATUS CHECK
############################################################################

TIME=`date +"%H:%M:%S"`
status=$?
if test $status -ne 0
then
    echo "processing FAILED for Sending Mail at ${TIME} on ${DATE}"
    exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing Finished for $proc at ${TIME} on ${DATE}"
exit 0

############################################################################