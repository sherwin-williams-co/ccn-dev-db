#!/bin/sh

##########################################################################################
#
# purpose of this script will be to load CUSTOMER_TAXID_VW table
#
# Date Created: 07/30/2014 JXC
# Date Updated: 
#
##########################################################################################
echo "\n begin cc_batch_load.sh script"

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

ORACLE_HOME=/swpkg/oracle/product/starcprd/11.2.0.3
export ORACLE_HOME 

ORACLE_SID=STARCPRD1
export ORACLE_SID

sqlplus -s -l $cpr_sqlplus_user/$cpr_sqlplus_pw >> ./$FILE <<END
set echo off
set linesize 1000
set feedback off
set heading off
set verify off
set scan off

SELECT 'SET DEFINE OFF;' FROM DUAL;
SELECT 'TRUNCATE TABLE CUSTOMER_TAXID_VW;' FROM DUAL;
--SELECT 'TRUNCATE TABLE JAVA_ENCRYPT;' FROM DUAL;
SELECT 'INSERT INTO CUSTOMER_TAXID_VW VALUES ('''||CUSTNUM||''','''||TAXID||''','''||PARENT_STORE||''','''||REPLACE(CUSTNAME,'''','''''')||''','''||DCO_NUMBER||''');' FROM CUSTOMER_TAXID_VW;
--SELECT 'INSERT INTO JAVA_ENCRYPT VALUES ('''||VALUE||''');' FROM JAVA_ENCRYPT;
SELECT 'COMMIT;' FROM DUAL;

exit;
END

ORACLE_HOME=/swpkg/oracle/product/stccn/11.2.0.3
export ORACLE_HOME 

ORACLE_SID=STCCND1
export ORACLE_SID

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

