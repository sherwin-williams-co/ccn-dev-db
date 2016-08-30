#!/bin/sh
#############################################################################
# Script Name   :  update_marketing_fields.sh
#
# Description   :  This shell program will invoke the procedure from the backend to 
#                   update two new columns in COST_CENTER table
#
# Created       :  axd783 08/30/2016
############################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

 proc_name="UPDATE_MARKETING_FIELDS"
 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m%d%Y"`

echo "Processing Started for $proc_name at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $HOME/$proc_name"_"$DATE.log <<END
set heading off;
set verify off;

execute INITLOAD.UPDATE_MARKETING_FIELDS();

exit;
END
############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0

############################################################################

