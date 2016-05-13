#!/bin/sh

##########################################################################################
# Script Name  : POS_XML_IFACE_IntialLoad.sh
# Date Created : 09/18/2015 AXK326/DXV848 run the  POS_XML_IFACE_IntialLoad.sql one time run.
#
##########################################################################################

echo "Starting  POS_XML_IFACE_LOCAL.sh script"

# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

# establish parameter names for this script
PROC="POS_XML_IFACE_InitialLoad.sql"

# establish the date and time
DATE=`date +"%Y-%m-%d"`
TIME=`date +"%H:%M:%S"`


echo "\nProcessing Started for $PROC at $TIME on $DATE"
sqlplus -s -l $sqlplus_user/$sqlplus_pw <<END
set heading off;
set serveroutput on;
set verify off;

@$HOME/batchJobs/sql/$PROC
 
exit;
END

echo "return from $PROC"

TIME=`date +"%H:%M:%S"`
##############################################
#  ERROR STATUS CHECK
##############################################
status=$?
if test $status -ne 0
   then
     
     echo "processing of $PROC failed at ${TIME} on ${DATE}"
     exit 1
else
   echo "processing of $PROC Successful at ${TIME} on ${DATE} "
fi

echo "ending for $PROC at $TIME on $DATE"

exit 0

############################################################################
#                     END  of  PROGRAM  
############################################################################

