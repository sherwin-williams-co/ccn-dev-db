#!/bin/sh
cd /app/ccn/dev/batchJobs
###############################################################################################################################
# Script name   : generate_store_bank_card_file.sh
#
# Description   : This script is to run the following:
#                 CCN_CLEANSING_ADDRESS_PKG.CCN_CLEANSING_ADDRESS
#
# Created  : 07/09/2018 pxa852 CCN Project Team.....
###############################################################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

proc="ccn_cleansing_address"
LOGDIR="$HOME/batchJobs"
DATE=`date +"%m/%d/%Y"`
RUNDATE=`date --date="yesterday" +%m/%d/%Y`
TimeStamp=`date '+%Y%m%d%H%M%S'`

TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc at $TIME on $DATE" >> $LOGDIR/$proc"_"$TimeStamp.log

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;
set serveroutput on;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1

DECLARE
BEGIN
	:exitCode := 0;
	CCN_CLEANSING_ADDRESS_PKG.CCN_CLEANSING_ADDRESS();
Exception
when others then
          :exitCode := 1;
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
   TIME=`date +"%H:%M:%S"`
   echo "processing FAILED for $proc at ${TIME} on ${DATE}" >> $LOGDIR/$proc"_"$TimeStamp.log

   cd $HOME/
   ./send_mail.sh CCN_CLEANSING_ERROR 

   echo "processing FAILED for $proc at ${TIME} on ${DATE}" 

   exit 1
fi

TIME=`date +"%H:%M:%S"`
echo "Process to create/update standardized address executed successfully at ${TIME} on ${DATE}" >> $LOGDIR/$proc"_"$TimeStamp.log

exit 0
#######################################################################################################################
