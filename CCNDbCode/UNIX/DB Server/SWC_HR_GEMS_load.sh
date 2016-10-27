#!/bin/sh
#################################################################
# script name   : SWC_HR_GEMS_LOAD.sh
#
# description   : script to populate SWC_HR_GEMS_TB from the view 
#                 SWC_HR_GENERIC_V
#
#   Created     : 10/18/2016 SXH487
#   MOdified    : 
#################################################################


# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
proc_name="SWC_HR_GEMS_LOAD"

echo " START DELETING AND LOADING SWC_HR_GEMS_TB : Process Started at $TIME on $DATE "

sqlplus -s -l $sqlplus_user/$sqlplus_pw <<END
set heading off;
set serveroutput on;
set verify off;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
var EXITCODE number;
exec :EXITCODE := 0;
@$HOME/batchJobs/sql/SWC_HR_GEMS_LOAD.sql
print :EXITCODE;
exit :EXITCODE;
END

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if [ $status -ne 0 ]; then
     cd $HOME
     ./send_mail.sh $proc_name
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc_name at $TIME on $DATE"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"

exit 0
############################################################################