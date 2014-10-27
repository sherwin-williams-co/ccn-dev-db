#!/bin/sh
#################################################################
# Script name   : cc_employee_tax_load.sh
#
# Description   : purpose of this script will be to load CUSTOMER_TAXID_VW table
#
# Created  : 07/30/2014 jxc517 CCN Project Team.....
# Modified : 10/10/2014 jxc517 CCN Project Team.....
#            Modified to get the tax details from synonym in COSTCNTR schema instead of 
#            synonym in STCPR_READ schema
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="cc_employee_tax_load"
LOGDIR=$HOME/dailyLoad/logs
FILE=cc_employee_tax_load_ddl.sql
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
echo "Processing Started for $proc_name at $TIME on $DATE"

if [ -f $FILE ];
then
   echo "File $FILE exists"
   rm -f -r ./$FILE
else
   echo "File $FILE does not exists"
fi

sqlplus -s -l $costcntr_sqlplus_user/$costcntr_sqlplus_pw >> ./$FILE <<END
set echo off
set linesize 1000
set feedback off
set heading off
set verify off
set scan off

SELECT 'SET DEFINE OFF;' FROM DUAL;
SELECT 'TRUNCATE TABLE CUSTOMER_TAXID_VW;' FROM DUAL;
SELECT 'INSERT INTO CUSTOMER_TAXID_VW VALUES ('''||CUSTNUM||''','''||TAXID||''','''||PARENT_STORE||''','''||REPLACE(CUSTNAME,'''','''''')||''','''||DCO_NUMBER||''');' FROM CUSTOMER_TAXID_VW;
SELECT 'COMMIT;' FROM DUAL;

exit;
END

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END

@./$FILE

exit;
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################
