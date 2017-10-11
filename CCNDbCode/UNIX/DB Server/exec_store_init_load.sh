#!/bin/sh
#################################################################
# Script name   : exec_store_init_loads.sh
# Description   : This shell script will call the script to  
#                 produce the init loads for store
# Created       : 10/10/2017 rxv940 CCN Project Team.....
# Modified      : 
#################################################################
. /app/ccn/host.sh
PROC="exec_store_init_loads.sh"
DATE=`date +"%Y-%m-%d"`
TIME=`date +"%H:%M:%S"`
LOGDIR=$HOME/datafiles/log
LOGFILE=exec_store_init_loads.log

echo " $PROC --> Processing Started at $TIME on $DATE" >> $LOGDIR/$LOGFILE
sqlplus -s -l $ccn_utility_un/$ccn_utility_pwd <<EOF
set heading off;
set serveroutput on;
set verify off;
var exitCode NUMBER;
var exitCode NUMBER;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1

BEGIN
    :exitCode := 0;
    POS_DATA_GENERATION.INIT_LOAD_STORE_SP();
	
Exception
when others then
    :exitCode := 1;

END;
/

EOF

##############################################
#  ERROR STATUS CHECK
##############################################
status=$?
if [ $status -ne 0 ]
then
    ./send_mail.sh "POLLING_FAILURE_MAIL" "Error while processing the Init load for Store from exec_store_init_loads.sh "
    TIME=`date +"%H:%M:%S"`
    echo " $PROC --> processing failed at ${TIME} on ${DATE}" >> $LOGDIR/$LOGFILE
    exit 1
fi

TIME=`date +"%H:%M:%S"`
echo " $PROC --> process finished successfully at ${TIME} on ${DATE} " >> $LOGDIR/$LOGFILE 

exit 0
