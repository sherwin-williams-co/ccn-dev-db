#!/bin/sh

##########################################################################################
# Script Name   :  cc_employee_tax_load
#
# purpose of this script will be to load CUSTOMER_TAXID_VW table
#
# Date Created: 07/30/2014 jxc517 CCN Project.....
# Date Updated: 10/02/2014 jxc517 CCN Project.....
#               Modified to get the tax details from synonym in COSTCNTR schema instead of 
#               synonym in STCPR_READ schema
#
##########################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

proc="cc_employee_tax_load.sh"
LOGDIR=$HOME/initLoad/STORDRFT
FILE=cc_employee_tax_load_ddl.sql
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "\n Processing Started for $proc at $TIME on $DATE \n"

if [ -f $FILE ];
then
   echo "File $FILE exists"
   rm -f -r ./$FILE
else
   echo "File $FILE does not exists"
fi

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> ./$FILE <<END
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

sqlplus -s -l $strdrft_sqlplus_user/$strdrft_sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END

@./$FILE

exit;
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if test $status -ne 0
then
     echo "\n processing FAILED for $proc at ${TIME} on ${DATE}\n"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "\n Processing finished for $proc at ${TIME} on ${DATE}\n"  

exit 0

############################################################################

