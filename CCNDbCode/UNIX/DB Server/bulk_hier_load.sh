#!/bin/sh

##########################################################################################
#
# purpose of this script will be to bulk transfer cost centers from one hierarchy to another
#
# Date Created: 01/16/2014 JXC517
# Date Updated: 
#
##########################################################################################

echo "\n begin bulk_hier_load.sh script"

# link to parameter file
. /app/ccn/ccn.config

# establish the date and time
DATE=`date +"%Y-%m-%d"`
TIME=`date +"%H:%M:%S"`

ORACLE_HOME=/swstores/oracle/stcprp/product/11g
export ORACLE_HOME

ORACLE_SID=STCPRP1
export ORACLE_SID

PATH=$PATH:$ORACLE_HOME/bin 
export PATH

echo "\nProcessing Started for $PROC at $TIME on $DATE"
$ORACLE_HOME/bin/sqlplus -s -l $sqlplus_user/$sqlplus_pw <<END
set heading off;
set serveroutput on;
set verify off;

DECLARE
   V_BATCH_NUMBER      BATCH_JOB.BATCH_JOB_NUMBER%TYPE;
   V_TRANS_STATUS      BATCH_JOB.TRANS_STATUS%TYPE := 'SUCCESSFUL';
BEGIN
   CCN_BATCH_PKG.INSERT_BATCH_JOB('BULK_HIER_TRNSFR', V_BATCH_NUMBER);
   CCN_BATCH_PKG.LOCK_DATABASE_SP(); -- PRAGMA AUTONOMOUS_TRANSACTION;
   CCN_HIERARCHY.HIERARCHY_BULK_TRNSFR_PROCESS();
   CCN_BATCH_PKG.UPDATE_BATCH_JOB('BULK_HIER_TRNSFR', V_BATCH_NUMBER, V_TRANS_STATUS);
   CCN_BATCH_PKG.UNLOCK_DATABASE_SP(); -- PRAGMA AUTONOMOUS_TRANSACTION;
END;
/
 
exit;
END

echo "\n return from $PROC \n"

##############################################
#  ERROR STATUS CHECK
##############################################
status=$?
if test $status -ne 0
   then
     TIME=`date +"%H:%M:%S"`
     echo "\n processing of $PROC failed at ${TIME} on ${DATE}"
     exit 1;
else
   echo "\n processing of $PROC completed successfully at ${TIME} on ${DATE}"
fi

echo "\n ending bulk_hier_load.sh script \n"

##############################
#  end of script             #
##############################
