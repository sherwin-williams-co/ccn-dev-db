#!/bin/sh
#############################################################################
# Script Name    :  POS_FILE_GEN.sh
#
# Description    :  This shell program will invoke the procedure from the backend to 
#                   generate the POS file
#
# Created        :  AXK326/DXV848 09/04/2015
############################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

 proc="POS_FILE_GEN"
 LOGDIR="$HOME/batchJobs"
 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
 TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;

execute POS_XML_IFACE_FILE.CREATE_POS_FILE();

exit;
END

TIME=`date +"%H:%M:%S"`
############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1
fi

echo "Processing finished for $proc at ${TIME} on ${DATE}"  

exit 0

############################################################################
#                     END  of  PROGRAM  
############################################################################


