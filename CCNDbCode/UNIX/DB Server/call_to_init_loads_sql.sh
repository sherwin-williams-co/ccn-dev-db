#!/bin/sh

##########################################################################################
# Script name   : call_to_init_loads_sql.sh
# Description   : This shell script will call the script to  
#                 produce the init loads for store, terr and Param 
# Created       : rxv940 CCN Project Team.....
# Modified      :
#
##########################################################################################

# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

# establish parameter names for this script

PROC="call_to_init_loads_sql.sh"


# establish the date and time
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
   POS_DATA_GENERATION.INIT_LOAD_STR_TERR_PARAM_SP();

END;
/

EOF

##############################################
#  ERROR STATUS CHECK
##############################################
status=$?
if [ $status -ne 0 ]
then
    DATE=`date +"%Y-%m-%d"`
    TIME=`date +"%H:%M:%S"`
    echo " $PROC --> processing failed at ${TIME} on ${DATE}"
    ./send_mail.sh "POLLING_FAILURE_MAIL" 
    exit 1
else
    DATE=`date +"%Y-%m-%d"`
    TIME=`date +"%H:%M:%S"`
    echo " $PROC --> process finished successfully at ${TIME} on ${DATE} "
fi


##############################
#  end of script             #
##############################

