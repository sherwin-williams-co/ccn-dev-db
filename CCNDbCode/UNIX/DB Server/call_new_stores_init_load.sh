#!/bin/sh
#################################################################
# Script name   : call_new_stores_init_load.sh
# Description   : This shell script will call the script to  
#                 produce the init loads for store, terr and Param 
# Created       : rxv940 CCN Project Team.....
# Modified      : 
#################################################################
. /app/ccn/host.sh

PROC="call_to_init_loads_sql.sh"
DATE=`date +"%Y-%m-%d"`
TIME=`date +"%H:%M:%S"`

echo " $PROC --> Processing Started at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw <<EOF
set heading off;
set serveroutput on;
set verify off;
var exitCode NUMBER;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1

BEGIN
   POS_DATA_GENERATION.NEW_STORES_INIT_LOAD_PROCESS;

END;
/

EOF

##############################################
#  ERROR STATUS CHECK
##############################################
status=$?
if [ $status -ne 0 ]
then
    ./send_mail.sh "POLLING_FAILURE_MAIL" 
    TIME=`date +"%H:%M:%S"`
    echo " $PROC --> processing failed at ${TIME} on ${DATE}"
    exit 1
fi

TIME=`date +"%H:%M:%S"`
echo " $PROC --> process finished successfully at ${TIME} on ${DATE} "

exit 0